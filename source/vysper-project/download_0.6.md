---
type: vysper
title: Apache Vysper 0.6 Release
---

# New Features in 0.6

This is the second release of Apache Vysper. Updates since the last release includes a full implementation of BOSH, improvements to the MUC implementation and many smaller changes.

This release contains partial implementations of the following specifications:

* RFC 3920 XMPP Core
* RFC 3921 XMPP IM
* XEP-0045 Multi-user chat
* XEP-0060 Publish-subscribe
* XEP-0124 Bidirectional-streams Over Synchronous HTTP (BOSH)
* XEP-0206 XMPP Over BOSH

# Change log

For a detailed view of new features and bug fixes, see the [release notes](https://issues.apache.org/jira/browse/VYSPER/fixforversion/12314873)

# Getting the Binary Distributions

| Description | Download Link | PGP Signature file of download | 
|---|---|---|
| Windows Distribution | [vysper-0.6-bin.zip](https://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-bin.zip) | [vysper-0.6-bin.zip.asc](https://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-bin.zip.asc) | 
| Unix/Linux/Cygwin Distribution | [vysper-0.6-bin.tar.gz](https://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-bin.tar.gz) | [vysper-0.6-bin.tar.gz.asc](https://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-bin.tar.gz.asc) | 

# Verify the Integrity of Downloads

It is essential that you verify the integrity of the downloaded files using the PGP signatures. The PGP signatures can be verified using PGP or GPG. Begin by following these steps:

1. Download the [KEYS](https://www.apache.org/dist/mina/KEYS)
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

    (Where <version> is replaced with the actual version, e.g., 0.6).

# Getting the Binaries using Maven 2

To use this release in your maven project, the proper dependency configuration that you should use in your [Maven POM](http://maven.apache.org/guides/introduction/introduction-to-the-pom.html) is:

```xml
<dependency>
    <groupId>org.apache.vysper</groupId>
    <artifactId>vysper-core</artifactId>
    <version>0.6</version>
</dependency>
```

# Getting the Source Code

## Source Distributions

| Description | Download Link | PGP Signature file of download | 
|---|---|---|
| Source for Windows | [vysper-0.6-src.zip](http://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-src.zip) | [vysper-0.6-src.zip.asc](http://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-src.zip.asc) | 
| Source for Unix/Linux/Cygwin | [vysper-0.6-src.tar.gz](http://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-src.tar.gz) | [vysper-0.6-src.tar.gz.asc](http://archive.apache.org/dist/mina/vysper/0.6/vysper-0.6-src.tar.gz.asc) | 

## SVN Tag Checkout

    svn co http://svn.apache.org/repos/asf/mina/vysper/tags/0.6</SPAN>
