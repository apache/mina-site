---
title: MINA 2.0.x Downloads
---

# Latest MINA Releases

## Apache MINA 2.0.26 <font color="green">stable</font> (Java 8+)

### Binaries

* .tar.gz archive [mina-2.0.26](https://www.apache.org/dyn/closer.lua/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.gz) (signatures : [SHA256](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.gz.sha256) [SHA512](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.gz.sha512) [ASC](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.gz.asc))
* .tar.bz2 archive [mina-2.0.26](https://www.apache.org/dyn/closer.lua/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.bz2) (signatures : [SHA256](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.bz2.sha256) [SHA512](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.bz2.sha512) [ASC](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.tar.bz2.asc))
* .zip archive [mina-2.0.26](https://www.apache.org/dyn/closer.lua/mina/mina/2.0.26/apache-mina-2.0.26-bin.zip) (signatures : [SHA256](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.zip.sha256) [SHA512](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.zip.sha512) [ASC](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-bin.zip.asc))

### Sources

* .src.tar.gz archive [mina-2.0.26](https://www.apache.org/dyn/closer.lua/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.gz) (signatures : [SHA256](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.gz.sha256) [SHA512](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.gz.sha512) [ASC](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.gz.asc))
* .src.tar.bz2 archive [mina-2.0.26](https://www.apache.org/dyn/closer.lua/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.bz2) (signatures : [SHA256](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.bz2.sha256) [SHA512](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.bz2.sha512) [ASC](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.tar.bz2.asc))
* .src.zip archive [mina-2.0.26](https://www.apache.org/dyn/closer.lua/mina/mina/2.0.26/apache-mina-2.0.26-src.zip) (signatures : [SHA256](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.zip.sha256) [SHA512](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.zip.sha512) [ASC](https://www.apache.org/dist/mina/mina/2.0.26/apache-mina-2.0.26-src.zip.asc))

<div class="note" markdown="1">
    For people wanting to use the <strong>serial</strong> package, we don't include the <strong>rxtx.jar</strong> library in the releases, as it's under a LGPL license. Please download it from <a href="http://rxtx.qbang.org/wiki/index.php/Download" class="external-link" rel="nofollow">http://rxtx.qbang.org/wiki/index.php/Download</a> or add the associated dependency in your maven pom.xml :

    <dependency>
        <groupId>org.rxtx</groupId>
        <artifactId>rxtx</artifactId>
        <version>2.1.7</version>
        <scope>provided<scope>
    </dependency>
</div>

## Older versions

Older versions can be found [on https://archive.apache.org/dist/mina/](https://archive.apache.org/dist/mina/)

# Verify the integrity of the files

The PGP signatures can be verified using PGP or GPG. First download the [KEYS](https://downloads.apache.org/mina/KEYS) as well as the asc signature file for the relevant distribution. Then verify the signatures using:

```bash
$ pgpk -a KEYS
$ pgpv mina-2.0.26.tar.gz.asc
```

or

```bash
$ pgp -ka KEYS
$ pgp mina-2.0.26.tar.gz.asc
```

or

```bash
$ gpg --import KEYS
$ gpg --verify mina-2.0.26.tar.gz.asc
```

Alternatively, you can verify the checksums of the files (see the [How to verify downloaded files page](https://www.apache.org/info/verification.html)). 

# Previous Releases

The previous releases can be found on [https://archive.apache.org/dist/mina/](https://archive.apache.org/dist/mina/). Please note that the following releases contains a LGPL licensed file, rxtx-2.1.7.jar: 2.0.0-M4, 2.0.0-M5, 2.0.0-M6, 2.0.0-RC1.

# Version Numbering Scheme

The version number of MINA has the following form:

<div class="info" markdown="1">
    <tt>&lt;major&gt;.&lt;minor&gt;.&lt;micro&gt;[-milestone number&gt; or -RC&lt;release candidate number&gt;]</tt>
</div>

This scheme has three number components:

* The __major__ number increases when there are incompatible changes in the API.
* The __minor__ number increases when a new feature is introduced.
* The __micro__ number increases when a bug or a trivial change is made.

and an optional label that indicates the maturity of a release:

* __M__ (Milestone) means the feature set can change at any time in the next milestone releases. The last milestone release becomes the first release candidate after a vote.
* __RC__ (Release Candidate) means the feature set is frozen and the next RC releases will focus on fixing problems unless there is a serious flaw in design. The last release candidate becomes the first GA release after a vote.
* No label implies __GA__ (General Availability), which means the release is stable enough and therefore ready for production environment.

MINA is not a stand-alone software, so 'the feature set' here also includes the API of the newly introduced features and the overall architecture of the software,

Here's an example that illustrates how MINA version number increases:

<div class="info" markdown="1">
    2.0.0-M1 -> 2.0.0-M3 -> 2.0.0-M3 -> 2.0.0-M4 ->  2.0.0-RC1 -> 2.0.0-RC2 -> 2.0.0-RC3 - <strong>2.0.0</strong> -> 2.0.1 ->; 2.0.2 ->; 2.1.0-M1 ...
</div>

Please note that we always specify the micro number, even if it's zero.
