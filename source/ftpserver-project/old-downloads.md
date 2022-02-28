---
type: ftpserver
title: FtpServer Older Downloads
---

# Older FtpServer Releases

## FtpServer 1.1.x

<center>

| Version| Download Links | Date |
|:-:|:-:|:-:|
| Apache FtpServer 1.1.2 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.1.2/) | 03/Jan/2022 |
| Apache FtpServer 1.1.1 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.1.1/) | 03/Jul/2020 |
| Apache FtpServer 1.1.0 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.1.0/) | 02/Jun/2019 |

</center>

## FtpServer 1.0.x

Note that this version is not anymore maintained.
<center>

| Version| Download Links | Date |
|:-:|:-:|:-:|
| Apache FtpServer 1.0.6 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.6/) | 04/May/2018 |
| Apache FtpServer 1.0.5 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.5/) | 02/Oct/2010 |
| Apache FtpServer 1.0.4 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.4/) | 13/Mar/2009 |
| Apache FtpServer 1.0.3 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.3/) | 17/Jun/2009 |
| Apache FtpServer 1.0.2 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.2/) | 17/Jun/2009 |
| Apache FtpServer 1.0.1 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.1/) | 18/May/2009 |
| Apache FtpServer 1.0.0 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.0/) | 28/Feb/2009 |
| Apache FtpServer 1.0.0-RC2 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC2/) | 31/Jan/2009 |
| Apache FtpServer 1.0.0-RC1 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.0-RC1/) | 13/Jan/2009 |
| Apache FtpServer 1.0.0-M4 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.0-M4/) | 10/Dec/2008 |
| Apache FtpServer 1.0.0-M3 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.0-M3/) | 08/Sep/2008 |
| Apache FtpServer 1.0.0-M2 | [Download](https://archive.apache.org/dist/mina/ftpserver/1.0.0_M2/) | 11/Aug/2008 |

</center>


# Verify the integrity of the files

The PGP signatures can be verified using PGP or GPG. First download the [KEYS](https://downloads.apache.org/mina/KEYS) as well as the asc signature file for the relevant distribution. Then verify the signatures using:

    $ pgpk -a KEYS
    $ pgpv apache-ftpserver-1.1.3.tar.gz.asc

or

    $ pgp -ka KEYS
    $ pgp apache-ftpserver-1.1.3.tar.gz.asc
    
or

    $ gpg --import KEYS
    $ gpg --verify apache-apache-ftpserver-1.1.3.tar.gz.asc


# Previous Releases

The previous releases can be found [here](https://archive.apache.org/dist/mina/ftpserver).

# Version Numbering Scheme

The version number of FtpServer has the following form:

<div class="info" markdown="1">
    &lt;major>.&lt;minor>.&lt;micro> \[-M&lt;milestone number> or -RC&lt;release candidate number>]
</div>

This scheme has three number components:

* The __major__ number increases when there are incompatible changes in the API.
* The __minor__ number increases when a new feature is introduced.
* The __micro__ number increases when a bug or a trivial change is made.

and an optional label that indicates the maturity of a release:

* __M__ (Milestone) means the feature set can change at any time in the next milestone releases. The last milestone release becomes the first release candidate after a vote.
* __RC__ (Release Candidate) means the feature set is frozen and the next RC releases will focus on fixing problems unless there is a serious flaw in design. The last release candidate becomes the first GA release after a vote.
* No label implies __GA__ (General Availability), which means the release is stable enough and therefore ready for production environment.

Here's an example that illustrates how FtpServer version number increases:

<div class="info" markdown="1">
    1.0.0-M1 -> 1.0.0-M2 -> 1.0.0-M3 -> 1.0.0-M4 ->  1.0.0-RC1 -> 1.0.0-RC2 -> 1.0.0-RC3 -> <strong>1.0.0</strong> -> 1.0.1 -> 1.0.2 -> 1.1.0-M1 ...
</div>

Please note that we always specify the micro number, even if it's zero.
