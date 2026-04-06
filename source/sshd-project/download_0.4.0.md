---
type: sshd
title: Apache SSHD 0.4.0 Release
---


# Overview

Apache Mina SSHD 0.4.0 contains a few enhancements and bug-fixes.

# Getting the Distributions

Source and binary distributions are available via the [Apache Release Archives](https://archive.apache.org/dist/mina/sshd/0.4.0).

This release is archived and is no longer supported.


# Release Notes

Apache Mina SSHD 0.4.0 contains a few enhancements and bug-fixes.
Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).

* Bug
    * [SSHD-54](https://issues.apache.org/jira/browse/SSHD-54) - Severe performance penalties when transferring data from a remote machine
    * [SSHD-56](https://issues.apache.org/jira/browse/SSHD-56) - SCPCommand can't handle wildcards
    * [SSHD-61](https://issues.apache.org/jira/browse/SSHD-61) - ScpTest fails randomly
    * [SSHD-73](https://issues.apache.org/jira/browse/SSHD-73) - Infinite loop in ChannelOutputStream
    * [SSHD-74](https://issues.apache.org/jira/browse/SSHD-74) - Even if I do setPublicKeyAuthenticator(null) (or setPasswordAuthenticator(null)) Apache SSHD still reports that it supports that kind of authentication
    * [SSHD-77](https://issues.apache.org/jira/browse/SSHD-77) - Accept SSH-2 names from Putty
    * [SSHD-78](https://issues.apache.org/jira/browse/SSHD-78) - PEMGeneratorHostKeyProvider doesn't close PEMWriter
    * [SSHD-79](https://issues.apache.org/jira/browse/SSHD-79) - ChannelPipedInputStream returns improper negative values for some bytes.
    * [SSHD-80](https://issues.apache.org/jira/browse/SSHD-80) - Exchange hash calculation problem    
* Improvement
    * [SSHD-65](https://issues.apache.org/jira/browse/SSHD-65) - Ability to specify the host name when binding the sshd server socket
    * [SSHD-68](https://issues.apache.org/jira/browse/SSHD-68) - Support subsystem on the client side
    * [SSHD-71](https://issues.apache.org/jira/browse/SSHD-71) - Skip tests if native library is not available
* New Feature
    * [SSHD-8](https://issues.apache.org/jira/browse/SSHD-8) - Implement agent forwarding
    * [SSHD-25](https://issues.apache.org/jira/browse/SSHD-25) - Support key based authentication on the client side
    * [SSHD-55](https://issues.apache.org/jira/browse/SSHD-55) - Support for SFTP on the server side
    * [SSHD-81](https://issues.apache.org/jira/browse/SSHD-81) - Support for X11 forwarding on the server side
