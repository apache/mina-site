---
type: mina
title: MINA Home
slug: index
---

# Welcome to Apache MINA

## Overview

Apache  <abbr title="Multipurpose Infrastructure for Network Applications">MINA</abbr> is a network application framework which helps users develop high performance and high scalability network applications easily.  It provides an abstract {{< html "&middot;" >}} event-driven {{< html "&middot;" >}} asynchronous API over various transports such as TCP/IP and UDP/IP via Java NIO.

Apache MINA is often called:

* NIO framework {{< html "&middot;" >}} library,
* client {{< html "&middot;" >}} server framework {{< html "&middot;" >}} library, or
* a networking {{< html "&middot;" >}} socket library.

However, it's much more than that.  Please take a look around the list of the *[features](features.html)* that enable rapid network application development, and *[what people says about MINA](testimonials.html)*.  

Please grab yourself a *[2.1.x download](downloads_2_2.html)*, a *[2.1.x download](downloads_2_1.html)* or a *[2.0.x download](downloads_2_0.html)*, try our *[Quick Start Guide](quick-start-guide.html)*, surf our *[FAQ](faq.html)* or start join us on *[our community](../contact.html)*

## WARNING

The fix for **CVE-2026-47065** changed the form **MINA** writes for serialized objects exchanged through _IoBuffer.putObject_ / _getObject_ and _ObjectSerializationCodecFactory_: after the class name, the full standard **Java** serialization class descriptor is now written. 

Streams produced by **2.2.7**, **2.1.12** or **2.0.28** and earlier cannot be read by **2.2.8**, **2.1.13** or **2.0.29** and later, and streams produced by the newer releases cannot be read by the older ones. 

Arrays, primitives and non-Serializable classes are unaffected. 

Upgrades across this boundary fail with a _BufferDataException_ wrapping an _EOFException_ or a _StreamCorruptedException_, and payloads persisted before the upgrade become unreadable after it.

<div class="news">
    {{< grabpage "mina-project/news.md" >}}
</div>
