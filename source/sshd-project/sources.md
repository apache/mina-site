---
type: sshd
title: SSHD Sources
---

## Overview

Sources for the Apache MINA projects are currently managed through Git. Instructions on Git use can be found at [the official Git site](https://git-scm.com/book/).

# Normal Git Access

Anyone can check code out of Git. You only need to specify a username and password in order to update the Git repository, and only MINA committers have the permissions to do that. We run Git over standard HTTPS, so hopefully you won't have problems with intervening firewalls.

## Web Access

Our [main source repository](https://gitbox.apache.org/repos/asf?p=mina-sshd.git;a=summary) as well as the [GitHub mirror](https://github.com/apache/mina-sshd) can be browsed on-line.

# Cloning from the Git repo

Again, anyone can do this. To clone the repository, use

  git clone https://gitbox.apache.org/repos/asf/mina-sshd.git sshd

You will not be able to commit into the project if you are not a committer.

The main repository is also [mirrored at GitHub](https://github.com/apache/mina-sshd). It can be cloned from there, or you can create your own fork and clone that. If you plan on submitting a GitHub pull request, use a fork.

# Documentation
The Website documentation is published via Apache SVN pubsub. The website source resides at

[https://github.com/apache/mina-site/](https://github.com/apache/mina-site/)
