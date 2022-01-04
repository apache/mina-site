---
type: ftpserver
title: Apache FtpServer 1.1.1 Release
---

# Apache FtpServer 1.1.1 Release

## New Features in 1.1.1

This release fixes a few issues found since the release of 1.1.0.

## Changelog

For a more detailed view of new features and bug fixes, see the [release notes](https://issues.apache.org/jira/browse/FTPSERVER/fixforversion/12338633)

## Getting the Binary Distributions

| Description | Download Link | SHA1 hashes  | PGP Signature file of download |
|---|---|---|---|
| zip distribution | [apache-ftpserver-1.1.1.zip](https://www.apache.org/dyn/closer.lua/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.zip) | [SHA1](https://www.apache.org/dist/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.zip.sha1) | [ASC](https://www.apache.org/dist/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.zip.asc) |
| tar.gz distribution | [apache-ftpserver-1.1.1.tar.gz](https://www.apache.org/dyn/closer.lua/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.tar.gz) | [SHA1](https://www.apache.org/dist/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.tar.gz.sha1) | [ASC](https://www.apache.org/dist/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.tar.gz.asc) | 
| tar.bz2 distribution | [apache-ftpserver-1.1.1.tar.bz2](https://www.apache.org/dyn/closer.lua/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.tar.bz2) | [SHA1](https://www.apache.org/dist/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.tar.bz2.sha1) | [ASC](https://www.apache.org/dist/mina/ftpserver/1.1.1/dist/apache-ftpserver-1.1.1.tar.bz2.asc) | 

## Verify the Integrity of Downloads

It is essential that you verify the integrity of the downloaded files using the PGP signatures. The PGP signatures can be verified using PGP or GPG. Begin by following these steps:

1. Download the [KEYS](https://downloads.apache.org/mina/KEYS)
2. Download the asc signature file for the relevant distribution
3. Verify the signatures using the following commands, depending on your use of PGP or GPG:

        $ pgpk -a KEYS
        $ pgpv ftpserver-1.1.1.tar.gz.asc

    or 

        $ pgp -ka KEYS
        $ pgp ftpserver-1.1.1.tar.gz.asc ftpserver-1.1.1.tar.gz

    or

        $ gpg --import KEYS
        $ gpg --verify ftpserver-1.1.1.tar.gz.asc ftpserver-1.1.1.tar.gz

## Getting the Binaries using Maven 2

To use this release in your maven project, the proper dependency configuration that you should use in your [Maven POM](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html) is:

```xml
<dependency>
    <groupId>org.apache.ftpserver</groupId>
    <artifactId>ftpserver-core</artifactId>
    <version>1.1.1</version>
</dependency>
```

## Getting the Source Code

### Source Distributions

| Description | Download Link | SHA1 hashes  | PGP Signature file of download |
|---|---|---|---|
| zip sources | [apache-ftpserver-1.1.1-src.zip](https://www.apache.org/dyn/closer.lua/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.zip) | [SHA1](https://www.apache.org/dist/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.zip.sha1)| [ASC](https://www.apache.org/dist/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.zip.asc) |
| tar.gz sources | [apache-ftpserver-1.1.1-src.tar.gz](https://www.apache.org/dyn/closer.lua/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.tar.gz) | [SHA1](https://www.apache.org/dist/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.tar.gz.sha1) | [ASC](https://www.apache.org/dist/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.tar.gz.asc) |
| tar.bz2 sources | [apache-ftpserver-1.1.1-src.tar.bz2](https://www.apache.org/dyn/closer.lua/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.tar.bz2) | [SHA1](https://www.apache.org/dist/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.tar.bz2.sha1) | [ASC](https://www.apache.org/dist/mina/ftpserver/1.1.1/apache-ftpserver-1.1.1-src.tar.bz2.asc) |

### Git Tag Checkout

    $ git clone https://gitbox.apache.org/repos/asf/mina-ftpserver.git
    $ git checkout ftpserver-1.1.1

You are now on 1.1.1 branch.
