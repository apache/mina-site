---
type: ftpserver
title: Installing FtpServer as a Windows service
---

# Installing FtpServer as a Windows service

## Install

Apache FtpServer can be installed as a Windows service using the following command:

    <install dir>bin\service install

This will create a service called Apache FtpServer that can be started and stopped as a usual service.

As a second parameter, the service identifier can be provided. This would normally be used if multiple FtpServer services should be installed, for example:

    <install dir>bin\service install ftpd2

Without any further options, this will use the default configuration. If you want to use for example an XML configuration file you should run:

    <install dir>bin\service install ftpd <path to XML configuration file>

## Service administration GUI

After installing the service, it can be further configured using the service GUI by running:

    <install dir>bin\ftpdw

## Uninstall

To uninstall the service, use:

    <install dir>bin\service remove
