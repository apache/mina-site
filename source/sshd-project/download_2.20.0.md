---
type: sshd
title: Apache SSHD 2.20.0 Release
version: 2.20.0
---

# Overview

## Bug Fixes

* [GH-656](https://github.com/apache/mina-sshd/issues/656) `ChannelPipedInputStream`: shrink buffer when emptied
* [GH-906](https://github.com/apache/mina-sshd/issues/906) Fix finding a signature factory for BC ed25519 keys
* [GH-911](https://github.com/apache/mina-sshd/issues/911) Fix server-side SOCKS5 proxy for fragmented and pipelined CONNECT requests
* Allow asynchronous authentication only for password and keyboard-interactive authentication schemes
* Fix authentication requiring multiple public keys (server-side)
* Better argument handling in sshd-git
* More checks in authentication (server-side)
* Better SCP command handling
* SFTP client: simplify response message handling
* Fix check-file-name/check-file-handle SFTP v6 extension (server-side)
* Improve LDAP authentication (sshd-ldap)

## New Features

* [GH-905](https://github.com/apache/mina-sshd/issues/905) Implement the "from" and "expiry-time" options in `authorized_keys` handling in public key authentication (server side)

## Potential Compatibility Issues

None.

## Major Code Re-factoring

None.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD {{< version >}} Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD {{< version >}} Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.sha512)

PGP signing public keys for all releases are available in the [Apache MINA KEYS file](https://downloads.apache.org/mina/KEYS).

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
