---
type: ftpserver
title: FtpServer Installation
---

# Installation

## Binary Distribution

Download the binary distribution and unzip it. The zip file includes sample configuration files

Typical server set up : <INSTALL_DIR>/res/conf/ftpd-typical.xml

* Full example configuration file : <INSTALL_DIR>/res/conf/ftpd-full.xml
* If you want to use your own jar files, you can put those jar files in system CLASSPATH or copy those jar files in the <INSTALL_DIR>/common/lib directory.

To run the server, go to <INSTALL_DIR> directory and execute ftpd.bat (if Windows) or ftpd.sh (if UNIX or Linux). In this case you need to pass the configuration file location. Usage:

    ftpd [<options>] [<configuration file>]
        <options> := --default
          <configuration file> := <XML configuration file>

In case of no option, default configuration will be used.

Installing FtpServer as a Windows service

### Binary Distribution Directory Structure

    <INSTALL_DIR>
      |
      |--- common
      |     |
      |     |--- classes
      |     |
      |     |--- lib
      |
      |--- docs
      |     
      |--- javadoc
      |
      |--- res
            |
            |--- conf
            |
            |--- home
            |
            |--- log
