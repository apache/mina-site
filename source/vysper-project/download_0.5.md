---
type: vysper
title: Apache Vysper 0.5 Release
---

# New Features in 0.5

This is the first release of Apache Vysper. The release contains partial implementations of the following specifications:

* RFC 3920 XMPP Core
* RFC 3921 XMPP IM
* XEP-0045 Multi-user chat
* XEP-0060 Publish-subscribe

# Getting the Binary Distributions

| Description | Download Link | PGP Signature file of download | 
|---|---|---|
| Windows Distribution | [vysper-0.5-bin.zip](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-bin.zip) | [vysper-0.5-bin.zip.asc](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-bin.zip.asc) | 
| Unix/Linux/Cygwin Distribution | [vysper-0.5-bin.tar.gz](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-bin.tar.gz) | [vysper-0.5-bin.tar.gz.asc](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-bin.tar.gz.asc) | 

# Verify the Integrity of Downloads

It is essential that you verify the integrity of the downloaded files using the PGP signatures. The PGP signatures can be verified using PGP or GPG. Begin by following these steps:

1. Download the [KEYS](https://downloads.apache.org/mina/KEYS)
2. Download the asc signature file for the relevant distribution
3. Verify the signatures using the following commands, depending on your use of PGP or GPG:

        $ pgpk -a KEYS
        $ pgpv vysper-<version>-bin.tar.gz.asc

    or

        $ pgp -ka KEYS
        $ pgp vysper-<version>-bin.tar.gz.asc

    or

        $ gpg --import KEYS
        $ gpg --verify vysper-<version>-bin.tar.gz.asc

    (Where <version> is replaced with the actual version, e.g., 0.5).

# Getting the Binaries using Maven 2

To use this release in your maven project, the proper dependency configuration that you should use in your [Maven POM](http://maven.apache.org/guides/introduction/introduction-to-the-pom.html) is:

```xml
<dependency>
    <groupId>org.apache.vysper</groupId>
    <artifactId>vysper-core</artifactId>
    <version>0.5</version>
</dependency>
```

# Getting the Source Code

## Source Distributions

| Description | Download Link | PGP Signature file of download | 
|---|---|---|
| Source for Windows | [vysper-0.5-src.zip](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-src.zip) | [vysper-0.5-src.zip.asc](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-src.zip.asc) | 
| Source for Unix/Linux/Cygwin | [vysper-0.5-src.tar.gz](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-src.tar.gz) | [vysper-0.5-src.tar.gz.asc](https://archive.apache.org/dist/mina/vysper/0.5/vysper-0.5-src.tar.gz.asc) | 

    svn co http://svn.apache.org/repos/asf/mina/vysper/tags/0.5
