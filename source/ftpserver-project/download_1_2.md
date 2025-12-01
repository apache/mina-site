---
type: ftpserver
title: Apache FtpServer 1.2.1 Release
---

# Apache FtpServer 1.2.1 Release

## New Features in 1.2.1

This release includes many fixes, and now depends on MINA core 2.2.4.

Here is the list of fixes and modifications:

o [FTPSERVER-515](https://issues.apache.org/jira/projects/FTPSERVER-515): Bump Apache Log4j from 2.17.2 to 2.19.0
o [FTPSERVER-510](https://issues.apache.org/jira/projects/FTPSERVER-510):Update Apache parent POM from 25 to 26
o [FTPSERVER-509](https://issues.apache.org/jira/projects/FTPSERVER/issues/FTPSERVER-509): Enable GitHub Action build
o [FTPSERVER-506](https://issues.apache.org/jira/projects/FTPSERVER-506): Fix binary compatibility issues.
o [FTPSERVER-499](https://issues.apache.org/jira/projects/FTPSERVER/issues/FTPSERVER-499): FtpResponseEncoder is not thread safe
o [FTPSERVER-446](https://issues.apache.org/jira/projects/FTPSERVER-446): Implementing User Manager not possible in OSGi environment


Otherwise, the following features have been added:
o Support for SHA256 and SHA512 encryption
o Use ThreadLocal for FtpResponseEncoder.ENCODER and SimpleDateFormat
o Make build reproductible

## Getting the Binary Distributions

| Description | Download Link | SHA256 hashes  | SHA512 hashes  | PGP Signature file of download |
|---|---|---|---|---|
| zip distribution | [apache-ftpserver-1.2.1-bin.zip](https://dlcdn.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.zip) | [SHA256](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.zip.sha256) | [SHA512](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.zip.sha512) |[ASC](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.zip.asc) |
| tar.gz distribution | [apache-ftpserver-1.2.1-bin.tar.gz](https://dlcdn.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.gz) | [SHA256](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.gz.sha256) | [SHA512](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.gz.sha512) | [ASC](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.gz.asc) | 
| tar.bz2 distribution | [apache-ftpserver-1.2.1-bin.tar.bz2](https://dlcdn.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.bz2) | [SHA256](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.bz2.sha256) | [SHA512](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.bz2.sha512) | [ASC](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-bin.tar.bz2.asc) | 

## Verify the Integrity of Downloads

It is essential that you verify the integrity of the downloaded files using the PGP signatures. The PGP signatures can be verified using PGP or GPG. Begin by following these steps:

1. Download the [KEYS](https://downloads.apache.org/mina/KEYS)
2. Download the asc signature file for the relevant distribution
3. Verify the signatures using the following commands, depending on your use of PGP or GPG:

        $ pgpk -a KEYS
        $ pgpv apache-ftpserver-1.2.1-bin.tar.gz.asc

    or 

        $ pgp -ka KEYS
        $ pgp apache-ftpserver-1.2.1-bin.tar.gz.asc apache-ftpserver-1.2.1-bin.tar.gz

    or

        $ gpg --import KEYS
        $ gpg --verify apache-ftpserver-1.2.1-bin.tar.gz.asc apache-ftpserver-1.2.1-bin.tar.gz

## Getting the Binaries using Maven 2

To use this release in your maven project, the proper dependency configuration that you should use in your [Maven POM](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html) is:

```xml
<dependency>
    <groupId>org.apache.ftpserver</groupId>
    <artifactId>ftpserver-core</artifactId>
    <version>1.2.1</version>
</dependency>
```

## Getting the Source Code

### Source Distributions

| Description | Download Link | SHA256 hashes | SHA512 hashes | PGP Signature file of download |
|---|---|---|---|---|
| zip sources | [apache-ftpserver-1.2.1-src.zip](https://dlcdn.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.zip) | [SHA256](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.zip.sha256) | [SHA512](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.zip.sha512) | [ASC](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.zip.asc) |
| tar.gz sources | [apache-ftpserver-1.2.1-src.tar.gz](https://dlcdn.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.gz) | [SHA256](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.gz.sha256) | [SHA512](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.gz.sha512) | [ASC](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.gz.asc) |
| tar.bz2 sources | [apache-ftpserver-1.2.1-src.tar.bz2](https://dlcdn.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.bz2) | [SHA256](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.bz2.sha256) | [SHA512](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.bz2.sha512) | [ASC](https://downloads.apache.org/mina/ftpserver/1.2.1/apache-ftpserver-1.2.1-src.tar.bz2.asc) |

### Git Tag Checkout

    $ git clone https://gitbox.apache.org/repos/asf/mina-ftpserver.git
    $ git checkout ftpserver-parent-1.2.1

You are now on 1.2.1 branch.
