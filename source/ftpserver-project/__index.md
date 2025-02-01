---
type: ftpserver
title: FtpServer Home
slug: index
---

# Welcome to Apache FtpServer

## Overview

The **Apache FtpServer** is a 100% pure **Java FTP** server. It's designed to be a complete and portable **FTP** server engine solution based on currently available open protocols. **FtpServer** can be run standalone as a _Windows_ service or _Unix/Linux_ daemon, or embedded into a **Java** application. We also provide support for integration within [Spring](http://www.springsource.org/) applications and provide our releases as **OSGi** bundles.

The default network support is based on [Apache MINA](/), a high performance asynchronous **IO** library. Using **MINA**, **FtpServer** can scale to a large number of concurrent users.

It is also an **FTP** application platform. We have developed a **Java API** to let you write **Java** code to process **FTP** event notifications that we call the **Ftplet API**. **Apache FtpServer** provides an implementation of an **FTP** server to support this **API**.

To get started, have a look at one of our tutorials:

* [Embedding FtpServer in 5 minutes](embedding_ftpserver.html)
* [Running FtpServer stand-alone in 5 minutes](running_ftpserver_standalone.html)

You can also have a look at the documentation for how to configure **FtpServer** to suite your needs.

## History

The inital code comes from the defunct **[Apache Avalon](https://avalon.apache.org/closed.html)** project. It was brought to incubator by _Paul Hammant_, the initial contributor, and graduated as a **MINA** subproject in December 2007.


