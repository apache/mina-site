---
type: ftpserver
title: FtpServer Configuration
---

# Configuration

## Overview

This document explains the Apache FTP Server configuration parameters. All the configuration parameters are grouped depending on the component where it has been used. The configuration format is XML based and comes with a matching XML Schema that can be used in XML editors to simplify configuration.

The XML document scaffold looks like this:

```xml
<server xmlns="http://mina.apache.org/ftpserver/spring/v1"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://mina.apache.org/ftpserver/spring/v1 http://mina.apache.org/ftpserver/ftpserver-1.0.xsd"
    id="myServer">
</server>
```
The id attribute can be set to any value of your liking, but is required.

In-between the server element, you can now add elements to configure each component within the server instance, such as listeners and user managers.

## Integration with Spring Framework

Apache FtpServer uses Spring Framework to implement the configuration. That also means that we get the added benefit of full integration with regular Spring XML configuration. For example, you can embed the "server" element where ever you like within you Spring configuration, and with FtpServer on the classpath, Spring will wire up the server for you.

## Detailed configuration specifications

The following pages contains the full documentation on the available configuration.

* Server - the main server configuration such as connectivity limits
* Listeners - configuration for listeners, such as SSL settings and ports
* User Manager - configuration for user managers, for example how to set up a file based user manager
