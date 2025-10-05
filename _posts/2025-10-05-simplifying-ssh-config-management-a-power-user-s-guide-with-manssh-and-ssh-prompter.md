---
layout: single
title: 'Simplifying SSH Config Management: A Power User''s Guide with manssh and ssh-prompter'
date: 2025-10-05 13:18 +0700
description: "Managing SSH configurations can quickly become overwhelming as your infrastructure grows. Whether you're a DevOps engineer, developer, or system administrator, keeping your SSH config organized and accessible is crucial. This guide introduces two powerful tools—manssh and ssh-prompter—that dramatically streamline SSH config management and enhance your workflow."
comments: true
toc: true
toc_sticky: true
categories:
- Technology
- Level Beginner
tags:
- SSH
header:
  image: /assets/images/ssh-tools.jpg
  image_description: https://unsplash.com/photos/assorted-color-lockers-VLaKsTkmVhk
---

Managing SSH configurations can quickly become overwhelming as your infrastructure grows. Whether you're a DevOps engineer juggling dozens of servers, a developer working across multiple environments, or a system administrator maintaining various client systems, **keeping your SSH config organized and accessible is crucial for productivity**.

Today, I'll share my workflow using two powerful tools that have transformed how I manage and connect to remote servers: **manssh** and **ssh-prompter**.

---

## The SSH Config Challenge

If you've been working with remote servers for any length of time, your `~/.ssh/config` file has probably evolved from a simple list of a few hosts to a sprawling document with dozens (or hundreds) of entries. You might find yourself:

- Scrolling through endless lines trying to remember that one server's alias
- Manually editing config files and worrying about syntax errors
- Struggling to organize hosts logically as your infrastructure grows
- Typing long SSH commands because you can't remember the exact alias

**This is where the combination of `manssh` and `ssh-prompter` becomes a game-changer.**

---

## The Dynamic Duo: manssh + ssh-prompter

### manssh: Your SSH Config Manager

`manssh` is a command-line tool that treats your SSH config like a database you can query and modify. Instead of manually editing `~/.ssh/config`, you use simple commands to add, update, list, and delete SSH aliases.

**Key Features:**

- **No dependencies**  
  _Pure Go implementation_
- **Backup support**  
  _Never lose your configurations_
- **Include directive support**  
  _Works with modular SSH configs_
- **Query capabilities**  
  _Search and filter your hosts easily_

---

### ssh-prompter: Your SSH Connection Interface

`ssh-prompter` provides a beautiful Terminal User Interface (TUI) that makes connecting to servers as simple as typing a few characters. It reads directly from your SSH config file (the same one manssh manages) and presents an interactive, searchable list of all your hosts.

**Key Features:**

- **Instant search**  
  _Find hosts as you type_
- **Folder grouping**  
  _Organize hosts hierarchically_
- **TMUX integration**  
  _Automatically renames windows with host names_
- **Zero configuration**  
  _Works directly with your existing SSH config_

---

## Setting Up Your SSH Management Workflow

### Installing manssh

```
brew tap xwjdsh/tap
brew install xwjdsh/tap/manssh
```

### Installing ssh-prompter

Go to the releases page and download the correct one based on your machine:  
[https://github.com/azlux/ssh-prompter/releases](https://github.com/azlux/ssh-prompter/releases)  
and move it to your `$PATH` folder.

---

## Organizing Hosts with Folders

`ssh-prompter` supports folder organization. You can structure your hosts hierarchically:

```
# Using manssh with folder notation
manssh add production/web-01 root@10.0.2.1
manssh add production/web-02 root@10.0.2.2
manssh add staging/web-01 root@10.0.3.1
manssh add development/local-vm root@192.168.1.100
```

Or add a Folder option to existing hosts:
```
manssh update k8s-master -c Folder=kubernetes
manssh update k8s-worker1 -c Folder=kubernetes
```

---

## Querying and Managing Existing Configs

```
# List all hosts
manssh list

# Search for specific hosts
manssh list k8s

# List all production servers (with wildcard)
manssh list "production/*"

# Update a host's configuration
manssh update staging/web-01 -c Port=2222

# Rename an alias
manssh update old-name -r new-name

# Delete hosts you no longer need
manssh delete temp-server test-vm
```

---

## Connecting with ssh-prompter

Once your hosts are configured with manssh, connecting is effortless:

1. Type `sshp`
2. Start typing to search for your host
3. Use arrow keys to navigate
4. Press Enter to connect

The TUI interface shows your organized folder structure, making it easy to navigate even with hundreds of hosts.

---

## Conclusion

What's your SSH management workflow? Have you tried these tools or have other favorites?  
*Share your experiences and tips in the comments below!*

- [ssh-prompter GitHub](https://github.com/azlux/ssh-prompter)
- [manssh GitHub](https://github.com/xwjdsh/manssh)