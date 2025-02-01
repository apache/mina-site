---
type: ftpserver
title: FtpServer Getting Source
---

## Overview

Sources for the Apache MINA projects are currently managed through GIT. Instructions on GIT use can be found at <http://git-scm.com/book/>.

There is also a mirror on [GitHub](https://github.com/apache/mina-ftpserver)

## Normal Git Access

Anyone can check code out of Git. You only need to specify a username and password in order to update the Git repository, and only MINA committers have the permissions to do that. We run Git over standard HTTPS, so hopefully you won't have problems with intervening firewalls.

## Web Access

The following is a link to the [online source repository](https://gitbox.apache.org/repos/asf?p=mina-ftpserver.git;a=summary).

# Cloning from the Git repo

Again, anyone can do this. Use a command like to checkout the current development version (the trunk):

read only access :

  git clone http://gitbox.apache.org/repos/asf/mina-ftpserver.git ftpserver

write access :

  git clone https://gitbox.apache.org/repos/asf/mina-ftpserver.git ftpserver

You will not be able to commit into the project if you are not a committer.

There are currently two working branches:

* 1.2.X, the mot recent development branch
* 1.1.X, a maintainance branche

All the other branches are dead wood, including the 'master' branch

Be sure to checkout the **1.2.X** branch if you want to participate in the latest branch.

# Documentation
The Website documentation is published via Apache SVN pubsub. The website source resides at

[https://svn.apache.org/repos/asf/mina/site/trunk/content/ftpserver-project/](https://svn.apache.org/repos/asf/mina/site/trunk/content/ftpserver-project/)

# Coding Convention

We follow [Sun's standard Java coding convention](https://www.oracle.com/technetwork/java/codeconventions-150003.pdf) except that we always use spaces instead of tabs. Please download [the Eclipse Java formatter settings file](https://mina.apache.org/mina-project/ImprovedJavaConventions.xml) before you make any changes to the code.

This file is also available in the `/resources` directory.
