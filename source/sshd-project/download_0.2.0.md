---
type: sshd
title: Apache SSHD 0.2.0 Release
---

# Overview

Apache Mina SSHD 0.2.0 contains a few enhancements and bug-fixes.

# Getting the Distributions

Source and binary distributions are available via the [Apache Release Archives](https://archive.apache.org/dist/mina/sshd/0.2.0).

This release is archived and is no longer supported.

# Release Notes

Apache Mina SSHD 0.2.0 contains a few enhancements and bug-fixes.
Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).

* Bug
    * [SSHD-28](https://issues.apache.org/jira/browse/SSHD-28) - Deadlock between execute thread and NioProcessor thread
    * [SSHD-33](https://issues.apache.org/jira/browse/SSHD-33) - SSH uint32, sequence number wrapping
    * [SSHD-34](https://issues.apache.org/jira/browse/SSHD-34) - ChannelPipedInputStream/ChannelPipedOutputStream doesn't handle EOF correctly
    * [SSHD-35](https://issues.apache.org/jira/browse/SSHD-35) - EOF to stdin from ssh client isn't propagated to the command
    * [SSHD-37](https://issues.apache.org/jira/browse/SSHD-37) - When the terminal is created, the LINES and COLUMNS attributes are not set correctly
    * [SSHD-38](https://issues.apache.org/jira/browse/SSHD-38) - Typo that causes performance degradation with DEBUG-level logging enabled
    * [SSHD-39](https://issues.apache.org/jira/browse/SSHD-39) - ScpCommand cannot handle recursive copy    
* Improvement
    * [SSHD-31](https://issues.apache.org/jira/browse/SSHD-31) - Change ClientSessionImpl SshClient constructor argument from SshClient to FactoryManager
    * [SSHD-32](https://issues.apache.org/jira/browse/SSHD-32) - Reuse address
    * [SSHD-36](https://issues.apache.org/jira/browse/SSHD-36) - PasswordAuthenticator and Shell should have access to ServerSession
