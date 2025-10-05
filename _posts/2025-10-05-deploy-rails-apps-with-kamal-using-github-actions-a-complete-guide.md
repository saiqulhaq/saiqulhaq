---
layout: single
title: 'Deploy Rails Apps with Kamal Using GitHub Actions: A Complete Guide'
description: Deploying Rails applications has never been easier thanks to Kamal (formerly
  MRSK) and GitHub Actions. In this post, I’ll share working examples of how to set
  up automated deployments that will save you time and reduce deployment friction
comments: true
toc: true
toc_sticky: true
categories:
- Technology
- Level Beginner
tags:
- Jekyll
- Github Action
header:
  image: "/assets/images/kamal-github-action.jpg"
  image_description: Kamal + Github Action deployment
date: 2025-10-05 15:13 +0700
---
Deploying Rails applications has never been easier thanks to **Kamal** (formerly MRSK) and **GitHub Actions**. In this post, I'll share working examples of how to set up automated deployments that will save you time and reduce deployment friction. Whether you're deploying to a single server or managing multiple environments, this guide has you covered.  

Kamal  
brings Docker-powered deployments to Rails without the complexity of Kubernetes. Combined with  
GitHub Actions, you get:

- **Zero-downtime deployments** with automatic health checks  
- **Push-to-deploy** workflows from your main branch  
- **Multi-environment support** (staging, production)  
- **Built-in rollback** capabilities  
- **No vendor lock-in** – deploy to any VPS

## Github Action Script

### Example 1

Here’s a straightforward GitHub Actions workflow that deploys whenever you push to the main branch (by nbakush):

```yaml
name: Deploy main branch
concurrency:
  group: production
  cancel-in-progress: true
on:
  push:
    branches:
      - main
  # or manually
  workflow_dispatch:
    # Required for secrets.GITHUB_TOKEN
permissions:
  packages: write
  contents: read
jobs:
  deploy:
    name: deploy
    runs-on: ubuntu-latest
    env:
      KAMAL_REGISTRY_PASSWORD: ${{ secrets.KAMAL_REGISTRY_PASSWORD }}
      KAMAL_REGISTRY_USERNAME: ${{ secrets.KAMAL_REGISTRY_USERNAME }}
    strategy:
      matrix:
        node-version: [18.x]
    steps:
      - name: Push to Github Container Repository
        uses: Clipr-Group/ghcr-action@v1
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          platforms: linux/amd64,linux/arm64
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3.0
          bundler-cache: true
      - name: Install Kamal
        run: gem install kamal
      - name: Connect to Tailscale (Optional)
        uses: tailscale/github-action@v3
        with:
          authkey: ${{ secrets.TAILSCALE_AUTHKEY }}
      - name: Release kamal lock
        run: kamal lock release
      - name: Run deploy command
        run: kamal deploy -P -v --version latest
```

**Key Features of This Setup:**

- **Concurrency control:** Prevents multiple deploys from running simultaneously
- **Multi-platform builds:** Supports both AMD64 and ARM64 architectures
- **Tailscale integration:** Simplifies server access with friendly hostnames
- **Lock release:** Ensures a clean state before deployment

### Example 2

```yaml
name: Deploy with Kamal
on:
  workflow_dispatch:
    inputs:
      environment:
        description: "Environment to deploy to"
        required: true
        default: "production"
        type: choice
        options:
          - production
          - staging
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ github.event.inputs.environment || 'production' }}
    env:
      DOCKER_BUILDKIT: 1
      RAILS_ENV: production
      SERVER_HOST: ${{ secrets.SERVER_HOST }}
      KAMAL_REGISTRY_PASSWORD: ${{ secrets.KAMAL_REGISTRY_PASSWORD }}
      POSTGRES_PASSWORD: ${{ secrets.POSTGRES_PASSWORD }}
      RAILS_MASTER_KEY: ${{ secrets.RAILS_MASTER_KEY }}
      SECRET_KEY_BASE: ${{ secrets.SECRET_KEY_BASE }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.4.4"
          bundler-cache: true
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      - name: Install Kamal
        run: gem install kamal
      - name: Set up SSH
        uses: webfactory/ssh-agent@v0.9.0
        with:
          ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: xxx
          password: ${{ secrets.KAMAL_REGISTRY_PASSWORD }}
      - name: Deploy with Kamal
        run: kamal deploy
```

