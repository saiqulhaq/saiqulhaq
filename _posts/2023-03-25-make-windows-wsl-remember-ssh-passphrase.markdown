---
layout: single
title:  "How to make Windows WSL remember our ssh passphrase permanently"
date:   2023-03-24 16:08:40 +0000
comments: true
categories:
  - Technology
  - Beginner
tags:
  - Windows
header:
  image: https://images.unsplash.com/photo-1629654297299-c8506221ca97?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1280&h=300&q=80
---

It's annoying when our Terminal keeps asking us for our SSH passphrase when pushing our Git commit to GitHub/etc.  
Here is a workaround that we can do to fix this issue permanently.

Add this script to your .bashrc or .zshrc file.

```bash
# SSH Agent should be running, once
if ! ps -ef | grep "[s]sh-agent" &>/dev/null; then
    echo Starting SSH Agent
    eval $(ssh-agent -s)
fi

# Add the ssh-key if no keys are added yet
if ! ssh-add -l &>/dev/null; then
    echo Adding keys...
    ssh-add -t 1d
fi
```

reference: https://serverfault.com/questions/672346/straight-forward-way-to-run-ssh-agent-and-ssh-add-on-login-via-ssh