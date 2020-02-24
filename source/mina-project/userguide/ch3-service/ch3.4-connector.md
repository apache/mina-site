---
type: mina
title: 3.4 - Connector
navPrev: ch3.3-acceptor.html
navPrevText: 3.3 - Acceptor
navUp: ch3-service.html
navUpText: Chapter 3 - Service
navNext: ../ch4-session/ch4-session.html
navNextText: Chapter 4 - Session
---

# 3.4 - Connector

For client applications, you need to implement an implementation of the IoConnector interface.

## IoConnector

As we have to use an IoAcceptor for servers, you have to implement the IoConnector. Again, we have many implementation classes :

* __NioSocketConnector__ : the non-blocking Socket transport Connector
* __NioDatagramConnector__ : the non-blocking UDP transport * Connector*
* __AprSocketConnector__ : the blocking Socket transport * Connector*, based on APR
* __ProxyConnector__ : a Connector providing proxy support
* __SerialConnector__ : a Connector for a serial transport
* __VmPipeConnector__ : the in-VM * Connector*

Just pick the one that fit your need.

Here is the class diagram for the IoConnector interfaces and classes :

![](/assets/img/mina/IoServiceConnector.png)

