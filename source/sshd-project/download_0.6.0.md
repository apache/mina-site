---
type: sshd
title: Apache SSHD 0.6.0 Release
---

# Overview

Apache Mina SSHD 0.6.0 contains a few enhancements and bug-fixes.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 0.6.0 Sources (.tar.gz)](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0-src.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0-src.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0-src.tar.gz.sha1)
    * [Apache Mina SSHD 0.6.0 Sources (.zip)](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0-src.zip) [PGP](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0-src.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0-src.zip.sha1)
* Binary distributions:
    * [Apache Mina SSHD 0.6.0 Binary (.tar.gz)](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0.tar.gz.sha1)
    * [Apache Mina SSHD 0.6.0 Binary (.zip)](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0.zip) [PGP](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.6.0/apache-sshd-0.6.0.zip.sha1)

# Release Notes

Apache Mina SSHD 0.6.0 contains a few enhancements and bug-fixes.
Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).

* Bug
    * [SSHD-19](https://issues.apache.org/jira/browse/SSHD-19) - NullPointerException during SSHD data write
    * [SSHD-89](https://issues.apache.org/jira/browse/SSHD-89) - EOF is not send by the client
    * [SSHD-97](https://issues.apache.org/jira/browse/SSHD-97) - Uploading file via SFTP leaves file in locked state on Windows
    * [SSHD-100](https://issues.apache.org/jira/browse/SSHD-100) - [sftp] open(2) w/ O_CREAT|O_TRUNC works, but O_CREAT alone fails
    * [SSHD-101](https://issues.apache.org/jira/browse/SSHD-101) - [sftp] send correct amount of data in SSH_FXP_READ
    * [SSHD-104](https://issues.apache.org/jira/browse/SSHD-104) - FormatFlagsConversionMismatchException when using IBM JVM. Format String is invalid.
    * [SSHD-105](https://issues.apache.org/jira/browse/SSHD-105) - sftp: com.jcraft.jsch client can't get files
    * [SSHD-106](https://issues.apache.org/jira/browse/SSHD-106) - Wrong use of ProcessBuilder.environment() in ProcessShellFactory.java
    * [SSHD-110](https://issues.apache.org/jira/browse/SSHD-110) - Wrong return type for createShellChannel() method of org.apache.sshd.ClientSession interface. It is ChannelSession but should be ChannelShell
    * [SSHD-115](https://issues.apache.org/jira/browse/SSHD-115) - Missing return handling SFTP SSH_FXP_OPEN cannot create error
    * [SSHD-116](https://issues.apache.org/jira/browse/SSHD-116) - Shouldn't throw an exception when receiving an unsupported SFTP message
    * [SSHD-122](https://issues.apache.org/jira/browse/SSHD-122) - SSH_MSG_CHANNEL_EOF SSH_MSG_CHANNEL_REQUEST("exit-status") after SSH_MSG_CHANNEL_CLOSE
    * [SSHD-133](https://issues.apache.org/jira/browse/SSHD-133) - E command not handled for single file upload    
* Improvement
    * [SSHD-96](https://issues.apache.org/jira/browse/SSHD-96) - Virtual File System improvement for SCP and session injection
    * [SSHD-98](https://issues.apache.org/jira/browse/SSHD-98) - Directories in sftp should have executable permission set
    * [SSHD-99](https://issues.apache.org/jira/browse/SSHD-99) - The Session interface should give access to the user name authenticated on this session
    * [SSHD-102](https://issues.apache.org/jira/browse/SSHD-102) - Add error logging to org.apache.sshd.server.jaas.JaasPasswordAuthenticator.authenticate()
    * [SSHD-107](https://issues.apache.org/jira/browse/SSHD-107) - Extend SshFile etc views to scp command
    * [SSHD-109](https://issues.apache.org/jira/browse/SSHD-109) - Pass server session to FileSystemFactory.createFileSystemView
    * [SSHD-111](https://issues.apache.org/jira/browse/SSHD-111) - Support gssapi-with-mic authentication to use kerberos credentials
    * [SSHD-113](https://issues.apache.org/jira/browse/SSHD-113) - KeyPair provider from classpath resource
    * [SSHD-114](https://issues.apache.org/jira/browse/SSHD-114) - Session listener
    * [SSHD-117](https://issues.apache.org/jira/browse/SSHD-117) - Ignore "keepalive@jcraft.com" in addition to "keepalive@openssh.com"
    * [SSHD-119](https://issues.apache.org/jira/browse/SSHD-119) - more specific docstring for Command interface
    * [SSHD-135](https://issues.apache.org/jira/browse/SSHD-135) - The performance of uploading and downloading files in SFTP subsystem is very poor.
    * [SSHD-137](https://issues.apache.org/jira/browse/SSHD-137) - Javadoc for SshFile.truncate() is wrong.
    * [SSHD-139](https://issues.apache.org/jira/browse/SSHD-139) - Impossible to run a ssh shell channel without a pty
    * [SSHD-140](https://issues.apache.org/jira/browse/SSHD-140) - Add configurable session idle timeout.
    * [SSHD-142](https://issues.apache.org/jira/browse/SSHD-142) - Ability to customize the number of nio workers on the client
