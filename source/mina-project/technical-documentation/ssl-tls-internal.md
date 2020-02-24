---
type: mina
title: SSL/TLS internals
---

# SSL/TLS internals

This is a technical description of how SSL/TLS are handled in MINA. You don't need to read this to have it working, better have a look at the [SslFilter user guide](../userguide/ch11-ss-filter/ch11-ssl-filter.html) page. However, if you want to get a deeper understanding on how it's built, this is the place !

## Components

The **SslFilter** is the filter that command everything related to **SSL/TLS**. It works hands in hands with the **SSLHandler** class, which handles the logic.

With **NIO**, Java provides a special class that handles the **SSL/TLS** protocol, the **SSLEngine** class. It's quite a complex piece of code, and it requires some time to tame it... We will have a look into it during this tutorial.

## Creation

In order to inject the filter in the chain, it must first be created. This filter takes one or two parameters:
* **SSLContext**: the Java class that contains all the information related to the **SSL/TLS** establishment
* __autoStart__: tells if the handshake should be started immediately. This is an optional parameter, defaulting to **TRUE**. In some cases, like when using __startTLS__, it's critical to not start the handshake immediately, as it will be established on demand.

## Initialization

When injecting the **SslFilter** into your chain, either before starting your service, or while running it, it has to be initialized in some way. Actually, this is a two phases process :
- pre-initialization, during the filter injection
- post-initialization, by starting the Handshake dialog

Most of the time, both phases will be merged, as one can tell the first phase to immediately starts the second.

In any case, it's handled by the __onPreAdd__ and __onPostAdd_ events, which means it's automatically processed when you push the **SslFilter** into the chain.

### onPreAdd

The **SslHandler** class is created and initialized, and the instance is stored into the session attributes. That means each session has its own instance of **SslHandler**. This initialization will create a **SSLEngine** instance based on the provided **SSLContext** instance. The initialization will differ based on the 'side' you are on: server or client. Basically, the server side will wait for the client to initiate the handshake, while the client side will initiate it.

It's also responsible to set the enabled ciphers and protocols, if one wants to use a restricted set, or an extended set (newer versions of Java have disabled old protocols and insecure ciphers).

Last, not least, it sets a list of status flags :
* writingEncryptedData: false. This flag is used during the handshake
* handshakeStatus: the HandShake status, which is originally set to __NOT_HANDSHAKING__
* firstSSLNegotiation: true. This flag is used to tell the **sslHandler** to send or not an event to the application (MINA 2.1 only)
* handshakeComplete: false. It will be set to true when teh handshake has been completed.

Side note: those flags are probably spurious. Some cleanup might be done to get rid of the useless ones.


## onPostAdd

This event will initiate an immediate handshake if required. Depending on the perr side, the action will be different.

- if we are on the server peer
