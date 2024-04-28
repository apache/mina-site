---
type: mina
title: 1.1 - NIO Overview
navPrev: ch1-getting-started.html
navPrevText: Chapter 1 - Getting Started
navUp: ch1-getting-started.html
navUpText: Chapter 1 - Getting Started
navNext: ch1.2-why-mina.html
navNextText: 1.2 - Why MINA ?
---

# NIO Overview

The **NIO** API was introduced in **Java 1.4** and had since been used for wide number of applications. The **NIO** API covers **IO** non-blocking operations.

<div class="note" markdown="1">
    First of all, it's good to know that <strong>MINA</strong> is written on top of <strong>NIO 1</strong>. A new version has been designed in <strong>Java 7</strong>, <strong>NIO-2</strong>, we don't yet benefit from the added features this version is carrying.
</div>

<div class="note" markdown="1">
    It's also important to know that the <strong>N</strong> in <strong>NIO</strong> means <strong>New</strong>, but we will use the <strong>Non-Blocking</strong> term in many places. <strong>NIO-2</strong> should be seen as a <strong>New New I/O</strong>...
</div>

The `java.nio.*` package contains following key constructs

* _Buffers_ - Data Containers
* _Chartsets_ - Containers translators for bytes and Unicode
* _Channels_ - represents connections to entities capable of I/O operations
* _Selectors_ - provide selectable, multiplexed non-blocking IO 
* _Regexps_ - provide provide some tools to manipulate regular expressions

We are mostly interested in the _Channels_, _Selectors_ and _Buffers_ parts in the **MINA** framework, except that we want to hide those elements to the user. 

This user guide will thus focus on everything built on top of those internal components.

# NIO vs BIO

It's important to understand the difference between those two APIs. **BIO**, or **Blocking** **IO**, relies on plain sockets used in a blocking mode: when you read, write or do whatever operation on a socket, the called operation will block the caller until the operation is completed.

In some cases, it's critical to be able to call the operation, and to expect the called operation to inform the caller when the operation is done: the caller can then do something else in the mean time.

This is also where **NIO** offers a better way to handle **IO** when you have numerous connected sockets: you don't have to create a specific thread for each connection, you can just use a few threads to do the same job.

If you want to get more information about what covers **NIO**, there is a lot of good articles around the web, and a few books covering this matter.