---

## Kamal Configuration (`config/deploy.yml`)

Here’s a production-ready Kamal configuration that includes a database and Redis:

```yaml
# Name of your application
service: service-name
# Container image
image: xxx/xxx
# Deploy to these servers
servers:
  web:
    - <%= ENV["SERVER_HOST"] %>
proxy:
  app_port: 8000
# Registry configuration
registry:
  username: xxx
  password:
    - KAMAL_REGISTRY_PASSWORD
# Builder configuration
builder:
  arch: amd64
# Environment variables
env:
  clear:
    RAILS_ENV: production
    NODE_ENV: production
    PORT: 8000
    POSTGRES_HOST: service-name-db
    POSTGRES_PORT: 5432
    POSTGRES_DB: dbname
    POSTGRES_USER: username
    REDIS_URL: redis://service-name-redis:6379/1
    REDIS_HOST: service-name-redis
  secret:
    - RAILS_MASTER_KEY
    - SECRET_KEY_BASE
    - POSTGRES_PASSWORD
# Useful aliases
aliases:
  shell: app exec --interactive --reuse "bash"
  console: app exec --interactive --reuse "bin/rails console"
# Accessory services
accessories:
  db:
    image: postgres:16
    host: <%= ENV["SERVER_HOST"] %>
    port: 5432
    env:
      clear:
        POSTGRES_DB: dbname
        POSTGRES_USER: username
      secret:
        - POSTGRES_PASSWORD
    directories:
      - data: /var/lib/postgresql/data
  redis:
    image: redis:latest
    host: <%= ENV["SERVER_HOST"] %>
    port: 6379
    directories:
      - /var/lib/redis: /data
```

---

## Required GitHub Secrets

Configure these secrets in your repository settings:  

**Essential Secrets:**

- `KAMAL_REGISTRY_PASSWORD`: Docker registry password
- `KAMAL_REGISTRY_USERNAME`: Docker registry username (if using Docker Hub)
- `SSH_PRIVATE_KEY`: For server access
- `SERVER_HOST`: Your server’s IP or hostname

**Rails-specific Secrets:**

- `RAILS_MASTER_KEY`: Rails credentials master key
- `SECRET_KEY_BASE`: Rails secret key base
- `POSTGRES_PASSWORD`: Database password

**Optional:**

- `TAILSCALE_AUTHKEY`: For Tailscale VPN access (simplifies server management)

---

## 💡 Pro Tips

1. **Use Tailscale for Simplified Networking**  
   Instead of managing IP addresses, Tailscale lets you use friendly hostnames.  
   *Optional but highly recommended for teams:*

   ```yaml
   - name: Connect to Tailscale
     uses: tailscale/github-action@v3
     with:
       authkey: ${{ secrets.TAILSCALE_AUTHKEY }}
   ```

2. **Implement Deployment Locks**  
   Always release locks to prevent stuck deployments:

   ```yaml
   - name: Release kamal lock
     run: kamal lock release
   ```

3. **Use Concurrency Groups**  
   Prevent deployment collisions:
   ```yaml
   concurrency:
     group: production
     cancel-in-progress: true
   ```

4. **Separate Accessories Configuration**  
   Keep your database and Redis as Kamal accessories for easier management and persistence.

---

Combining Kamal with GitHub Actions provides a robust and cost-effective deployment pipeline that rivals enterprise solutions. You get the simplicity of Heroku-style deploys with the flexibility and control of your own infrastructure.  
The beauty of this setup lies in its simplicity—push your code, and GitHub Actions, along with Kamal, handle the rest. No Kubernetes complexity, no vendor lock-in, just straightforward Docker deployments that work.

---

## 🔗 Resources

- [Kamal Documentation](https://kamal-deploy.org/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)