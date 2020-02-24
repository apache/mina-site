---
type: mina
title: 3.1 - IO Service Introduction
navPrev: ch3-service.html
navPrevText: Chapter 3 - Service
navUp: ch3-service.html
navUpText: Chapter 3 - Service
navNext: ch3.2-io-service-details.html
navNextText: 3.2 - IoService Details
---

# 3.1 - IoService Introduction

[IoService](http://mina.apache.org/mina-project/xref/org/apache/mina/core/service/IoService.html) provides basic **I/O** Service and manages **I/O** Sessions within **MINA**. Its one of the most crucial part of **MINA** Architecture. The implementing classes of _IoService_ and child interface, are where most of the low level **I/O** operations are handled.

# IoService Mind Map

Let's try to see what are the responsibilities of the _IoService_ and it implementing class [AbstractIoService](http://mina.apache.org/mina-project/xref/org/apache/mina/core/service/AbstractIoService.html). Let's take a slightly different approach of first using a [Mind Map](http://en.wikipedia.org/wiki/Mind_map) and then jump into the inner working. The Mind Map was created using [XMind](http://www.xmind.net/).

![](/assets/img/mina/IoService_mindmap.png)

## Responsibilities

As seen in the previous graphic, The _IoService_ has many responsibilities :

* sessions management : Creates and deletes sessions, detect idleness.
* filter chain management : Handles the filter chain, allowing the user to change the chain on the fly
* handler invocation : Calls the handler when some new message is received, etc 
* statistics management : Updates the number of messages sent, bytes sent, and many others
* listeners management : Manages the Listeners a suer can set up
* communication management : Handles the transmission of data, in both side

All those aspects will be described in the following chapters.

## Interface Details

_IoService_ is the base interface for all the _IoConnector_'s and _IoAcceptor_'s that provides **I/O** services and manages **I/O** sessions. The interface has all the functions need to perform **I/O** related operations.

Lets take a deep dive into the various methods in the interface

* getTransportMetadata()
* addListener()
* removeListener()
* isDisposing()
* isDisposed()
* dispose()
* getHandler()
* setHandler()
* getManagedSessions()
* getManagedSessionCount()
* getSessionConfig()
* getFilterChainBuilder()
* setFilterChainBuilder()
* getFilterChain()
* isActive()
* getActivationTime()
* broadcast()
* setSessionDataStructureFactory()
* getScheduledWriteBytes()
* getScheduledWriteMessages()
* getStatistics()

### getTransportMetadata()

This method returns the Transport meta-data the _IoAcceptor_ or _IoConnector_ is running. The typical details include provider name (nio, apr, rxtx), connection type (connectionless/connection oriented) etc.

### addListener

Allows to add a _IoServiceListener_ to listen to specific events related to _IoService_.

### removeListener

Removes specified _IoServiceListener_ attached to this _IoService_.

### isDisposing

This method tells if the service is currently being disposed. As it can take a while, it's useful to know the current status of the service.

### isDisposed

This method tells if the service has been disposed. A service will be considered as disposed only when all the resources it has allocated have been released.

### dispose

This method releases all the resources the service has allocated. As it may take a while, the user should check the service status using the _isDisposing()_ and _isDisposed()_ to know if the service is now disposed completely.

Always call _dispose()_ when you shutdown a service !

### getHandler

Returns the _IoHandler_ associated with the service.

### setHandler

Sets the _IoHandler_ that will be responsible for handling all the events for the service. The handler contains your application logic !

### getManagedSessions

Returns the map of all sessions which are currently managed by this service. A managed session is a session which is added to the service listener. It will be used to process the idle sessions, and other session aspects, depending on the kind of listeners a user adds to a service.

### getManagedSessionCount

Returns the number of all sessions which are currently managed by this service.

### getSessionConfig

Returns the session configuration.

### getFilterChainBuilder

Returns the _Filter_ chain builder. This is useful if one wants to add some new filter that will be injected when the sessions will be created.

### setFilterChainBuilder

Defines the _Filter_ chain builder to use with the service.

### getFilterChain

Returns the current default _Filter_ chain for the service.

### isActive

Tells if the service is active or not.

### getActivationTime

Returns the time when this service was activated. It returns the last time when this service was activated if the service is not anymore active.

### broadcast

Writes the given message to all the managed sessions.

### setSessionDataStructureFactory

Sets the _IoSessionDataStructureFactory_ that provides related data structures for a new session created by this service.

### getScheduledWriteBytes

Returns the number of bytes scheduled to be written (ie, the bytes stored in memory waiting for the socket to be ready for write).

### getScheduledWriteMessages

Returns the number of messages scheduled to be written (ie, the messages stored in memory waiting for the socket to be ready for write).

### getStatistics

Returns the _IoServiceStatistics_ object for this service.
