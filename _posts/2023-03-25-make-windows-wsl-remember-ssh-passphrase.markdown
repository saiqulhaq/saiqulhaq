---
layout: single
title:  "How to make Windows WSL remember our ssh passphrase permanently"
date:   2023-03-24 16:08:40 +0000
comments: true
categories:
  - SSH
  - Tips
tags:
  - wsl
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