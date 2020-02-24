---
type: ftpserver
title: Apache FtpServer 1.0.0-RC1 Release
---

# Apache FtpServer 1.0.0-RC1 Release

## New Features in 1.0.0-RC1

This release mainly contains bug fixes and minor enhancements from the previous release.

## Changelog

For a more detailed view of new features and bug fixes, see the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=10571&styleName=Html&version=12313542)

## Getting the Binary Distributions

| Description | Download Link | SHA1 hashes  | PGP Signature file of download |
|---|---|---|---|
| zip distribution | [ftpserver-1.0.0-RC1.zip](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1.zip) | [SHA1](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1.zip.sha1) | [ftpserver-1.0.0-RC1.zip.asc](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1.zip.asc) |
| tar.gz distribution | [ftpserver-1.0.0-RC1.tar.gz](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1.tar.gz) | [SHA1](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1.tar.gz.sha1) | [ftpserver-1.0.0-RC1.tar.gz.asc](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1.tar.gz.asc) | 

## Verify the Integrity of Downloads

It is essential that you verify the integrity of the downloaded files using the PGP signatures. The PGP signatures can be verified using PGP or GPG. Begin by following these steps:

1. Download the [KEYS](https://www.apache.org/dist/mina/KEYS)
2. Download the asc signature file for the relevant distribution
3. Verify the signatures using the following commands, depending on your use of PGP or GPG:

        $ pgpk -a KEYS
        $ pgpv ftpserver-1.0.0-RC1.tar.gz.asc

    or 

        $ pgp -ka KEYS
        $ pgp ftpserver-1.0.0-RC1.tar.gz.asc

    or

        $ gpg --import KEYS
        $ gpg --verify ftpserver-1.0.0-RC1.tar.gz.asc

## Getting the Binaries using Maven 2

To use this release in your maven project, the proper dependency configuration that you should use in your [Maven POM](http://maven.apache.org/guides/introduction/introduction-to-the-pom.html) is:

```xml
<dependency>
    <groupId>org.apache.ftpserver</groupId>
    <artifactId>ftpserver-core</artifactId>
    <version>1.0.0-RC1</version>
</dependency>
```

## Getting the Source Code

### Source Distributions

| Description | Download Link | SHA1 hashes  | PGP Signature file of download |
|---|---|---|---|
| zip sources | [ftpserver-1.0.0-RC1-src.zip](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1-src.zip) |  [SHA1](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1-src.zip.sha1)| [ftpserver-1.0.0-RC1-src.zip.asc](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1-src.zip.asc) |
| tar.gz sources | [ftpserver-1.0.0-RC1-src.tar.gz](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1-src.tar.gz) |  [SHA1](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1-src.tar.gz.sha1) | [ftpserver-1.0.0-RC1-src.tar.gz.asc](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/ftpserver-1.0.0-RC1-src.tar.gz.asc) |


### SVN Tag Checkout

    svn co http://svn.apache.org/repos/asf/mina/ftpserver/tags/1.0.0-RC1
