---
type: mina
title: Chapter 10 - Executor Filter
navPrev: ../ch9-codec-filter/ch9-codec-filter.html
navPrevText: Chapter 9 - Codec Filter
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch11-ssl-filter/ch11-ssl-filter.html
navNextText: Chapter 11 - SSL Filter
---

# Chapter 10 - Executor Filter

MINA 1.X version let the user define the Thread Model at the Acceptor level. It was part of the Acceptor configuration. This led to complexity, and the MINA team decided to remove this option, replacing it with a much more versatile system, based on a filter : the __ExecutorFilter__.

## The ExecutorFilter class

This class is implementing the IoFilter interface, and basically, it contains an Executor to spread the incoming events to a pool of threads. This will allow an application to use more efficiently the processors, if some tasks are CPU intensive.

This Filter can be used just before the handlers, assuming that most of the processing will be done in your application, or somewhere before some CPU intensive filter (for instance, a CodecFilter).

It uses an _Executor_ instance to process the tasks, and can limit the number of events that can be sent to this executor. By default, the following events can be passed to the executor:

* close
* event
* exceptionCaught
* inputClosed
* messageReceived
* messageSent
* sessionCreated
* sessionClosed
* sessionIdle
* sessionOpened
* write
