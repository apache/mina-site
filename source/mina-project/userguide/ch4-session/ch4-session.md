---
type: mina
title: Chapter 4 - Session
navPrev: ../ch3-service/ch3-service.html
navPrevText: Chapter 3 - Service
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch5-filters/ch5-filters.html
navNextText: Chapter 5 - Filters
---

# Chapter 4 - Session

* [4.1 - Session Configuration](ch4.1-session-configuration.html)
* [4.2 - Session Statistics](ch4.2-session-statistics.html)

## Introduction

The Session is at the heart of MINA : every time a client connects to the server, a new session is created on the server, and will be kept in memory until the client is disconnected. If you are using MINA on the client side, every time you connect to a server, a session will be created on the client too.

A session is used to store persistent information about the connection, plus any kind of information the client or the server might need to use during the request processing, and eventually during the whole session life.

This is also your access point for any operation you need to do on a session : sending messages, closing the session, etc...

<div class="note" markdown="1">
It is critical to understand that due to the asynchrnous very nature of NIO, reading from a session does not make a lot of sense. Actually, your application get signalled whe some incoming message has arrived, and this is the IoHandler which is responsible for handling such event.

In other words, don't call session.read(). Never.
</div>

## Session state

A session has a state, which will evolve during time.

* Connected : the session has been created and is available
* Idle : the session hasn't processed any request for at least a period of time (this period is configurable)
    * Idle for read : no read has actually been made for a period of time
    * Idle for write : no write has actually been made for a period of time
    * Idle for both : no read nor write for a period of time
* Closing : the session is being closed (the remaining messages are being flushed, cleaning up is not terminated)
* Closed : The session is now closed, nothing else can be done to revive it. This is actually not a real state : when teh session is closed, it's removed.

The following state diagram exposes all the possible states and transitions :

![](/assets/img/mina/session-state.png)

We have a set of methods to get some information about the session status.

Session status :

* isActive() : tells if the session is valid (it might mean different things depending on the implementation)
* isClosing() : tells if the session is already being closed
* isConnected() : tells if the session is active (ie, not in the closing mode)

## Opening a session

Actually, there is nothing you have to do : it's automatic ! Every time a remote peer connect to a server, the server will create a new connection. On the client side, every time you connect to a server, a session will be created.

This session is passed as an argument to your handler, so that you can do something with it in your application. On the client side, when you do connect to a server, you can get back the created session this way :

```java
...
ConnectFuture connectionFuture = connector.connect(address);
connectionFuture.awaitUninterruptibly();

if (!connectionFuture.isConnected()) {
    return false;
}

session = connectionFuture.getSession();
...
```

You can also do it in a shortest way :

```java
...
session = connector.connect(address).getSession();
...
```

## Initialization

When a new session is created, it has to be initialized. This is done using the default IoService configuration, bt you can update this configuration later on. Actually, when the session is created, we internally create a copy of the default IoService configuration that is stored within the session, and this is this configuration instance that will be used (and that can be modified).

This initialization will also starts the statistics counters, create the Attributes container, associate a write queue to to the session (this is where the messages will be enqueued until they have been sent), and ultimately, would you have provided a specific task to do during this phase, it will call it.

## Closing a session

A session can be closed in 4 ways, two of which are explicit :
* calling the _closeNow()_ method (explicit)
* calling the _closeOnFlush()_ method (explicit)
* when the remote peer has nicely closed the connection
* if an exception occurs

(note there are two deprecated methods that should not anymore be used : _close(boolean)_ and _close()_)


### Explicit closure

The first two methods can be called anywhere in your application, the big difference is one (_closeNow()_) will simply close the session, discarding any message waiting to be transmitted to the peer, while the _closeOnFlush()_ will wait until any pending message has been transmitted to the peer. 

<div class="note" markdown="1">
    Be aware that if the remote peer is not anymore connected, the session that you are closing using a _closeOnFlush()_ call will never be destroyed, unless you also handle its idleness, or before the system TCP timeout has closed the socket - which might take hours -. Always manage idleness in your applications.
</div>

### Remote peer closing

When the remote peer closes the session properly, the session will be closed, and all the pending messages will be discarded. This is usually the way it works. 

However, sometime, the remote peer does not properly close the connection (this could happen when the cable is brutally unplugged). In this case, the session never get informed about the disconnection. The only way to know about it is to regularly check for the session state : if it's idle for more than a specific amount of time - it has to be configured -, then the application can decide to close the session. Otherwise, the session will be closed eventually when the TCP timeout will be reached (it can take hours...).

