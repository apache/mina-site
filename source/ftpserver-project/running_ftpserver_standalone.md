---
type: ftpserver
title: FtpServer
---

# Running FtpServer stand-alone in 5 minutes

To get FtpServer up and running in stand-alone mode, you need to have a full distribution. Check out to build the source code and make sure you include the build for the distribution module

## Installing

Now you should have a ZIP or TARed file with the entire distribution. Let's go.

First of all, unpack it. If you're on Linux/Unix, you can use:

    tar -xzvf ftpserver-1.0.0.tar.gz

On Windows and Linux/Unix, you can use any ZIP tool, like [7-zip](http://www.7-zip.org/) or [Gnome File Roller](http://fileroller.sourceforge.net/) to unzip the file at a location of your liking.

## Running a basic server

Now, open a shell/command prompt where you unpacked the files. On Linux/Unix, run:

    bin/ftpd.sh

On Windows, the same command is:

    bin/ftpd.bat

FtpServer should now start as expected and you should be able to use a FTP client to access the server at localhost on port 21. The default .

Note that on Linux this command will require root privileges as it tried to listen on port 21, something only root can do. If you're not root, you will get an exception saying "java.net.SocketException: Permission denied". Let's have a look at how to solve this without running as root.

## Configuring

In the res/conf directory in the unpackaged directory you will find some example configuration files. For this tutorial, we will use the ftpd-typical.xml configuration file. It will set the listener port to 2121, thus fixing the issue with not being able to run the server as non-root on Linux. It will also use a provided user database, allowing logging in as admin (password admin) or anonymous. To run, on Linux/Unix:

    bin/ftpd.sh res/conf/ftpd-typical.xml

On Windows:

    bin/ftpd.bat res/conf/ftpd-typical.xml

That's it. Now you can configure the server to your likings. Have a look at either the ftpd-full.xml example or the configuration documentation. You can also set up FtpServer to run as a service on Windows or daemon on Linux/Unix.
