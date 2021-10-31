---
type: mina
title: 2.3 - Sample TCP Client 
navPrev: ch2.2-sample-tcp-server.html
navPrevText: 2.2 - Sample TCP Server
navUp: ch2-basics.html
navUpText: Chapter 2 - Basics
navNext: ch2.4-sample-udp-server.html
navNextText: 2.4 - Sample UDP Server
---

# 2.3 - Sample TCP Client

We have seen the Client Architecture. Lets explore a sample Client implementation.

We shall use [Sumup Client](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/example/sumup/Client.html) as a reference implementation.

We will remove boiler plate code and concentrate on the important constructs. Below the code for the Client :

```java
public static void main(String[] args) throws Throwable {
    NioSocketConnector connector = new NioSocketConnector();
    connector.setConnectTimeoutMillis(CONNECT_TIMEOUT);

    if (USE_CUSTOM_CODEC) {
       connector.getFilterChain().addLast("codec",
        new ProtocolCodecFilter(new SumUpProtocolCodecFactory(false)));
    } else {
        connector.getFilterChain().addLast("codec",
            new ProtocolCodecFilter(new ObjectSerializationCodecFactory()));
    }
    
    connector.getFilterChain().addLast("logger", new LoggingFilter());
    connector.setHandler(new ClientSessionHandler(values));
    IoSession session;
    
    for (;;) {
        try {
            ConnectFuture future = connector.connect(new InetSocketAddress(HOSTNAME, PORT));
            future.awaitUninterruptibly();
            session = future.getSession();
            break;
        } catch (RuntimeIoException e) {
            System.err.println("Failed to connect.");
            e.printStackTrace();
            Thread.sleep(5000);
        }
    }
        
    // wait until the summation is done
    session.getCloseFuture().awaitUninterruptibly();
    connector.dispose();
}
```

To construct a Client, we need to do following

* Create a Connector
* Create a Filter Chain
* Create a IOHandler and add to Connector
* Bind to Server

Lets examine each one in detail

## Create a Connector

```java
NioSocketConnector connector = new NioSocketConnector();
```

Here we have created a NIO Socket connector

## Create a Filter Chain

```java
if (USE_CUSTOM_CODEC) {
    connector.getFilterChain().addLast("codec",
        new ProtocolCodecFilter(new SumUpProtocolCodecFactory(false)));
} else {
    connector.getFilterChain().addLast("codec",
        new ProtocolCodecFilter(new ObjectSerializationCodecFactory()));
}
```

We add Filters to the Filter Chain for the Connector. Here we have added a ProtocolCodec, to the filter Chain.

## Create IOHandler

```java
connector.setHandler(new ClientSessionHandler(values));
```

Here we create an instance of [ClientSessionHandler](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/example/sumup/ClientSessionHandler.html) and set it as a handler for the Connector.

## Bind to Server

```java
IoSession session;

for (;;) {
    try {
        ConnectFuture future = connector.connect(new InetSocketAddress(HOSTNAME, PORT));
        future.awaitUninterruptibly();
        session = future.getSession();
        break;
    } catch (RuntimeIoException e) {
        System.err.println("Failed to connect.");
        e.printStackTrace();
        Thread.sleep(5000);
    }
}
```

Here is the most important stuff. We connect to remote Server. Since, connect is an async task, we use the [ConnectFuture](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/core/future/ConnectFuture.html) class to know the when the connection is complete.
Once the connection is complete, we get the associated [IoSession](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/core/session/IoSession.html). To send any message to the Server, we shall have to write to the session. All responses/messages from server shall traverse the Filter chain and finally be handled in IoHandler.
