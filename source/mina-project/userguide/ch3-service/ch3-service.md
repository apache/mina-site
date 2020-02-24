---
type: mina
title: Chapter 3 - Service
navPrev: ../ch2-basics/ch2-basics.html
navPrevText: Chapter 2 - Basics
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch4-session/ch4-session.html
navNextText: Chapter 4 - Session
---

# Chapter 3 - IoService

A **MINA** _IoService_ - as seen in the [application architecture](../ch2-basics/ch2.1-application-architecture.html) chapter, is the base class supporting all the **IO** services, either from the server side or the client side. 

It will handle all the interaction with your application, and with the remote peer, send and receive messages, manage sessions, connections, etc.

It's an interface, which is implemented as an _IoAcceptor_ for the server side, and _IoConnector_ for the client side.

We will expose the interface in those chapters :

* [3.1 - IoService Introduction](ch3.1-io-service.html)
* [3.2 - IoService Details](ch3.2-io-service-details.html)
* [3.3 - IoAcceptor](ch3.3-acceptor.html)
* [3.4 - IoConnector](ch3.4-connector.html)

