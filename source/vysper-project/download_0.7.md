---
type: vysper
title: Apache Vysper 0.7 Release
---

# New Features in 0.7

This release adds some major features to Apache Vysper, including support for server to server connections, Ad-hoc commands, a partial implementation of service administration and experimental websockets support. The release also contains many minor improvements and bug fixes. A [list of the supported specifications](standards_supported.html) is available.

# Change log

For a detailed view of new features and bug fixes, see the [release notes](https://issues.apache.org/jira/browse/VYSPER/fixforversion/12315280)

# Getting the Binary Distributions

| Description | Download Link | PGP Signature file of download | 
|---|---|---|
| Windows Distribution | [vysper-0.7-bin.zip](https://www.apache.org/dyn/closer.lua/mina/vysper/0.7/dist/vysper-0.7-bin.zip) | [vysper-0.7-bin.zip.asc](https://www.apache.org/dist/mina/vysper/0.7/dist/vysper-0.7-bin.zip.asc) | 
| Unix/Linux/Cygwin Distribution | [vysper-0.7-bin.tar.gz](https://www.apache.org/dyn/closer.lua/mina/vysper/0.7/dist/vysper-0.7-bin.tar.gz) | [vysper-0.7-bin.tar.gz.asc](https://www.apache.org/dist/mina/vysper/0.7/dist/vysper-0.7-bin.tar.gz.asc) | 

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

    (Where <version> is replaced with the actual version, e.g., 0.7).

# Getting the Binaries using Maven 2

To use this release in your maven project, the proper dependency configuration that you should use in your [Maven POM](http://maven.apache.org/guides/introduction/introduction-to-the-pom.html) is:

```xml
<dependency>
    <groupId>org.apache.vysper</groupId>
    <artifactId>vysper-core</artifactId>
    <version>0.7</version>
</dependency>
```

# Getting the Source Code

## Source Distributions

| Description | Download Link | PGP Signature file of download | 
|---|---|---|
| Source for Windows | [vysper-0.7-src.zip](https://www.apache.org/dyn/closer.lua/mina/vysper/0.7/vysper-0.7-src.zip) | [vysper-0.7-src.zip.asc](https://www.apache.org/dist/mina/vysper/0.7/vysper-0.7-src.zip.asc) | 
| Source for Unix/Linux/Cygwin | [vysper-0.7-src.tar.gz](https://www.apache.org/dist/mina/vysper/0.7/vysper-0.7-src.tar.gz) | [vysper-0.7-src.tar.gz.asc](https://www.apache.org/dist/mina/vysper/0.7/vysper-0.7-src.tar.gz.asc) | 

## SVN Tag Checkout

svn co https://svn.apache.org/repos/asf/mina/vysper/tags/0.7
