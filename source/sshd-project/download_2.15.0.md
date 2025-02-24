---
type: sshd
title: Apache SSHD 2.15.0 Release
version: 2.15.0
---

# Overview

## Bug Fixes

* [GH-618](https://github.com/apache/mina-sshd/issues/618) Fix reading an `OpenSshCertificate` from a `Buffer`
* [GH-626](https://github.com/apache/mina-sshd/issues/626) Enable `Streaming.Async` for `ChannelDirectTcpip`
* [GH-628](https://github.com/apache/mina-sshd/issues/628) SFTP: fix reading directories with trailing blanks in the name
* [GH-636](https://github.com/apache/mina-sshd/issues/636) Fix handling of unsupported key types in `known_hosts` file
* [GH-642](https://github.com/apache/mina-sshd/issues/642) Do not use `SecureRandom.getInstanceString()` due to possible entropy starvation (regression in 2.14.0)
* [GH-654](https://github.com/apache/mina-sshd/issues/654) Fix test dependency for assertj in `sshd-contrib`

## New Features

* [GH-606](https://github.com/apache/mina-sshd/issues/606) Support ML-KEM PQC hybrid key exchanges
* [GH-652](https://github.com/apache/mina-sshd/issues/652) New method `KnownHostsServerKeyVerifier.handleRevokedKey()`
* [SSHD-988](https://issues.apache.org/jira/projects/SSHD/issues/SSHD-988) Support ed25519 keys via the Bouncy Castle library

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD {{< version >}} Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip) [PGP](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD {{< version >}} Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip) [PGP](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.sha512)

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
