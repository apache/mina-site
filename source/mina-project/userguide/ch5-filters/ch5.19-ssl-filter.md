---
type: mina
title: 5.19 - SSL/TLS Filter
navPrev: ch5.18-stream-write-filter.html
navPrevText: 5.18 - Stream Write Filter
navUp: ch5-filters.html
navUpText: Chapter 5 - Filters
navNext: ch5.20-write-request-filter.html
navNextText: 5.20 - Write Request Filter
---

# 5.19 - SSL/TLS Filter

This is a critical part of any serious network application: securing the communication between the client and the server.

In **MINA**, we do that with the **SslFilter**. The idea is to add this _Filter_ in the chain and it will deal with the _Handshake_ negociation, and the following encrypting and uncrypting of the data.

## How it works

The thing to remember is that the **TLS** protocol works in two steps:
* First there is a negociation part (the _Handshake_)
* Then once the _Handshake_ is completed, all the data will be encrypted before being sent, and decryptd when received.

We just have to add the filter in the chain like this:

```
   ...
   SslFilter sslFilter = new SslFilter(sslContext);
   DefaultIoFilterChainBuilder chain = acceptor.getFilterChain();
   chain.addFirst("sslFilter", sslFilter);
   ...

```

The _chain_ is the instance of **IoFilterChainBuilder** class that is associated with either the _Connector_ or the _Acceptor_ instances (wether we are using a client or a server). It will be used when a connection is set to define the filter chain this connected session will use.

<div class="note" markdown="1">
Usually the **SSLFilter** is always set at the first position in the chain. The rationnal is that it will receive and send encrypted data, so there is little use of having a functionnal filter between the head of the chain and the **SslFilter**. However, if such a filter is to be used, make sure it does not interfere with the data being exchanged with the remote peer.
</div>

The missing part here is the _sslContext_ which has to be defined. It's an instance of the **SSLContext** class, where you define a **TrustManager**, a **KeyManager** and a **Securerandom**.

<div class="note" markdown="1">
	This part is strandard Java security. You'll find plenty of pages on internet explaining you to set up a proper _SSLContext_ instance.
</div>

The filter can be added either _before_ the connection has been established, or _after_ the connection has been established.
In the first case, it's easy, the filter initialisation will be done when the connection is created. The second is a bit more complex, as we will have to deal with ongoing messages.

### Initialization

When a connection is created, the filter chain is created, and the **SslFilter** is added to this chain, which intializes it. The filter's _onPreAdd_ method is called, which will only check if the filter has already been added (we can't have the **SslFilter** twice in the chain).

The filter's _onPostAdd_ method is then called, and if the _autostart_ flag is set to _true_ and the session is connected (which should be the case...), then the _onConnected_ method is called.

<div class="note" markdown="1">
   The _autostart_ flag can be set when creating the **SslFilter**. It indicates that the filter will be initialized immediatly on a new connection. Otherwise the filter will be initialized later on when the session will have been opened.
</div>

The **SslHandler** will then be created, which will contain a newly created **SslEngine**. This is the place where the **TLS** parameters will be set:
* The authentication **WANT** or **NEED** flags
* The cipher suite
* The enabled protocols
* The endpoint identification algorithms
* and finally the flag indicating if it's for a server or a client

All those flags are optionnal but the last one.

The newly created **SslHandler** instance will be added into the session's attributes, under the _org.apache.mina.filter.ssl.SslHandler.handler@<ID>_ key (The **ID** part is unique).

Last, not least, the **SslHandler** instance is opened. If we are on the client side, the **TLS** _Handshake_ will be started, otherwise a flag will be set to indicate we are expecting a _Handshake_ on the server side.

We are all set and ready for the _Handshake_ to be processed!

### Handshake

The _Handshake_ must be done as soon as the **TLS** layer is activated. It's initiated by the client, which must send a _CLIENT_HELLO_ message (see the [Client Hello](https://tls13.xargs.org/#client-hello) description), but the server must be ready to accept this message.

We will consider two use cases: the **Client** side and the **Server** side (as **Mina** can handle both sides, but could work with a peer written using a different implementation)

#### Initial Handshake message

The first _Handshake_ message to be processed is the **CLIENT HELLO** **TLS** message. 

##### Server side

The _Handshake_ is initiated by a **CLIENT_HELLO** **TLS** request which is sent by the client, the server is waiting for it. There starts a serie of **TLS** messages exchanged between the cleint and the server, at the end of which the session is secured, and data can be exchanged encrypted.

What is important to note here is that during the _Handshake_ exchanges, no application data can be sent, and the **SslFilter** is handling the whole process, before returning the hand to the application. That means messages emitted by the application will be stacked until the session is secured.

##### Client side

The client is the initiator of the _Handshake_ exchange. The difference with  the server is that the client **SSLhandler** will generate the inital _Handshake_ message (**CLIENT HELLO**) and send it to the server

#### Follow up Handshake messages

Once the _Handshake_ has been initiated, the dance keeps going until the _Handshake_ is either done or fails:
* The client sends _Handshake_ requests
* The server sends _Handshake_ responses 

This dance can use many steps.

It ends with both side send a _finished_ message, and has verified that it's valid.

### Session secured

The application is informed that the session is secured:

* In **MINA** 2.0.X, the **SslFilterMessage** message is sent and can be processed in the **IoHandler.messageReived** handler.
* In **MINA** 2.1.X and 2.2.X, the **IoHandler** interface exposes an _event_ handler that is used by the **SslFilter** to inform the application that the session is secured, by emmiting a **SslEvent.SECURED** event.

It's clear that the way **MINA** 2.1.X and 2.2.X signal that the session is secured is way simpler.

### StartTLS use case

Some protocols, like **LDAP**, **FTP**, **XMPP**, **NNTP**, **SMTP**, can be used without encryption, but allow some encryption to be set by using a specific command. When this command is issued, the **TLS** layer is added to an already connected session, without reestablishing a new session.

That is what the **startTLS** command is used for that purpose. Here are a list of existing protocols that use this mechanism:

* [**IMAP, POP3 and ACAP**](https://datatracker.ietf.org/doc/html/rfc2595)
* [**SMTP**](https://datatracker.ietf.org/doc/html/rfc3207)
* [**XMPP**](https://datatracker.ietf.org/doc/html/rfc6120)
* [**NNTP**](https://datatracker.ietf.org/doc/html/rfc4642)
* [**LDAP**](https://datatracker.ietf.org/doc/html/rfc4513)

The way it works is that at some point of a clear text established connection, the client sends a **STARTLS** command, which forces the **TLS** _Handshake_ to start to establish a secured connection. When the secured connection is established, the client and the server exchanges will be encrypted.

Now, that is a bit tricky to implement, because both the client *and* the server must block the exchange of messages during the establishement of the **TLS** session. As the client is the initiator of the command, it's easy, but on the server side, we must pass a response to the original command **in clear text** informing the client that the command has been received and processed.

```
(C) The client sends a **StartTLS** command
(S) The server receives the command, initialize the **TLS** layer, and send back a response to the client, bypassing the **TLS** layer.
(C) The client received the server response to the command, and setup the **TLS** layer, and initiates the **TLS** _Handshake_
(S/C) The _Handshake_ is processed
(S/C) The session is secured on both side
(S/C) at this point, every message exchanged are encrypted.
```




