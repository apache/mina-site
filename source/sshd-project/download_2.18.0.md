---
type: sshd
title: Apache SSHD 2.18.0 Release
version: 2.18.0
---

# Overview

## Bug Fixes


 * [GH-743](https://github.com/apache/mina-sshd/issues/743) Ensure the Java `ServiceLoader` use a singleton `SftpFileSystemProvider`
 * [GH-879](https://github.com/apache/mina-sshd/issues/879) Close SSH channel gracefully on exception in port forwarding
 * Improve handling of repository paths in `sshd-git`.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD {{< version >}} Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD {{< version >}} Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.sha512)

PGP signing public keys for all releases are available in the [Apache MINA KEYS file](https://downloads.apache.org/mina/KEYS).

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
