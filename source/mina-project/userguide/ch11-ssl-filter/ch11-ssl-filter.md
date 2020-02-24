---
type: mina
title: Chapter 11 - SSL Filter
navPrev: ../ch10-executor-filter/ch10-executor-filter.html
navPrevText: Chapter 10 - Executor Filter
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch12-logging-filter/ch12-logging-filter.html
navNextText: Chapter 12 - Logging Filter
---

# Chapter 11 - SSL Filter

The **SslFilter** is the filter in charge of managing the encryption and decryption of data sent through a secured connection. Whenever you need to establish a secured connection, or to transform an existing connection to make it secure, you have to add the **SslFilter** in your filter chain.

As any session can modify it's message filter chain at will, it allows for protocols like **startTLS** to be used on an opened connection.

<div class="note" markdown="1">
Please note that although the name include <strong>SSL</strong>, <strong>SslFilter</strong> supports <strong>TLS</strong>.

Actually, <strong>TLS</strong> is supposed to have replaced <strong>SSL</strong>, but for historical reason, <strong>SSL</strong> remains widely used.
</div>

## Basic usage

If you want your application to support **SSL/TLS**, just add the **SslFilter** in your chain :

    ...
    DefaultIoFilterChainBuilder chain = acceptor.getFilterChain();
    SslFilter sslFilter = new SslFilter(sslContext);
    chain.addFirst("sslFilter", sslFilter);
    ...

You obviously need a **SslContext** instance too :

    SSLContext sslContext;

        try
        {
            // Initialize the SSLContext to work with our key managers.
            sslContext = SSLContext.getInstance( "TLS" );
            sslContext.init( ... ); // Provide the needed KeyManager[], TrustManager[] and SecureRandom instances
        }
        catch ( Exception e )
        {
            // Handle your exception
        }

This is up to you to provide the **KeyManager**, **TrustManager** and **SecureRandom** instances.

Be sure to inject the **SslFilter** on the first position in your chain !

We will see later a detailed example on how to create a **SSLContext**.

## A bit of theory

If you want to get a deeper understanding on how it all works, please read the following paragraphs...

### SSL Basics

