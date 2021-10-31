---
type: mina
title: 2.4 - Sample UDP Server
navPrev: ch2.3-sample-tcp-client.html
navPrevText: 2.3 - Sample TCP-Client
navUp: ch2-basics.html
navUpText: Chapter 2 - Basics
navNext: ch2.5-sample-udp-client.html
navNextText: 2.5 - Sample UDP Client
---

# 2.4 - Sample UDP Server

We will begin by looking at the code found in the [org.apache.mina.example.udp](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/example/udp/package-summary.html) package. To keep life simple, we shall concentrate on MINA related constructs only.

To construct the server, we shall have to do the following:

1. Create a Datagram Socket to listen for incoming Client requests (See [MemoryMonitor.java](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/example/udp/MemoryMonitor.html))
2. Create an IoHandler to handle the MINA framework generated events (See [MemoryMonitorHandler.java](https://nightlies.apache.org/mina/mina/2.0.22/xref/org/apache/mina/example/udp/MemoryMonitorHandler.html))

Here is the first snippet that addresses Point# 1:

```java
NioDatagramAcceptor acceptor = new NioDatagramAcceptor();
acceptor.setHandler(new MemoryMonitorHandler(this));
```

Here, we create a NioDatagramAcceptor to listen for incoming Client requests, and set the IoHandler.The variable 'PORT' is just an int. The next step is to add a logging filter to the filter chain that this DatagramAcceptor will use. LoggingFilter is a very nice way to see MINA in Action. It generate log statements at various stages, providing an insight into how MINA works.

```java
DefaultIoFilterChainBuilder chain = acceptor.getFilterChain();
chain.addLast("logger", new LoggingFilter());
```

Next we get into some more specific code for the UDP traffic. We will set the acceptor to reuse the address

```java
DatagramSessionConfig dcfg = acceptor.getSessionConfig();
dcfg.setReuseAddress(true);acceptor.bind(new InetSocketAddress(PORT));
```

Of course the last thing that is required here is to call bind().

## IoHandler implementation

There are three major events of interest for our Server Implementation

* Session Created
* Message Received
* Session Closed

Lets look at each of them in detail

### Session Created Event

```java
@Override
public void sessionCreated(IoSession session) throws Exception {
    SocketAddress remoteAddress = session.getRemoteAddress();
    server.addClient(remoteAddress);
} 
```

In the session creation event, we just call addClient() function, which internally adds a Tab to the UI

### Message Received Event

```java
@Override
public void messageReceived(IoSession session, Object message) throws Exception {
    if (message instanceof IoBuffer) {
        IoBuffer buffer = (IoBuffer) message;
        SocketAddress remoteAddress = session.getRemoteAddress();
        server.recvUpdate(remoteAddress, buffer.getLong());
    }
}
```

In the message received event, we just dump the data received in the message. Applications that need to send responses, can process message and write the responses onto session in this function.

### Session Closed Event

```java
@Override
public void sessionClosed(IoSession session) throws Exception {
    System.out.println("Session closed...");
    SocketAddress remoteAddress = session.getRemoteAddress();
    server.removeClient(remoteAddress);
}
```

In the Session Closed, event we just remove the Client tab from the UI
