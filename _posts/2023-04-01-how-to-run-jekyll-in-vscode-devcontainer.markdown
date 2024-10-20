---
layout: single
title: How to Run Jekyll in a VSCode Devcontainer
date: 2023-04-01
comments: true
categories:
  - Technology
  - Level Beginner
tags:
  - Jekyll
  - VSCode
  - Devcontainer
header:
  image: https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1280&q=80&h=300
  image_description: How to Run Jekyll in a VSCode Devcontainer
---

This post will discuss how to run Jekyll in a Visual Studio Code (VSCode) Devcontainer, making it easier to set up your development environment and start blogging.

To get started, create a folder named `.devcontainer` in your project's root directory if it doesn't already exist. Save the following JSON code as a `devcontainer.json` file inside the `.devcontainer` folder.

```json
{
  "name": "Ruby",
  // Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
  "image": "mcr.microsoft.com/devcontainers/ruby:3-bullseye",

  // Features to add to the dev container. More info: https://containers.dev/features.
  // "features": {},

  // Use 'forwardPorts' to make a list of ports inside the container available locally.
  "forwardPorts": [4000],

  // Install required gems
  "onCreateCommand": "bundle install",
  
  // Use 'postCreateCommand' to run commands after creating the container.
  "postCreateCommand": "bundle exec jekyll serve",
  
  // Configure tool-specific properties.
  // "customizations": {},

  // Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
  "remoteUser": "root"
}
```

Once you have the JSON file, 

After adding the `devcontainer.json` file to your project, VSCode will automatically set up the Devcontainer and provide port 4000 for your Jekyll site. To start blogging, open your browser and navigate to [http://localhost:4000](http://localhost:4000).

That's it! You've successfully set up Jekyll in a VSCode Devcontainer, making it easy to manage your blog's development environment.
