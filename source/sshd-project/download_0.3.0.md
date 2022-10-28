---
type: sshd
title: Apache SSHD 0.3.0 Release
---

# Overview

Apache Mina SSHD 0.3.0 contains a few enhancements and bug-fixes.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 0.3.0 Sources (.tar.gz)](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.tar.gz.sha1)
    * [Apache Mina SSHD 0.3.0 Sources (.zip)](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.zip) [PGP](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.zip.sha1)
* Binary distributions:
    * [Apache Mina SSHD 0.3.0 Binary (.tar.gz)](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.tar.gz.sha1)
    * [Apache Mina SSHD 0.3.0 Binary (.zip)](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.zip) [PGP](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.zip.sha1) 
* Individual jars:
    * [Apache Mina SSHD Core 0.3.0 (.jar)](https://archive.apache.org/dist/mina/sshd/0.3.0/sshd-core-0.3.0.jar) [PGP](https://archive.apache.org/dist/mina/sshd/0.3.0/sshd-core-0.3.0.jar.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.3.0/sshd-core-0.3.0.jar.sha1)

# Release Notes

Apache Mina SSHD 0.3.0 contains a few enhancements and bug-fixes.
Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).

* Bug
    * [SSHD-43](https://issues.apache.org/jira/browse/SSHD-43) - When the ssh server is closed, channels are not closed cleanly, causing clients to hang
    * [SSHD-44](https://issues.apache.org/jira/browse/SSHD-44) - NPE in ScpCommand and improvement to ScpCommandFactory.createCommand
    * [SSHD-48](https://issues.apache.org/jira/browse/SSHD-48) - NullPointerException when calling sftp'ing to the server
    * [SSHD-49](https://issues.apache.org/jira/browse/SSHD-49) - When a large amount of text is written to a Putty client it causes the client to hang.
    * [SSHD-53](https://issues.apache.org/jira/browse/SSHD-53) - Make sure PublickeyAuthenticator and PasswordAuthenticator interfaces are consistent
    * [SSHD-57](https://issues.apache.org/jira/browse/SSHD-57) - SCPCommand erroneously assumes file lengths fit in integers.
    * [SSHD-59](https://issues.apache.org/jira/browse/SSHD-59) - Possible stack overflow when closing a client channel    
* Improvement
    * [SSHD-22](https://issues.apache.org/jira/browse/SSHD-22) - Add support for signals (especially window-change)
    * [SSHD-41](https://issues.apache.org/jira/browse/SSHD-41) - Provide a binary distribution
    * [SSHD-42](https://issues.apache.org/jira/browse/SSHD-42) - SSHD bundles should not import their own package
    * [SSHD-46](https://issues.apache.org/jira/browse/SSHD-46) - Upgrade to mina 2.0 rc1
    * [SSHD-47](https://issues.apache.org/jira/browse/SSHD-47) - The pty terminal parameters are not available to the shell
    * [SSHD-51](https://issues.apache.org/jira/browse/SSHD-51) - Support for subsystems
    * [SSHD-52](https://issues.apache.org/jira/browse/SSHD-52) - Refactor Shell and Command interfaces into a common interface
    * [SSHD-58](https://issues.apache.org/jira/browse/SSHD-58) - Think of better support for subclassing both SshServer and ScpCommand (and possibly other classes)
    * [SSHD-63](https://issues.apache.org/jira/browse/SSHD-63) - Better support for controlling the console when launching external processes for shells
* New Feature
    * [SSHD-40](https://issues.apache.org/jira/browse/SSHD-40) - Support local/remote port forwarding on the server side
    * [SSHD-60](https://issues.apache.org/jira/browse/SSHD-60) - need interface to filter TCP/IP forwarding
