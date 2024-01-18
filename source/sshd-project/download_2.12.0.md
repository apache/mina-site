---
type: sshd
title: Apache SSHD 2.12.0 Release
---

# Overview

Apache Mina SSHD 2.12.0 contains a number of enhancements and bug-fixes. See the lists at 
the [GitHub issue tracker](https://github.com/apache/mina-sshd/issues?q=milestone%3A2.12.0).

## Bug Fixes

* [GH-428/GH-392](https://github.com/apache/mina-sshd/issues/428) SCP client fails silently when error signalled due to missing file or lacking permissions
* [GH-434](https://github.com/apache/mina-sshd/issues/434) Ignore unknown key types from agent or in OpenSSH host keys extension


## New Features

* [GH-429](https://github.com/apache/mina-sshd/issues/429) Support GIT protocol-v2
* [GH-445](https://github.com/apache/mina-sshd/issues/445) OpenSSH "strict key exchange" protocol extension ([CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795) mitigation)

## Behavioral changes and enhancements

### New `ScpTransferEventListener` callback method

Following [GH-428/GH-392](https://github.com/apache/mina-sshd/issues/428) a new `handleReceiveCommandAckInfo` method has been added to enable users to inspect
acknowledgements of a `receive` related command. The user is free to inspect the command that was attempted as well as the response code and decide how
to handle it - including even throwing an exception if OK status (if this makes sense for whatever reason). The default implementation checks for ERROR code and throws
an exception if so.

### OpenSSH protocol extension: strict key exchange

[GH-445](https://github.com/apache/mina-sshd/issues/445) implements an extension to the SSH protocol introduced
in OpenSSH 9.6. This ["strict key exchange" extension](https://github.com/openssh/openssh-portable/blob/master/PROTOCOL)
hardens the SSH key exchange against the ["Terrapin attack"](https://www.terrapin-attack.com/)
([CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795)). The extension is active if both parties
announce their support for it at the start of the initial key exchange. If only one party announces support,
it is not activated to ensure compatibility with SSH implementations that do not implement it. Apache MINA sshd
clients and servers always announce their support for strict key exchange.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 2.12.0 Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.12.0/apache-sshd-2.12.0-src.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0-src.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0-src.tar.gz.sha512)
    * [Apache Mina SSHD 2.12.0 Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.12.0/apache-sshd-2.12.0-src.zip) [PGP](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0-src.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD 2.12.0 Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.12.0/apache-sshd-2.12.0.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0.tar.gz.sha512)
    * [Apache Mina SSHD 2.12.0 Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.12.0/apache-sshd-2.12.0.zip) [PGP](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.12.0/apache-sshd-2.12.0.zip.sha512)

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
