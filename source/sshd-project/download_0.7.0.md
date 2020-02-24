---
type: sshd
title: Apache SSHD 0.7.0 Release
---

# Overview

Apache Mina SSHD 0.7.0 contains a few enhancements and bug-fixes.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 0.7.0 Sources (.tar.gz)](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0-src.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0-src.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0-src.tar.gz.sha1)
    * [Apache Mina SSHD 0.7.0 Sources (.zip)](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0-src.zip) [PGP](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0-src.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0-src.zip.sha1)
* Binary distributions:
    * [Apache Mina SSHD 0.7.0 Binary (.tar.gz)](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0.tar.gz.sha1)
    * [Apache Mina SSHD 0.7.0 Binary (.zip)](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0.zip) [PGP](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/0.7.0/apache-sshd-0.7.0.zip.sha1)

# Release Notes

Apache Mina SSHD 0.7.0 contains a few enhancements and bug-fixes.
Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).

* Bug
    * [SSHD-120](https://issues.apache.org/jira/browse/SSHD-120) - list 1500 files in one directory not working for mindterm sftp client
    * [SSHD-123](https://issues.apache.org/jira/browse/SSHD-123) - TcpipForward race condition & deadlock on client disconnect.
    * [SSHD-126](https://issues.apache.org/jira/browse/SSHD-126) - Reduce overall logging
    * [SSHD-129](https://issues.apache.org/jira/browse/SSHD-129) - TCP connection through Port Forward can take up to 5 seconds due to DNS lookup
    * [SSHD-132](https://issues.apache.org/jira/browse/SSHD-132) - NativeSshFile does not close RandomAccessFile on IOException
    * [SSHD-143](https://issues.apache.org/jira/browse/SSHD-143) - Missing SVN EOL properties
    * [SSHD-145](https://issues.apache.org/jira/browse/SSHD-145) - InvertedShellWrapper may not send process output back if process exits too fast
    * [SSHD-146](https://issues.apache.org/jira/browse/SSHD-146) - SSH Server : EOF from command not propagating to Process (InvertedShell)
    * [SSHD-148](https://issues.apache.org/jira/browse/SSHD-148) - Support for protoversion 1.99 - Section 5.1, "Old Client, New Server", RFC 4253
    * [SSHD-151](https://issues.apache.org/jira/browse/SSHD-151) - Direct TCP/IP Port Forward sends EOF to client after closing channel
    * [SSHD-157](https://issues.apache.org/jira/browse/SSHD-157) - SshServer.stop should be idempotent
    * [SSHD-160](https://issues.apache.org/jira/browse/SSHD-160) - Standard ScpCommand does not work with pscp
    * [SSHD-168](https://issues.apache.org/jira/browse/SSHD-168) - SFTP returns wrong ownership information
    * [SSHD-170](https://issues.apache.org/jira/browse/SSHD-170) - Change the BundleSymbolic-Name to include the groupId
    * [SSHD-171](https://issues.apache.org/jira/browse/SSHD-171) - ScpCommand block indefinitely when using the "-p" flag
* Improvement
    * [SSHD-121](https://issues.apache.org/jira/browse/SSHD-121) - Add Factories to create IoAcceptors for TcpipForwardSupport & X11ForwardSupport
    * [SSHD-147](https://issues.apache.org/jira/browse/SSHD-147) - Allow idle timeout to be disabled.
    * [SSHD-153](https://issues.apache.org/jira/browse/SSHD-153) - Improve handling of SSH_MSG_CHANNEL_WINDOW_ADJUST message
    * [SSHD-158](https://issues.apache.org/jira/browse/SSHD-158) - Latest HEAD does not build on Windows
    * [SSHD-162](https://issues.apache.org/jira/browse/SSHD-162) - Allow the configuration of InvertedShellWrapper's thread pool
    * [SSHD-163](https://issues.apache.org/jira/browse/SSHD-163) - Allow InvertedShellWrapper to implement SessionAware
    * [SSHD-164](https://issues.apache.org/jira/browse/SSHD-164) - Allow the buffer size for the IO pumps to be configurable in InvertedShellWrapper
    * [SSHD-166](https://issues.apache.org/jira/browse/SSHD-166) - Upgrade to mina 2.0.4
    * [SSHD-167](https://issues.apache.org/jira/browse/SSHD-167) - Allow the ClientChannel#waitFor to wait for the channel to be opened
    * [SSHD-172](https://issues.apache.org/jira/browse/SSHD-172) - Provide a way to access the list of active sessions from the server
* New Feature
    * [SSHD-165](https://issues.apache.org/jira/browse/SSHD-165) - Improved support for SSH agents, including a local proxy without the needs for native libraries (for unix sockets or windows pipes)
