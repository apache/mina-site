---
type: ftpserver
title: FtpServer Building
---

# Building

You need [Subversion](http://svnbook.red-bean.com/) to [check out the source code](http://apache.org/dev/version-control.html) from [our source code repository](getting_source.html), and [Maven 2](http://maven.apache.org/download.html) to build the source code. Currently, Maven 2.0.5 or 2.0.7 or newer is required for the build.

The following example shows how to build the trunk.

    $ svn co http://svn.apache.org/repos/asf/mina/ftpserver/trunk/ ftpserver
    $ cd ftpserver
    $ mvn install

If you run into any problems running these steps, please report on the [mailing lists](mailing_list.html)

If you want to generate Eclipse project files, run:

    $ mvn eclipse:eclipse   # Generate Eclipse project files if you want

To generate to distribution packages, including shell scripts and example configuration, run:

    cd distribution
    $ mvn package

The build requires a minimum Java 1.5 JDK to compile.

