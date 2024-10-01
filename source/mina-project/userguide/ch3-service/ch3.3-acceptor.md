---
type: mina
title: 3.3 - Acceptor
navPrev: ch3.2-io-service-details.html
navPrevText: 3.2 - IoService Details
navUp: ch3-service.html
navUpText: Chapter 3 - Service
navNext: ch3.4-connector.html
navNextText: 3.4 - Connector
---

# 3.3 - Acceptor

In order to build a server, you need to select an implementation of the _IoAcceptor_ interface.

## IoAcceptor

Basically, this interface is named because of the _accept()_ method, responsible for the creation of new connections between a client and the server. The server accepts incoming connections request.

At some point, we could have named this interface 'Server'.

As we may deal with more than one kind of transport (TCP/UDP/...), we have more than one implementation for this interface. It would be very unlikely that you need to implement a new one.

We have many of those implementing classes

* __NioSocketAcceptor__: the non-blocking Socket transport _IoAcceptor_
* __NioDatagramAcceptor__: the non-blocking UDP transport _IoAcceptor_
* __AprSocketAcceptor__: the blocking Socket transport _IoAcceptor_, based on APR
* __VmPipeSocketAcceptor__: the in-VM _IoAcceptor_

Just pick the one that fit your need.

Here is the class diagram for the _IoAcceptor_ interfaces and classes:

![](/assets/img/mina/IoServiceAcceptor.png)

## Creation

You first have to select the type of _IoAcceptor_ you want to instantiate. This is a choice you will made early in the process, as it all boils down to which network protocol you will use. Let's see with an example how it works:

```java
public TcpServer() throws IOException {
    // Create a TCP acceptor
    IoAcceptor acceptor = new NioSocketAcceptor();

    // Associate the acceptor to an IoHandler instance (your application)
    acceptor.setHandler(this);

    // Bind : this will start the server...
    acceptor.bind(new InetSocketAddress(PORT));

    System.out.println("Server started...");
}
```

That's it ! You have created a TCP server. If you want to start an UDP server, simply replace the first line of code:

```java
...
// Create an UDP acceptor
IoAcceptor acceptor = new NioDatagramAcceptor();
...
```

## Disposal

The service can be stopped by calling the _dispose()_ method. The service will be stopped only when all the pending sessions have been processed :

```java
// Stop the service, waiting for the pending sessions to be inactive
acceptor.dispose();
```

You can also wait for every thread being executed to be properly completed by passing a boolean parameter to this method:

```java
// Stop the service, waiting for the processing session to be properly completed
acceptor.dispose( true );
```

## Status

You can get the _IoService_ status by calling one of the following methods:

* _isActive()_: true if the service can accept incoming requests
* _isDisposing()_: true if the _dispose()_ method has been called. It does not tell if the service is actually stopped (some sessions might be processed)
* _isDisposed()_: true if the _dispose(boolean)_ method has been called, and the executing threads have been completed.

## Managing the IoHandler

You can add or get the associated _IoHandler_ when the service has been instantiated. You just have to call the _setHandler(IoHandler)_ or _getHandler()_ methods.

## Managing the Filters chain

if you want to manage the filters chain, you will have to call the _getFilterChain()_ method. Here is an example:

```java
// Add a logger filter
DefaultIoFilterChainBuilder chain = acceptor.getFilterChain();
chain.addLast("logger", new LoggingFilter());
```

You can also create the chain before and set it into the service:

```java
// Add a logger filter
DefaultIoFilterChainBuilder chain = new DefaultIoFilterChainBuilder();
chain.addLast("logger", new LoggingFilter());

// And inject the created chain builder in the service
acceptor.setFilterChainBuilder(chain);
```
