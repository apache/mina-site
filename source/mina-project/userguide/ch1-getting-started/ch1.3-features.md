---
type: mina
title: 1.3 Features
navPrev: ch1.2-why-mina.html
navPrevText: 1.2 - Why MINA ?
navUp: ch1-getting-started.html
navUpText: Chapter 1 - Getting Started
navNext: ch1.4-first-steps.html
navNextText: 1.4 - First steps
---

# Features

MINA is a simple yet full-featured network application framework which provides:

* Unified API for various transport types:
    * TCP/IP & UDP/IP via Java NIO
    * Serial communication (RS232) via RXTX
    * In-VM pipe communication
    * You can implement your own!
* Filter interface as an extension point; similar to Servlet filters
* Low-level and high-level API:
    * Low-level: uses ByteBuffers
    * High-level: uses user-defined message objects and codecs
* Highly customizable thread model:
    * Single thread
    * One thread pool
    * More than one thread pools (i.e. SEDA)
* Out-of-the-box SSL &middot; TLS &middot; StartTLS support using Java 5 SSLEngine
* Overload shielding & traffic throttling
* Unit testability using mock objects
* JMX managability
* Stream-based I/O support via StreamIoHandler
* Integration with well known containers such as PicoContainer and Spring
* Smooth migration from Netty, an ancestor of Apache MINA.
