---
type: sshd
title: SSHD Overview
slug: index
---

# Overview

Apache MINA SSHD is a 100% pure java library to support the SSH protocols on both the client and server side. It does not
aim at being a replacement for the SSH client or SSH server from Unix operating systems, but rather provides support for Java
based applications requiring SSH support.

The library can leverage several I/O back-ends:

* The default transport is built-in and uses Java's `AsynchronousSocketChannel`s.
* [Apache MINA](../mina-project/), a scalable and high performance asynchronous I/O library, can be used instead, or
* the [Netty](https://netty.io) asynchronous event-driven network framework is also supported.

The technical documentation is maintained in the [source tree](https://github.com/apache/mina-sshd).
