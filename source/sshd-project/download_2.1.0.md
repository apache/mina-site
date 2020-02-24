---
type: sshd
title: Apache SSHD 2.1.0 Release
---

# Overview

Apache Mina SSHD 2.1.0 contains a number of [enhancements and bug-fixes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12310849&version=12342654).

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 2.1.0 Sources (.tar.gz)](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0-src.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0-src.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0-src.tar.gz.sha1)
    * [Apache Mina SSHD 2.1.0 Sources (.zip)](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0-src.zip) [PGP](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0-src.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0-src.zip.sha1)
* Binary distributions:
    * [Apache Mina SSHD 2.1.0 Binary (.tar.gz)](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0.tar.gz) [PGP](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0.tar.gz.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0.tar.gz.sha1)
    * [Apache Mina SSHD 2.1.0 Binary (.zip)](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0.zip) [PGP](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0.zip.asc) [SHA](https://archive.apache.org/dist/mina/sshd/2.1.0/apache-sshd-2.1.0.zip.sha1)

# Release Notes

A few backward incompatible changes have been made since the previous release, thus the version has been named 2.1 accordingly, in order to emphasize this fact. The major issues addressed in this release are:

* In accordance with the policy of making the SSHD code less monolithic in nature, 2 new artifacts have been established:
    - sshd-common - contains common code that is used throughout the other artifacts - mainly SSH related definitions and support code that deals with keys, ciphers, fingerprints, etc.. - but no client or server code. The Maven dependencies have been updated accordingly, so users who declare a dependency on "sshd-core" (and other previous version artifacts) will automatically include the "sshd-common" artifact as well.
    - sshd-putty - ("spin off" from sshd-contrib) - contains the code necessary to use Putty key files for authentication. Users who previously used "sshd-contrib" Maven dependency for this purpose should replace it with "sshd-putty".
* Fixed some issues related to port forwarding - mainly correctly un-binding the locally bound ports used for tunnels.
* Fixed the ability to disable registering security providers using system property configuration.
* Use Nio2ServiceFactoryFactory as the hardwired default if no other found or explicitly set.

Users are encouraged to read the documentation available at https://github.com/apache/mina-sshd/ which has been updated to reflect the necessary code changes.

Advisory notice regarding building the code from the released (ZIP/TAR.GZ) sources distribution:
------------------------------------------------------------------------------------------------

A minor issue has been discovered in this context for users who wish to build the artifacts from these distributions instead of the GIT repository. There are 2 "hostkey.ser" files that have been included by mistake - one in the "sshd-core" folder and the other in the"sshd-netty" one. These files are actually products of previous builds, and they interfere with the unit tests causing them to fail. Users who wish to build the project from the ZIP/TAR.GZ source distributions should delete the 2 aforementioned files before proceeding with the build.

In this context it is important to emphasize:

* The said problem affects the build process only when it is attempting to run the unit tests - the released production artifacts on Maven Central or the ones generated locally as a result of the build process are not affected in any way.
* This issue does not affect in any way users who wish to build the artifacts from the GIT repository sources.
* The "offending" files have been correctly excluded in the latest development master branch - so future releases should no longer suffer from this problem.

We recommend all users to upgrade to this release - we consider this a stable and production ready release.

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
