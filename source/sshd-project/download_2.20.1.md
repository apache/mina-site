---
type: sshd
title: Apache SSHD 2.20.1 Release
version: 2.20.1
---

# Overview

This is a patch release for [version 2.20.0](./download_2.20.0.html).

## Bug Fixes

* [GH-925](https://github.com/apache/mina-sshd/issues/925) Re-allow "none" authentication (regression in 2.20.0)
* [GH-927](https://github.com/apache/mina-sshd/issues/927) Fixed a race condition in key exchanges (regression in 2.14.0; narrow race occurring rarely)

## New Features

* [GH-904](https://github.com/apache/mina-sshd/issues/904) Log local port in `ClientSessionImpl.toString()` to be able to distinguish multiple sessions to the same host in logs

## Potential Compatibility Issues

None.

## Major Code Re-factoring

None; this is a patch release.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD {{< version >}} Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD {{< version >}} Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.sha512)

PGP signing public keys for all releases are available in the [Apache MINA KEYS file](https://downloads.apache.org/mina/KEYS).

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
