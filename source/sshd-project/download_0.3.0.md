---
type: sshd
title: Apache SSHD 0.3.0 Release
---

# Overview

Apache Mina SSHD 0.3.0 contains a few enhancements and bug-fixes.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 0.3.0 Sources (.tar.gz)](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.tar.gz) [PGP](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.tar.gz.asc) [SHA](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.tar.gz.sha1)
    * [Apache Mina SSHD 0.3.0 Sources (.zip)](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.zip) [PGP](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.zip.asc) [SHA](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0-src.zip.sha1)
* Binary distributions:
    * [Apache Mina SSHD 0.3.0 Binary (.tar.gz)](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.tar.gz) [PGP](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.tar.gz.asc) [SHA](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.tar.gz.sha1)
    * [Apache Mina SSHD 0.3.0 Binary (.zip)](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.zip) [PGP](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.zip.asc) [SHA](http://archive.apache.org/dist/mina/sshd/0.3.0/apache-sshd-0.3.0.zip.sha1) 
* Individual jars:
    * [Apache Mina SSHD Core 0.3.0 (.jar)](http://archive.apache.org/dist/mina/sshd/0.3.0/sshd-core-0.3.0.jar) [PGP](http://archive.apache.org/dist/mina/sshd/0.3.0/sshd-core-0.3.0.jar.asc) [SHA](http://archive.apache.org/dist/mina/sshd/0.3.0/sshd-core-0.3.0.jar.sha1)

# Release Notes

Apache Mina SSHD 0.3.0 contains a few enhancements and bug-fixes.
Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).

* Bug
    * [SSHD-43](http://issues.apache.org/jira/browse/SSHD-43) - When the ssh server is closed, channels are not closed cleanly, causing clients to hang
    * [SSHD-44](http://issues.apache.org/jira/browse/SSHD-44) - NPE in ScpCommand and improvement to ScpCommandFactory.createCommand
    * [SSHD-48](http://issues.apache.org/jira/browse/SSHD-48) - NullPointerException when calling sftp'ing to the server
    * [SSHD-49](http://issues.apache.org/jira/browse/SSHD-49) - When a large amount of text is written to a Putty client it causes the client to hang.
    * [SSHD-53](http://issues.apache.org/jira/browse/SSHD-53) - Make sure PublickeyAuthenticator and PasswordAuthenticator interfaces are consistent
    * [SSHD-57](http://issues.apache.org/jira/browse/SSHD-57) - SCPCommand erroneously assumes file lengths fit in integers.
    * [SSHD-59](http://issues.apache.org/jira/browse/SSHD-59) - Possible stack overflow when closing a client channel    
* Improvement
    * [SSHD-22](http://issues.apache.org/jira/browse/SSHD-22) - Add support for signals (especially window-change)
    * [SSHD-41](http://issues.apache.org/jira/browse/SSHD-41) - Provide a binary distribution
    * [SSHD-42](http://issues.apache.org/jira/browse/SSHD-42) - SSHD bundles should not import their own package
    * [SSHD-46](http://issues.apache.org/jira/browse/SSHD-46) - Upgrade to mina 2.0 rc1
    * [SSHD-47](http://issues.apache.org/jira/browse/SSHD-47) - The pty terminal parameters are not available to the shell
    * [SSHD-51](http://issues.apache.org/jira/browse/SSHD-51) - Support for subsystems
    * [SSHD-52](http://issues.apache.org/jira/browse/SSHD-52) - Refactor Shell and Command interfaces into a common interface
    * [SSHD-58](http://issues.apache.org/jira/browse/SSHD-58) - Think of better support for subclassing both SshServer and ScpCommand (and possibly other classes)
    * [SSHD-63](http://issues.apache.org/jira/browse/SSHD-63) - Better support for controlling the console when launching external processes for shells
* New Feature
    * [SSHD-40](http://issues.apache.org/jira/browse/SSHD-40) - Support local/remote port forwarding on the server side
    * [SSHD-60](http://issues.apache.org/jira/browse/SSHD-60) - need interface to filter TCP/IP forwarding
