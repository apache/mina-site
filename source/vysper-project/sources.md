---
type: vysper
title: Vysper Sources
---

## Overview

Sources for the Apache MINA projects are currently managed through GIT. Instructions on GIT use can be found at <http://git-scm.com/book/>.

# Normal Git Access

Anyone can check code out of Git. You only need to specify a username and password in order to update the Git repository, and only MINA committers have the permissions to do that. We run Git over standard HTTPS, so hopefully you won't have problems with intervening firewalls.

## Web Access

The following is a link to the [online source repository](https://gitbox.apache.org/repos/asf?p=mina-vysper.git;a=summary).

# Cloning from the Git repo

Again, anyone can do this. Use a command like to pull the current development version (the trunk):

read only access :

  git clone https://gitbox.apache.org/repos/asf/mina-vysper.git vysper

write access :

  git clone https://gitbox.apache.org/repos/asf/mina-vysper.git vysper

You will not be able to commit into the project if you are not a committer.


## Building

We use Maven for managing our dependencies and packaging. Please use Maven 2.2.1 or later.
To install all of Vysper (core, modules etc) you can try this after the checkout:

    mvn clean install

You can also build a complete, runnable Vysper server:

    cd dist
    mvn clean package


On successful build, you will find a functional binary package at

    target/vysper-1.0.0-SNAPSHOT-bin.{zip|tar.gz}

Unpackaging a bin-package reveals a bin/ directory, containing run-scripts for Windows and Unix/MacOS.
Executing this script will boot a working Vysper XMPP server.

# Documentation
The Website documentation is published via Apache SVN pubsub. The website source resides at

[https://svn.apache.org/repos/asf/mina/site/trunk/content/vysper-project/](https://svn.apache.org/repos/asf/mina/site/trunk/content/vysper-project/)
