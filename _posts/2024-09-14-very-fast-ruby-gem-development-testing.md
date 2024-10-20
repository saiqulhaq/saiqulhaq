---
layout: single
title: "Gemdock: Streamlining Ruby Gem Development and Testing"
comments: true
toc: true
toc_sticky: true
date: 2024-09-14 13:45 +0700
categories: 
  - Technology
  - Level General
tags: 
  - Ruby
  - Rubygem
  - Docker
---

As Ruby developers, we often face challenges when developing and testing gems across multiple Ruby versions and dependencies. Today, I'm excited to introduce Gemdock, a new tool designed to simplify and accelerate this process.

### The Genesis of Gemdock

The inspiration for Gemdock came while working on a pull request for the faraday-httpclient gem. The task required supporting an older Faraday version while ensuring compatibility with Ruby versions from 2.6 to 3.3. This scenario highlighted the need for a more efficient development and testing workflow.

### Challenges with Existing Tools

Initially, I experimented with the Act tool (https://github.com/nektos/act) combined with Appraisals to set up gemfiles for various Faraday and Ruby versions. However, this approach proved to be time-consuming due to Act's lack of caching for bundle install operations.

### Enter Gemdock

In search of a solution to speed up development, I discovered Dip (https://github.com/bibendi/dip). While Dip is designed for general use cases, I saw an opportunity to create a specialized tool for gem development. Thus, Gemdock was born.

### Key Features of Gemdock

Gemdock leverages Dip's functionality to provide a streamlined workflow for gem developers. Here's how it works:

1. **Easy Setup**: Initialize your project with a simple command:
   ```
   gemdock init
   ```
   This generates the necessary Dip configuration files.

2. **Quick Provisioning**: Set up your development environment with:
   ```
   gemdock provision
   ```
   This runs the Docker Compose installation.

3. **Effortless Testing**: Run your test suite with:
   ```
   gemdock run rspec
   ```

4. **Flexible Ruby Version Switching**: Need to test on a different Ruby version? It's as simple as:
   ```
   gemdock update 2.7
   gemdock provision
   ```
   Now, `gemdock run rspec` will use Ruby 2.7.

### Benefits of Using Gemdock

- **Speed**: Gemdock significantly reduces the time needed for setting up and switching between different Ruby versions and dependencies.
- **Consistency**: Ensures a consistent development environment across different machines.
- **Simplicity**: With just a few commands, you can manage complex testing scenarios.
- **Flexibility**: Easily test your gem against multiple Ruby versions and dependency combinations.

### Getting Started

Gemdock is available as a Ruby gem. You can install it with:

```
gem install gemdock
```

For more information and detailed usage instructions, visit the GitHub repository: https://github.com/saiqulhaq/gemdock

### Conclusion

Gemdock aims to simplify the lives of Ruby gem developers by providing a fast, efficient, and flexible tool for development and testing. By streamlining the process of working with multiple Ruby versions and dependencies, Gemdock allows developers to focus more on writing great code and less on managing development environments.

We're excited to see how the Ruby community will use and contribute to Gemdock. Give it a try in your next gem project and let us know what you think!