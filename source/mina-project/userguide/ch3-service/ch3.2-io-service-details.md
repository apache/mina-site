---
type: mina
title: 3.2 - IoService Details
navPrev: ch3.1-io-service.html
navPrevText: 3.1 - IoService Introduction
navUp: ch3-service.html
navUpText: Chapter 3 - Service
navNext: ch3.3-acceptor.html
navNextText: 3.3 - Acceptor
---

# 3.2 - IoService Details

_IoService_ is an interface that is implemented by the two most important classes in **MINA** :

* IoAcceptor
* IoConnector

In order to build a server, you need to select an implementation of the _IoAcceptor_ interface. For client applications, you need to implement an implementation of the _IoConnector_ interface.

## IoAcceptor

Basically, this interface is named because of the _accept()_ method, responsible for the creation of new connections between a client and the server. The server accepts incoming connection requests.

At some point, we could have named this interface 'Server' (and this is the new name in the coming **MINA 3.0**).

As we may deal with more than one kind of transport (TCP/UDP/...), we have more than one implementation for this interface. It would be very unlikely that you need to implement a new one.

We have many of those implementing classes

* __NioSocketAcceptor__ : the non-blocking Socket transport _IoAcceptor_
* __NioDatagramAcceptor__ : the non-blocking UDP transport _IoAcceptor_
* __AprSocketAcceptor__ : the blocking Socket transport _IoAcceptor_, based on APR
* __VmPipeSocketAcceptor__ : the in-VM _IoAcceptor_

Just pick the one that fit your need.

Here is the class diagram for the _IoAcceptor_ interfaces and classes :

![](/assets/img/mina/IoServiceAcceptor.png)

## IoConnector

As we have to use an _IoAcceptor_ for servers, you have to implement the _IoConnector_ for clients. Again, we have many implementation classes :

* __NioSocketConnector__ : the non-blocking Socket transport _IoConnector_
* __NioDatagramConnector__ : the non-blocking UDP transport _IoConnector_
* __AprSocketConnector__ : the blocking Socket transport _IoConnector_, based on APR
* __ProxyConnector__ : a _IoConnector_ providing proxy support
* __SerialConnector__ : a _IoConnector_ for a serial transport
* __VmPipeConnector__ : the in-VM _IoConnector_

Just pick the one that fit your need.

Here is the class diagram for the _IoConnector_ interfaces and classes :

![](/assets/img/mina/IoServiceConnector.png)