We are not going to explain how **SSL** works, there are very [good books](http://www.amazon.com/SSL-TLS-Designing-Building-Systems/dp/0201615983) out there. We will just give a quick introduction on how it works and how it is implemented in MINA.

First of all, you have to understand that **SSL/TLS** is a protocol defined in **RFCs** : [TLS 1.0](https://www.rfc-editor.org/rfc/rfc2246.txt), [TLS 1.1](https://www.rfc-editor.org/rfc/rfc4346.txt), [TLS 1.2](https://www.rfc-editor.org/rfc/rfc5246.txt) and [RLS 1.3](https://tools.ietf.org/html/rfc8446).

It was initially developed by **Netscape**, and named **SSL** (from 1.0 to 3.0), before becoming **TLS**. Nowadays, ***SSL 2.0** and **SSL 3.0** have been deprecated and should not be used.


### The SSL/TLS protocol

As it's a protocol, it requires some dialog between a client and a server. This is all what **SSL/TLS** is about : describing this dialog. 

It's enough to know that any secured exchange is precluded by a negotiation phase, called the **Handshake**, which role is to come to an agreement between the client and the server on what will be the encryption method to use. A basic **SSL/TLS** session will be something that looks like :

<div align="center">
  <img src="../images/TLS-protocol.png" alt="TLS Protocol"/>
</div>

As you can see in this picture, it's a 2 phases protocol : first the handshake, then when completed the client and the server will be able to exchange data that will be encrypted.

There are also other phases, like the **SSL/TLS** closure, or a renegotiation phase.

#### The Handshake

Basically, it's all about negotiating many elements that are to be used to encrypt/decrypt the data. The details are not so interesting in the context of this document, enough said that many messages are going to be exchanged between the client and the server, and no data can be sent during this phase. 

Actually, there are two conditions for the handshake to start :
* The server must be waiting for some handshake message to arrive
* The client must send a **ClientHello** message

We do use the Java **SSLEngine** class to manage the whole **SSL/TLS** protocol. What **MINA** should take care of is the current status of the session is such that it will be able to get and deal with the client **HelloClient** message. When you inject the **SslFilter** in your filter chain, a few things happen :

* A **SslHandler** instance is created (we create one instance per session). This **SslHandler** instance is in charge of the whole processing (handshake and encryption/decryption of forthcoming messages)
* This **SslHandler** creates a **SSLEngine** using the **SslContext** instance that has been attached to the **SslFilter**
* The **SslEngine** instance is configured and initialized
* The **SslHandler** instance is stored into the session
* Unless required specifically, we initiate the Handshake (which has different meanings on client side and on server side : the client will then send the **ClientHello** message, while the server switch to a mode where it waits for some data to be unwrapped). Note that the handshake initialization can be done later on, if needed

We are all set. The next few steps are pure **SSL/TLS** protocol exchange. If the *session.write()* method is called, the message will be enqueued waiting for the handshake to be completed. Any pending message at the time the **SslFilter** is added into the chain will cause the **SSL/TLS** handshake to fail, so be sure that you have a clean place when you want to inject it. We also won't receive any message that is not a **SSL/TLS** protocol message.

This last point is important if you are to implement **StartTLS** : as it allows your application to switch from a plain text exchange to an encrypted exchange at any time, you have to be sure that there are not pending messages on both side. Obviously, on the client side - the side that initiates **StartTLS** - every pending messages will have been sent before the **StartTLS** message can be sent, but it has to block any other message that are not part of the following handshake, until the handshake is completed. On the server side, once the **StartTLS** message has been received, no message should be written to the remote peer.

As a matter of fact, injecting the **SslFilter** in the chain should block any exchange that are not part of the handshake protocol until the handshake is completed. If you submit a message to be sent and encrypted before the handshake has been completed, the message will not be rejected but queued and will be processed when the handshake has been completed.

Afterward, every message sent will go through the **SslHandler** instance to be encrypted, and every message received will have to be fully decrypted by the **SslHandler** before being available to the next filters.

#### Sending data

Ok, the Handshake has been completed. Your **SslFilter** is ready to process incoming and outgoing messages. Let's focus on those your session are going to write.

One important thing is that you may write more than one message on the same session (if you have an **Executor** in your chain). The problem is that the **SSLEngine** is not capable of dealing with more than one message at a time. We need to serialize the messages being written out. It's even worse : you can't process an incoming message **and** and outgoing message at the same time. 

All in all, the **SSL/TLS** processing is like a black box that accept only one input and can't process anything until it has completed its task. the following schema represent the way it works for outgoing messages.

<div align="center">
  <img src="../images/TLS-outMessage.png" alt="Outgoing messages"/>
</div>

It's not that different for incoming messages, except that we won't have an **Executor** between the **IoProcessor** and the **SslFilter**. That makes things simpler, except that one critical thing happens : when we process an incoming message, we can't anymore process outgoing messages. Note that it also works on the other way around : when an outgoing message is being processed, we can't process an incoming message :

<div align="center">
  <img src="../images/TLS-inMessage.png" alt="Incoming message"/>
</div>


<div class="note" markdown="1">
What is important here is that the <strong>SslHander</strong> can't process more than one message at a time.
</div>

## SSL/TLS in MINA 2

Now, we will dive a bit deeper into **MINA** code. We will cover all the filter operations:

* Management
    * init()
    * destroy()
    * onPreAdd(IoFilterChain, String, NextFilter)
    * onPostAdd(IoFilterChain, String, NextFilter)
    * onPreRemove(IoFilterChain, String, NextFilter)
    * onPostRemove(IoFilterChain, String, NextFilter)
* Session events
    * sessionCreated(NextFilter, IoSession)
    * sessionOpened(NextFilter, IoSession)
    * sessionClosed(NextFilter, IoSession)
    * sessionIdle(NextFilter, IoSession, IdleStatus)
    * exceptionCaught(NextFilter, IoSession, Throwable)
    * filterClose(NextFilter, IoSession)
    * inputClosed(NextFilter, IoSession)
* Messages events
    * messageReceived(NextFilter, IoSession, Object)
    * filterWrite(NextFilter, IoSession, WriteRequest)
    * messageSent(NextFilter, IoSession, WriteRequest)

### Management

Here are the Filter's management methods :

#### onPreAdd

This is where we create the **SslHandler** instance, and initialize it. We also define the supported ciphers.

The **SslHandler** instance will itself create an instance of **SSLEngine**, and configure it with all the parameters set in the **SslFilter**:

* If this is client or a server side 
* When it's server side, the flag that says we want or require the client authentication
* The list of enabled ciphers
* The list of enabled protocols

When it's done, the reference to this instance is stored into the Session's attributes.

#### onPostAdd

This is where we start the handshake if it's not explicitly postponed. This is all what this method does. All the logic is implemented by the **SslHandler**

#### onPreRemove

Here, we stop the SSL session and we cleanup the session (removing the filter from the session's chain and the **SslHandler** instance from the session's attributes). The **Sslhandler** instance si also destroyed after having flushed any event that is not yet processed.

### Session events

Here are the events that are propagated across the filter's chain and processed by the **SslFilter** :

#### sessionClosed

We just destroy the **SslHandler** instance. 

#### exceptionCaught

We have one special task to proceed when the exception is due to a closed session : we have to gather all the messages that were pending to add them to the exception that will be propagated.

#### filterClose

Here, if there is a SSL session started, we need to close it. In any case, we propagate the event into the chain to the next filter.


### Messages events

Last, not least, the three events relative to messages :

#### messageReceived event

This event is received when we read some data from the socket. We have to take care of a few corner cases :
* The handshake has been completed
* The handshake has been started but is not completed
* No handshake has started, and the **SslHandler** is not yet initialized

Those three use cases are listed by order of frequency. Let's see what is going to happen for each of those use cases.

##### The handshake has been completed

Good ! That means every incoming message is encapsulated in a **SSL/TLS** envelop, and should be decrypted. Now, we are talking about messages, but we actually receive bytes, that may need to be aggregated to form a full message (at least in **TCP**). If a message is fragmented, we will receive many buffers, and we will be able to decrypt it fully when we will receive the last piece. Remember that we are blocked during all the process, which can block the **SslHandler** instance for this session for quite some time...

In any case, every block of data is processed by the **SslHandler**, which delegates to the **SslEngine** the decryption of the bytes it received.

Here is the basic algorithm we have implemented in *messageReceived()* :

    get the session's sslHandler

    syncrhonized on sshHandler {
        if handshake completed
            then
                get the sslHandler decrypting the data
                if the application buffer is completed, push it into the message to forward to the IoHandler
            else
                enqueue the incoming data
    }

    flush the messages if any

The important part here is that the **SslHandler** will cumulate the data until it has a complete message to push into the chain. This may take a while, and many socket reads. The reason is that the **SSLEngine** cannot process a message unless it has all the bytes needed to decode the message fully. 

<div class="note" markdown="1">
<strong>Tip</strong> : increase the transmission buffer size to limit the number of round trips necessary to send a big message.
</div>

##### The handshake has not been completed

The means the received message is part of the Handshake protocol. Nothing will be propagated to the **IoHandler**, the message will be consumed by the **SslHandler**.

Until the full handshake is completed, every incoming data will be considered as a Handshake protocol message.

At the same time, messages that the **IoHandler** will be enqueued, waiting for the Handshake to be completed.

Here is a schema representing the full process when the data are received in two round-trips :

<div align="center">
  <img src="../images/TLS-unwrap.png" alt="Unwrapping message"/>
</div>


#### filterwWrite event

This event is processed when the **IoSession.write()** method is called. 

If the SSL session is not started, we simply accumulate the message to write. It will be send later.

<div class="note" markdown="1">
There is one tricky parameter that comes into play here, for some very specific need. Typically, when implementing the <strong>startTLS</strong> protocol, where the server is switching from a non secured connection to a secured connection by the mean of an application message (and potentially a response), we need the response to be send back to the client <strong>before</strong> the <strong>SslFilter</strong> is installed (otherwise, the response will be blocked, and the etablishement of a secured connection will simply fail). This is the <strong>DISABLE_ENCRYPTION_ONCE</strong> Attribute. It does not matter what it contains (it can be just a boolean), it's enough for this parameter to be present in the session for the first message to bypasse the <strong>SslFilter</strong>.
</div>

We control the presence of the **DISABLE_ENCRYPTION_ONCE** flag in the session's attributes, and if present, we remove it from the session, and push the message uncrypted into the messages queue to be send.

Otherwise, if the handshake is not yet completed, we keep the message in a queue, and if it's completed, we encrypt it and schedule it to be written.

If some message has been scheduled for write, we flush them all.

#### messageSent event

Here, it's just a matter of getting back the unencrypted message to propagate it to the **IoHandler**

## SSLContext initialisation

We saw that in order to establish a **SSL** session, we need to create a **SSLContext**. Here is the code :


    SSLContext sslContext;

    try
    {
        // Initialize the SSLContext to work with our key managers.
        sslContext = SSLContext.getInstance( "TLS" );
        sslContext.init( ... ); // Provide the needed KeyManager[], TrustManager[] and SecureRandom instances
    }
    catch ( Exception e )
    {
        // Handle your exception
    }

What we have not exposed here is the constructor and the **init()** method. 

The **SSLContext** can either be created explicitly - through its constructor -, or we ask the static factory to return an instance (this is what we have done in the previous code. teh second method is quite straightforward, and would fit most of the time. It's enough to pass it the name of the protocol to use, which is one of :

* **SSL**
* **SSLv2**
* **SSLv3**
* **TLS**
* **TLSv1**
* **TLSv1.1**
* **TLSv1.2** (not supported in Java 6)

It's strongly suggested to pick the higher algorithm (ie **TLSv1.2**) if your client supports it.

The **init()** method takes 3 arguments :

* a **KeyManager** (can be null)
* a **TrustManager** (can be null)
* a random generator (can be null)

If the parameters are set to null, the installed security provider will pick the highest priority implementation.
