---
layout: single
title: "How to Improve Jekyll Build Time in a VSCode Devcontainer"
date: 2023-07-29
comments: true
categories:
  - VSCode
  - Jekyll
  - DevOps
tags:
  - devcontainer
  - docker
  - build optimization
header:
    image: /assets/images/jekyll-vscode.jpg
---

Running Jekyll in a Visual Studio Code (VSCode) Devcontainer can significantly streamline your blogging workflow. However, a common issue developers face is the time to build the environment due to gem installation.
Fortunately, there's a solution that involves tweaking your devcontainer configuration and utilizing a Dockerfile. Here, we'll walk you through the process.

# Optimized VSCode Devcontainer Configuration
Firstly, let's look at the modified devcontainer configuration. This configuration uses a custom Docker image and executes the `bundle exec jekyll serve -D -l` command after creating the container.

```json
{
    "name": "Ruby",
    "build": {
         "dockerfile": "./Dockerfile",
         "context": "../"
     },
    "features": {
        "ghcr.io/devcontainers/features/common-utils:2": {
            "installZsh": "true",
            "username": "vscode",
            "userUid": "1000",
            "userGid": "1000",
            "upgradePackages": "true"
        },
    },
    "customizations": {
        "vscode": {
            "extensions": [
                "rebornix.Ruby"
            ]
        }
    },
	"forwardPorts": [4000],
	"postCreateCommand": "bundle exec jekyll serve -D -l",
    "remoteUser": "vscode"
}
```

# Dockerfile for the Custom Docker Image

Create a `Dockerfile` file in `.devcontainer` folder using the with following code to installs the necessary packages and Ruby gems to run Jekyll.

```Dockerfile
ARG VARIANT=3-alpine
FROM ruby:${VARIANT}

RUN apk --no-cache add \
  zlib-dev \
  libffi-dev \
  build-base \
  libxml2-dev \
  imagemagick-dev \
  readline-dev \
  libxslt-dev \
  libffi-dev \
  yaml-dev \
  zlib-dev \
  vips-dev \
  vips-tools \
  sqlite-dev \
  cmake

RUN apk --no-cache add \
  readline \
  nodejs \
  bash \
  npm \
  yarn

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
```

After the build is complete, change devcontainer configuration to use the Docker image.

```
docker images
```

on my machine the output is like this

```
REPOSITORY                                                                                    TAG          IMAGE ID       CREATED          SIZE
vsc-saiqulhaq-183e332838d7ef9168b603268227e5262a6728bb2865d53440b5c840bef5f10c-features-uid   latest       c1543070b14a   28 minutes ago   899MB
vsc-saiqulhaq-183e332838d7ef9168b603268227e5262a6728bb2865d53440b5c840bef5f10c-features       latest       1e528d6df1f2   28 minutes ago   899MB
vsc-saiqulhaq-183e332838d7ef9168b603268227e5262a6728bb2865d53440b5c840bef5f10c-uid            latest       40e20a04fffb   30 minutes ago   898MB
vsc-saiqulhaq-183e332838d7ef9168b603268227e5262a6728bb2865d53440b5c840bef5f10c                latest       aa04760fc1d0   30 minutes ago   898MB
```

After that change the devcontainer configuration to use the docker image instead:

```json
{
    "image": "vsc-saiqulhaq-183e332838d7ef9168b603268227e5262a6728bb2865d53440b5c840bef5f10c",
    // "build": {
    //      "dockerfile": "./Dockerfile",
    //      "context": "../"
    //  },
    ...
}

```

This optimizes setup takes 10 seconds to run the jekyll server on my machine

```
Running the postCreateCommand from devcontainer.json...

[10039 ms] Start: Run in container: /bin/sh -c bundle exec jekyll serve -D -l
WARNING: Nokogiri was built against libxml version 2.10.3, but has dynamically loaded 2.11.4
Configuration file: /workspaces/saiqulhaq/_config.yml
            Source: /workspaces/saiqulhaq
       Destination: /workspaces/saiqulhaq/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
       Jekyll Feed: Generating feed for posts
 Auto-regeneration: enabled for '/workspaces/saiqulhaq'
LiveReload address: http://127.0.0.1:35729
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
        LiveReload: Browser connected
```

You may check the latest implementation example on [my repository here]({{ "https://github.com/saiqulhaq/saiqulhaq/tree/master/.devcontainer" | bitly }}).
The downside of this implementation is we need to clear