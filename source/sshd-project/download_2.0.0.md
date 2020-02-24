---
type: sshd
title: Apache SSHD 2.0.0 Release
---

# Overview

Apache Mina SSHD 2.0.0 contains a number of [enhancements and bug-fixes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12310849&version=12342654).

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 2.0.0 Sources (.tar.gz)](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0-src.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0-src.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0-src.tar.gz.sha1)
    * [Apache Mina SSHD 2.0.0 Sources (.zip)](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0-src.zip) [PGP](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0-src.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0-src.zip.sha1)
* Binary distributions:
    * [Apache Mina SSHD 2.0.0 Binary (.tar.gz)](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0.tar.gz.sha1)
    * [Apache Mina SSHD 2.0.0 Binary (.zip)](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0.zip) [PGP](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.0.0/apache-sshd-2.0.0.zip.sha1)

# Release Notes

There have been many bug fixes and improvements since last released version
1.7.0 - a major one being that SSHD now consists of several distinct
artifact rather than being monolithic, In order to achieve this, some code
re-factoring was necessary - especially for SCP, SFTP and using MINA or
Netty instead of (the default) NIO2. We therefore decided to name the
version as 2.0 in order to emphasize the fact that backward compatibility
is not 100% guaranteed. 

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
