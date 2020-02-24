---
type: sshd
title: SSHD Sources
---

## Overview

Sources for the Apache MINA projects are currently managed through GIT. Instructions on GIT use can be found at <http://git-scm.com/book/>.

# Normal Git Access

Anyone can check code out of Git. You only need to specify a username and password in order to update the Git repository, and only MINA committers have the permissions to do that. We run Git over standard HTTPS, so hopefully you won't have problems with intervening firewalls.

## Web Access

The following is a link to the [online source repository](https://gitbox.apache.org/repos/asf?p=mina-sshd.git;a=summary).

# Cloning from the Git repo

Again, anyone can do this. Use a command like to pull the current development version (the trunk):

read only access :

  git clone http://gitbox.apache.org/repos/asf/mina-sshd.git sshd

write access :

  git clone https://gitbox.apache.org/repos/asf/mina-sshd.git sshd

You will not be able to commit into the project if you are not a committer.

# Documentation
The Website documentation is published via Apache SVN pubsub. The website source resides at

[https://svn.apache.org/repos/asf/mina/site/trunk/content/sshd-project/](https://svn.apache.org/repos/asf/mina/site/trunk/content/sshd-project/)