### Exception 

In some case, an exception will occur that will cause the session to be closed. Typically, when a session is being created, we may face an issue, and the session will be immediately closed. One other possibility is that we can't write some message, for instance because the channel has been closed : we then close the session.

All in all, every time we met an exception while processing a session, this session will be closed.

Of course, your application will be informed through the _ExceptionCaught_ event.

## Configuration

Many different parameters can be set for a specific session :

* receive buffer size
* sending buffer size
* Idle time
* Write timeOut
* ...

plus other configuration, depending on the transport type used (see Chapter 6 - Transports).

All those configuration parameters are stored into the _IoSessionConfig_ object, which can be get from the session using the _session.getConfig()_ method.

For further information about the session configuration, see [Chapter 4.1 - Session Configuration](ch4.1-session-configuration.html)

## Managing user-defined attributes

It might be necessary to store some data which may be used later. This is done using the dedicated data structure associated which each session. This is a key-value association, which can store any type of data the developer might want to keep permanent along the session's life.

For instance, if you want to track the number of request a user has sent since the session has been created, it's easy to store it into this map: just create a key that will be associated with this value.

```java
...
int counterValue = session.getAttribute( "counter" );
session.setAttribute( "counter", counterValue + 1 );
...
```

We have a way to handle stored Attributes into the session : an Attribute is a key/value pair, which can be added, removed and read from the session's container.

This container is created automatically when the session is created, and will be disposed when the session is terminated.


### The session container

As we said, this container is a key/value container, which default to a Map, but it's also possible to define another data structure if one want to handle long lived data, or to avoid storing all those data in memory if they are large : we can implement an interface and a factory that will be used to create this container when the session is created.

This snippet of code shows how the container is created during the session initialization :

```java
  protected final void initSession(IoSession session,
          IoFuture future, IoSessionInitializer sessionInitializer) {
      ...
      try {
          ((AbstractIoSession) session).setAttributeMap(session.getService()
                  .getSessionDataStructureFactory().getAttributeMap(session));
      } catch (IoSessionInitializationException e) {
          throw e;
      } catch (Exception e) {
          throw new IoSessionInitializationException(
                  "Failed to initialize an attributeMap.", e);
      }
      ...
```

and here is the factory interface we can implement if we want to define another kind of container :

```java
public interface IoSessionDataStructureFactory {
    /**
    * Returns an {@link IoSessionAttributeMap} which is going to be associated
    * with the specified <tt>session</tt>.  Please note that the returned
    * implementation must be thread-safe.
    */
    IoSessionAttributeMap getAttributeMap(IoSession session) throws Exception;
}
```

### The session attributes access

There are many methods available to manipulate the session's attributes :

* boolean containsAttribute(Object key) : tells if a given attribute is present
* Object getAttribute(Object key) : gets the value for a given attribute
* Object getAttribute(Object key, Object defaultValue) : gets the value for a given attribute, or a default value if absent
* Set&lt;Object&gt; getAttributeKeys() : gets the set of all the stored attributes
* Object removeAttribute(Object key) : remove a given attribute
* boolean removeAttribute(Object key, Object value) : remove a given attribute/value pair
* boolean replaceAttribute(Object key, Object oldValue, Object newValue) : replace a give attribute/value pair
* Object setAttribute(Object key) : adds a new attribute with no value
* Object setAttribute(Object key, Object value) : adds a new attribute/value pair
* Object setAttributeIfAbsent(Object key) : adds a new attribute with no value, if it does not already exist
* Object setAttributeIfAbsent(Object key, Object value) : adds a new attribute/value pair, if it does not already exist

All those methods allows your application to store, remove, get or update the attributes stored into your session. Also note that some attributes are used internally by MINA : don't lightly modify those you didn't create !

## Filter chain

Each session is associated with a chain of filters, which will be processed when an incoming request or an outgoing message is received or emitted. Those filters are specific for each session individually, even if most of the cases, we will use the very same chain of filters for all the existing sessions.

However, it's possible to dynamically modify the chain for a single session, for instance by adding a Logger Filter in the chain for a specific session.

## Statistics

Each session also keep a track of records about what has been done for the session :

* number of bytes received/sent
* number of messages received/sent
* Idle status
* throughput

and many other useful information.

For further information about the session statistics, see [Chapter 4.2 - Session Statistics](ch4.2-session-statistics.html)


## Handler

Last, not least, a session is attached to a Handler, in charge of dispatching the messages to your application. This handler will also send back response by using the session, simply by calling the write() method :

```java
...
session.write( <your message> );
...
```
