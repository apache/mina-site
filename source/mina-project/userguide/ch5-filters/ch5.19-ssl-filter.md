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
* Then once the _Handshake_ is completed, all the data will be encrypted before being sent.

We just have to add the filter in the chain like this:

```
   ...
   SslFilter sslFilter = new SslFilter(sslContext);
   DefaultIoFilterChainBuilder chain = acceptor.getFilterChain();
   chain.addFirst("sslFilter", sslFilter);
   ...

```

The _chain_ is the instance of **IoFilterChainBuilder** class that is associated with either the _Connector_ or the _Acceptor_ instances (wether we are using a client or a server).

<div class="note" markdown="1">
Usually the **SSLFilyter** is always set at the first position in the chain. The rationnal is that it will receive and send encrypted data, so there is little use of having a functionnal filter between the head of the chain and the **SslFilter**. However, if such a filter is to be used, make sure it does not interfere with the data being exchanged with the remote peer.
</div>

The missing part here is the _sslContext_ which has to be defined. It's an instande of the **SSLContext** class, where you define a **TrustManager**, a **KeyManager** and a **Securerandom**.

<div class="note" markdown="1">
	This part is strandard Java security. You'll find plenty of pages on internet explaining you to set up a proper _SSLContext_ instance.
</div>

### Handshake

The **Handshake** is automatically initiated by the server when the connection is created. The **SslFilter** has a _onPostAdd_ method which create a **SSLEngine** instance based on the provided **SSLContext**.

It sets the **SSLEngine** characteristics:
* Whether the client authentication is requested or required (_needClientAuth_ and _wantClientAuth_ flags)
* Sets the enabled cipher suites
* Sets the enabled protocols

Last, not least, the **CLIENT_HELLO** **TLS** request is sent by the client side, the server is waiting for it. There starts a serie of **TLS** messages exchanged between the cleint and the server, at teh end of which the session is secured, and data can be exchanged encrypted.

What is important to note here is that during the **Handshake** exchanges, no application data can be sent, and the **SslFilter** is handling the whole process, before returning the hand to the application.

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

The way it works is that at some point of a clear text established connection, the client sends a **STARTLS** command, which forces the **TLS** handshake to start to establish a secured connection. When the secured connection is established, the client and the server exchanges will be encrypted.

Now, that is a bit tricky to implement, because both the client *and* the server must block the exchange of messages during the establishement of the **TLS** session. As the client is the initiator of the command, it's easy, but on the server side, we must pass a response to the original command **in clear text** informing the client that the command has been received and processed.

```
(C) The client sends a **StartTLS** command
(S) The server receives the command, initialize the **TLS** layer, and send back a response to the client, bypassing the **TLS** layer.
(C) The client received the server response to the command, and setup the **TLS** layer, and initiates the **TLS** handshake
(S/C) The Handshake is processed
(S/C) The session is secured on both side
(S/C) at this point, every message exchanged are encrypted.
```




