---
layout: single
title: Reducing Large Git Repository Size
comments: true
toc: true
toc_sticky: true
categories:
- Technology
- Level General
tags:
- Git
date: 2024-12-25 15:38 +0700
---
Managing large Git repositories is crucial for maintaining performance, storage efficiency, and collaboration ease, especially when dealing with substantial binary files or extensive data. Techniques such as identifying oversized files, using tools like BFG Repo-Cleaner with Docker, and implementing Git Large File Storage (LFS) can significantly reduce repository size and streamline workflows while addressing teams without LFS setup challenges.

## Identifying Large Git Files
Several Git commands and tools can be utilized to identify large files that cause a significant increase in repository size. The `git count-objects -v -H` command provides an overview of the repository size, showing details like the total size and number of objects. [1](https://confluence.atlassian.com/bbkb/how-to-check-your-repository-s-size-and-identify-large-files-1178867192.html)For a more detailed analysis, a combination of Git commands can be used to list the largest files in the repository's history:

```bash
git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 --reverse \
| head -n 10
```

This command sequence identifies the top 10 largest files. [2](https://dmtavt.com/post/2021-04-29_howto-find-large-files-in-git-history/) [3](https://gist.github.com/mcxiaoke/b4bdad5727c9400bbf7d101f27297e86)Additionally, tools like Git Sizer can provide comprehensive metrics about the repository, alerting to potential issues with file sizes or history depth. [4](https://www.blinkops.com/blog/using-git-sizer-to-inform-your-git-repository-management) [5](https://github.blog/developer-skills/github/measuring-the-many-sizes-of-a-git-repository/)Regular maintenance, such as running `git gc`, and proper configuration of the `.gitignore` file are crucial for managing repository size effectively.


---
**Sources:**
- [(1) Check your repository's size and identify large files | Bitbucket Cloud](https://confluence.atlassian.com/bbkb/how-to-check-your-repository-s-size-and-identify-large-files-1178867192.html)
- [(2) How to find large files in Git history: a one-liner - Dmitry Avtonomov](https://dmtavt.com/post/2021-04-29_howto-find-large-files-in-git-history/)
- [(3) Find large files in git repository - GitHub Gist](https://gist.github.com/mcxiaoke/b4bdad5727c9400bbf7d101f27297e86)
- [(4) Optimize Git Repo Management with Git Sizer - Blink Ops](https://www.blinkops.com/blog/using-git-sizer-to-inform-your-git-repository-management)
- [(5) Measuring the many sizes of a Git repository - The GitHub Blog](https://github.blog/developer-skills/github/measuring-the-many-sizes-of-a-git-repository/)


## Using BFG with Docker
For users with Docker installed, BFG Repo-Cleaner can be utilized without a local Java installation. The `koenrh/bfg` Docker image provides a convenient way to run BFG in an isolated container. To use it, first pull the image with `docker pull koenrh/bfg`, then run BFG commands using:

```bash
docker run -it --rm --volume "$PWD:/home/bfg/workspace" koenrh/bfg [BFG arguments]
```

For example, to remove files larger than 100MB, use:

```bash
docker run -it --rm --volume "$PWD:/home/bfg/workspace" koenrh/bfg --strip-blobs-bigger-than 100M
```

This approach allows for powerful repository cleaning without the need for Java installation, making the process more convenient and isolated [1](https://github.com/koenrh/docker-bfg) [2](https://github.com/ThatcherT/bfg-clean).


---
**Sources:**
- [(1) koenrh/docker-bfg - GitHub](https://github.com/koenrh/docker-bfg)
- [(2) BFG-Clean - Remove secrets from repositories with Docker. - GitHub](https://github.com/ThatcherT/bfg-clean)


## Git LFS Basics
Git Large File Storage (LFS) is an open-source Git extension designed to manage large binary files more efficiently in Git repositories [1](https://git-lfs.com). It addresses the challenge of versioning large files, which can significantly slow down Git operations and bloat repository sizes [2](https://get.assembla.com/blog/git-lfs/).

Git LFS replaces large files with small text pointers in the main repository, while storing the actual file contents on a remote server [1](https://git-lfs.com). This approach offers several benefits:

* Lightweight repositories: The central repository remains small and manageable, resulting in faster cloning and fetching operations [2](https://get.assembla.com/blog/git-lfs/).
* Large file versioning: Users can version files as large as a couple of GB without impacting repository performance [1](https://git-lfs.com).
* Familiar Git workflow: Git LFS integrates seamlessly with existing Git commands and environments [2](https://get.assembla.com/blog/git-lfs/).

To install Git LFS, visit git-lfs.com and download the appropriate version for your operating system [1](https://git-lfs.com). Alternatively, you can use package managers:

* For macOS with Homebrew: `brew install git-lfs`
* For macOS with MacPorts: `port install git-lfs`

After installation, set up Git LFS for your user account by running `git lfs install` in the terminal [1](https://git-lfs.com). This one-time setup enables Git LFS functionality across all your repositories.


---
**Sources:**
- [(1) Git LFS](https://git-lfs.com/)
- [(2) Git LFS: The Pocketbook Explanation - Assembla](https://get.assembla.com/blog/git-lfs/)


## Git LFS Mechanism Explained
Git LFS (Large File Storage) replaces large files in your repository with small pointer files while storing the actual file content on a separate server. When you add a file to Git LFS, it creates a lightweight pointer file in the repository that contains a unique identifier for the large file [1](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage) [2](https://docs.gitlab.com/ee/topics/git/lfs/). This pointer file gets committed and pushed to the Git repository.

The actual large file is uploaded to a separate LFS server, typically hosted alongside your Git repository [3](https://graphite.dev/guides/how-to-use-git-large-file-storage-lfs). When you clone or fetch from the repository, Git LFS downloads only the pointer files by default. The actual large files are downloaded on-demand when you checkout a branch or explicitly request them [4](https://confluence.atlassian.com/bitbucketserver089/git-large-file-storage-1236436513.html) [2](https://docs.gitlab.com/ee/topics/git/lfs/). This approach offers several benefits:

* Reduced repository size, as large binary files are stored separately
* Faster cloning and fetching operations since only pointers are initially downloaded
* Efficient versioning of large files without bloating the Git history
* Seamless integration with existing Git workflows and commands [5](https://get.assembla.com/blog/git-lfs/) [6](https://tilburgsciencehub.com/topics/automation/version-control/advanced-git/git-lfs/)

Git LFS uses HTTP Basic authentication to communicate with the LFS server over HTTPS, ensuring secure file transfers [2](https://docs.gitlab.com/ee/topics/git/lfs/). This system allows developers to work with large files as if they were stored directly in the Git repository while significantly improving performance and storage efficiency.


---
**Sources:**
- [(1) About Git Large File Storage - GitHub Docs](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
- [(2) Git Large File Storage (LFS) - GitLab Documentation](https://docs.gitlab.com/ee/topics/git/lfs/)
- [(3) How to use Git Large File Storage (LFS) - Graphite.dev](https://graphite.dev/guides/how-to-use-git-large-file-storage-lfs)
- [(4) Git Large File Storage | Bitbucket Data Center 8.9](https://confluence.atlassian.com/bitbucketserver089/git-large-file-storage-1236436513.html)
- [(5) Git LFS: The Pocketbook Explanation - Assembla](https://get.assembla.com/blog/git-lfs/)
- [(6) Working with Large Files on GitHub - Tilburg Science Hub](https://tilburgsciencehub.com/topics/automation/version-control/advanced-git/git-lfs/)


## Git LFS Hosting Providers
Several popular Git hosting platforms support Git LFS, providing developers with options to manage large files efficiently:

* GitHub: Offers built-in Git LFS support with storage and bandwidth quotas based on the account type. [1](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
* GitLab: Supports Git LFS in both its cloud-hosted and self-managed versions, with varying storage limits depending on the plan. [2](https://docs.gitlab.com/ee/topics/git/lfs/)
* Bitbucket: Provides Git LFS functionality for both cloud and server editions.
* Azure DevOps: Integrates Git LFS support in its repositories, offering ample storage for large files. [3](https://discussions.unity.com/t/where-to-host-big-packages-with-git-lfs/758120)
* JFrog Artifactory: Supports Git LFS repositories, providing advanced artifact management capabilities. [4](https://jfrog.com/help/r/jfrog-artifactory-documentation/git-lfs-repositories)
* Sonatype Nexus Repository: Offers Git LFS support, allowing users to host Git LFS content within their Nexus Repository Manager. [5](https://help.sonatype.com/en/git-lfs-repositories.html)
* AWS CodeCommit: Supports Git LFS, enabling users to store large files in Amazon S3.

When choosing a Git LFS hosting solution, consider storage limits, bandwidth restrictions, pricing, and integration with your existing development workflow. Some platforms, like GitLab, offer generous free tiers for Git LFS usage, making them attractive options for smaller projects or individual developers. [3](https://discussions.unity.com/t/where-to-host-big-packages-with-git-lfs/758120)


---
**Sources:**
- [(1) About Git Large File Storage - GitHub Docs](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
- [(2) Git Large File Storage (LFS) - GitLab Documentation](https://docs.gitlab.com/ee/topics/git/lfs/)
- [(3) Where to host big packages with GIT LFS? - Unity Discussions](https://discussions.unity.com/t/where-to-host-big-packages-with-git-lfs/758120)
- [(4) Git LFS Repositories - JFrog](https://jfrog.com/help/r/jfrog-artifactory-documentation/git-lfs-repositories)
- [(5) Git LFS Repositories - Sonatype Help](https://help.sonatype.com/en/git-lfs-repositories.html)


## Setting Up Git LFS
To set up Git LFS in your repository, first ensure that Git LFS is installed on your system. For detailed installation instructions, visit the official website at git-lfs.com.

Once installed, navigate to your repository's root directory and run the command `git lfs install` to initialize Git LFS. After initialization, you can begin tracking large files by using the command `git lfs track ""`, replacing \`\` with the appropriate file type (e.g., `*.psd` for Photoshop files). Don't forget to commit the changes to your `.gitattributes` file, which is automatically updated when you track new file types.


---
**Sources:**
- [(1) About Git Large File Storage - GitHub Docs](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
- [(2) Git Large File Storage (LFS) - GitLab Documentation](https://docs.gitlab.com/ee/topics/git/lfs/)
- [(3) Where to host big packages with GIT LFS? - Unity Discussions](https://discussions.unity.com/t/where-to-host-big-packages-with-git-lfs/758120)
- [(4) Git LFS Repositories - JFrog](https://jfrog.com/help/r/jfrog-artifactory-documentation/git-lfs-repositories)
- [(5) Git LFS Repositories - Sonatype Help](https://help.sonatype.com/en/git-lfs-repositories.html)


## Issues Without Git LFS
Team members without Git LFS installed face several challenges when working with repositories utilizing this feature. They will only see pointer files instead of actual content for LFS-tracked files, leading to missing assets and potential build failures. Unintentional commits of large files directly to the Git history may occur, bloating the repository size. Users with Git LFS installed might experience perpetual file modifications when interacting with commits made by those without LFS. To mitigate these issues:

* Ensure all team members install Git LFS before accessing the repository
* Provide clear setup instructions in project documentation
* Implement Git hooks or CI/CD checks to prevent non-LFS commits of large files
* Regularly verify LFS functionality across the team


---
**Sources:**
- [(1) About Git Large File Storage - GitHub Docs](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
- [(2) Git Large File Storage (LFS) - GitLab Documentation](https://docs.gitlab.com/ee/topics/git/lfs/)
- [(3) Where to host big packages with GIT LFS? - Unity Discussions](https://discussions.unity.com/t/where-to-host-big-packages-with-git-lfs/758120)
- [(4) Git LFS Repositories - JFrog](https://jfrog.com/help/r/jfrog-artifactory-documentation/git-lfs-repositories)
- [(5) Git LFS Repositories - Sonatype Help](https://help.sonatype.com/en/git-lfs-repositories.html)


## Automated Branch Cleanup
GitHub Branch Cleaner is a powerful GitHub Action that automates the process of cleaning up unnecessary branches in your repository, helping to maintain a tidy and efficient Git workflow [1](https://github.com/marketplace/actions/github-branch-cleaner). This tool is handy for large projects or teams frequently creating feature branches.

Key features of GitHub Branch Cleaner include:

* Automatic deletion of closed branches without merges
* Removal of merged branches
* Cleaning of inactive branches after a specified period
* Customizable base branches protection

To implement GitHub Branch Cleaner in your workflow, add it to your GitHub Actions configuration file (.github/workflows/cleanup.yml) with the following structure:

```yaml
name: Branch Cleanup
on:
  schedule:
    - cron: "0 0 * * *"  # Run daily at midnight
jobs:
  cleanup-branches:
    runs-on: ubuntu-latest
    steps:
      - uses: mmorenoregalado/action-branches-cleaner@v2.0.1
        with:
          base_branches: main,develop
          token: ${{ secrets.GITHUB_TOKEN }}
          days_old_threshold: 7
```

This setup will run the cleaner daily, protecting the 'main' and 'develop' branches while removing inactive branches older than 7 days [1](https://github.com/marketplace/actions/github-branch-cleaner). Adjust the parameters as needed to suit your project's specific requirements.
To ensure proper functionality, ensure the GitHub Actions workflow has sufficient permissions to delete branches. You may need to grant write access by setting permissions in your workflow file, as specified in the troubleshooting section of the action-branches-cleaner README.

### Run it in self-hosted runner

Github Branch Cleaner has a dependency to `jq`, so we have to install it first if we use it in self-hosted Github runner.

```yaml
name: Clean Branches

on:
  schedule:
    - cron: "0 0 * * *"  # Runs at 00:00 UTC every day
  workflow_dispatch:  # Allows manual triggering

jobs:
  cleanup-branches:
    runs-on: self-hosted
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install jq
        run: |
          sudo apt-get update
          sudo apt-get install -y jq
          
      - name: Clean Branches
        uses: mmorenoregalado/action-branches-cleaner@v2.0.2
        with:
          base_branches: main,develop  # Adjust these to your main branches
          token: ${{ secrets.GITHUB_TOKEN }}
          days_old_threshold: 60  # Adjust this value as needed
```


---
**Sources:**
- [(1) Marketplace Actions GitHub Branch Cleaner](https://github.com/marketplace/actions/github-branch-cleaner)


Exported on 25/12/2024 at 15:14:25 [from Perplexity Pages](https://www.perplexity.ai/page/reducing-large-vue-js-repo-siz-QqKAPsynSjOKLBYZeBEQqA) - with [SaveMyChatbot](https://save.hugocollin.com)