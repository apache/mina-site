---
type: mina
title: SSL/TLS internals
---

# SSL/TLS internals

This is a technical description of how SSL/TLS are handled in MINA. You don't need to read this to have it working, better have a look at the [SslFilter user guide](../userguide/ch11-ss-filter/ch11-ssl-filter.html) page. However, if you want to get a deeper understanding on how it's built, this is the place !

Note: We will assume the **MINA API** user has already created the _SSLContext_ to use, so it's not part of those explanations.s

## Components

The **SslFilter** is the filter that command everything related to **SSL/TLS**. It works hands in hands with the **SSLHandler** class, which handles the **SSLEngine** dialog.

With **NIO**, Java provides a special class that handles the **SSL/TLS** protocol, the **SSLEngine** class. It's quite a complex piece of code, and it requires some time to tame it... We will have a look into it during this tutorial. 

The biggest advantage of this **SSLEngine** part is that it totally abstracts the underlaying network part, so it can be used as an encryption part regardless of what the channel is used. You can even decide to use it without transmitting anything :-) On the other hand, it's pretty complex to use...

## Creation

In order to inject the filter in the chain, it must first be created. This filter takes one or two parameters:
* **SSLContext**: the Java class that contains all the information related to the **SSL/TLS** establishment
* __autoStart__: tells if the handshake should be started immediately. This is an optional parameter, defaulting to **TRUE**. In some cases, like when using __startTLS__, it's critical to not start the handshake immediately, as it will be established on demand.

Regarding this __autoStart__ flag, the use case where you set it to **false** are pretty specific. First, on the server side, if your filter chain is configured to contain the **SslFilter**, then this chain will be instanciated when a session is opened, which means the client is already connected, and the very first message it will send is a __handshake__ message. The server **must** be ready to deal with it. 

The problem this flag tries to solve is a use case where you want the **SslFilter** to be present in the chain, but don't want the **handshake** protocol to kick in because you have other filters that need to be able to exchange in clear text with the remote peer on the client side. For instance, if you have a filter set *before* the **SslFilter** in the chain, that is going to send a CONNECT message to a remote peer before establishing the secured connection, then you need to wait for this message to be sent and processed. As the **SSL** initialization is called while adding the **SslFilter** in the chain (specifically while executing the __onPostAdd()__ method), you can't deffer it. Thus the flag is necessary, assuming you can call the **SslHandler** initialization _explicitely_ in the application code.

## Initialization

When injecting the **SslFilter** into your chain, either before starting your service, or while running it, it has to be initialized in some way. Actually, this is a two phases process:
- pre-initialization, during the filter injection
- post-initialization, by starting the Handshake dialog

Most of the time, both phases will be merged, as one can tell the first phase to immediately starts the second.

In any case, it's handled by the __onPreAdd__ and __onPostAdd__ events, which means it's automatically processed when you push the **SslFilter** into the chain.

### onPreAdd

The **SslHandler** class is created and initialized, and the instance is stored into the session attributes. That means each session has its own instance of **SslHandler** (but only one per session). This initialization will create a **SSLEngine** instance based on the provided **SSLContext** instance. The initialization will differ based on the 'side' you are on: server or client. Basically, the server side will wait for the client to initiate the handshake, while the client side will initiate it.

It's also responsible to set the enabled ciphers and protocols, if one wants to use a restricted set, or an extended set (newer versions of Java have disabled old protocols and insecure ciphers).

Last, not least, it sets a list of status flags:
* _writingEncryptedData_: _false_. This flag is used during the handshake
* _handshakeStatus_: the _HandShake_ status, which is originally set to __NOT_HANDSHAKING__
* _firstSSLNegotiation_: _true_. This flag is used to tell the **sslHandler** to send or not an event to the application (**MINA 2.1+** only)
* _handshakeComplete_: _false_. It will be set to true when the handshake has been completed.

Side note: some of those flags are probably spurious. Some cleanup might be done to get rid of the useless ones.

Once that has been done, we can call the _SslHandler.handshake()_ method

### onPostAdd

This event will initiate an immediate handshake if required. Depending on the peer side, the action will be different.

- if we are on the server peer, it will create the **SslEngine**, initialize it for it to be ready to process incoming data.
- if we are on the client peer, it will create the **SslEngine**, initialize it and send the first handshake message.

In any case, the session will only be able to process handshake messages starting from this point, until the handshake is completed.

The consequence is that we can't anymore send messages to the remote peer until the handshake has been completed. However, we need to keep a track of those messages so that the can be published properly once the session has been secured.

At this point, the session has an instance of a _SslHandler_ in its attribute, if the _autoStart_ flag is set to true, otherwise it will be created when the _sessionOpened_ event is propagated.

Note: The _autStart_ flag is set to _false_ if we want to do something while processing the _sessionCreated_ event, before the creation of the _SslHandler_ instance. This is typically when you build a filter chain dynamically, injecting a new filter between the _HeadFilter_ and the _SslFilter_, you don't want the messages to start flowing until the chain is fully built. Most of the time, however, this flag should be set to _true_. 

### Packets handling

The underlaying _SslEngine_ will only consume complete handshake packets, while we may receive incomplete ones. 

We need to keep whatever comes until it's complete (ie until the _SslEngine.unwrap()_ does not return a **BUFFER_UNDERFLOW** result). As the underlaying protocol is **TCP**, we may have to gather incoming messages up to the point it contains at least a complete *handshake* packet.

Assuming we have to deal with *Handhsake* packets, there are a few technical use cases:

* We have received less than one packet: in this case, we will append the newly coming data to the pending data. The maximum message size will be limited by the SO_RCVBUF configuration set when initializing the server, and it may be smaller than a **TLS** packet size. In any case, we gather whatever we just received tinto the pending buffer, increasing its size on the fly. Once we have a complete **TLS** packet, we can process it, remove if from the buffer, and continue from the remaining bytes.

* we have received one or more than one packet: In this case, we will proceed packet by packet, until we have processed each one of them.

Note: The pending buffer can be pre-allocated to the size set by the SO_RECVBUF parameter, in  order to avoid allocating it each time we process a new packet.

Note: Using a circular ByteBuffer would spare the system the need to move the data to the begining of the buffer when it has consumed a **TLS** packet and there are remaining bytes, sadly the **SslEngine** class expect plain **ByteBuffer** instances :-/.


All the received data are flowing through the *SslFilter.messageReceived()* method, which delegate the processing to the associated *Sslhandler* instance:

```
    public void messageReceived(NextFilter next, IoSession session, Object message) throws Exception {
        SslHandler sslHandler = getSslHandler(session);
        sslHandler.receive(next, IoBuffer.class.cast(message));
    }
```

The *SslHandler.receive()* method will gather the incoming data, and process them. When done, it may have to complete the following steps:

* Write back to the remote peer the constructed messages (either *handshake* packets or encrypted data packets)
* Send to the application the received messages (only data packets)
* Forward the produced events (*SslEvent.SECURED* or *SslEvent.UNSECURED*)

### Buffer management

We have different use cases. The first thing is that a TLS record has a limited size, which is the sum of :
* the header (5 bytes) plus some **IV** (_Initialisation Vector_, 16 bytes)
* the data, 16 384 bytes, ie 2^14, or 32 768 bytes (2^15) for windows.
* some padding (block cipher padding), 256 bytes
* the **MAC** maximum size (48 bytes)

Most of the time, records will be smaller (and the packet size is stored in the TLS header).

Now, considering the very nature of **TCP**, we may receive a TLS record in small chunks, or more than one TLS record in a packet of data. We have to deal with both cases.

We will use an internal pending buffer that will contain the incoming data until they can be fully processed. The important point is that the *SslEngine* class is using *ByteBuffer* to get things done, though a set of methods:

* _wrap(ByteBuffer src, [int offset, int length,] ByteBuffer dst)_: Encrypt the data from the source buffer into the destination buffer
* _unwrap(ByteBuffer src, [int offset, int length,] ByteBuffer dst)_: Decrypt the data from the source buffer into the destination buffer

So it's important, from a performance perspective, to allocate a quite large buffer that will be able to hold at least 2 *TLS* packets.

The following schema shows that we are switching from an incoming _IoBuffer_ to a local _pendingBuffer_ then a resulting unencrypted _IoBuffer_ that is propagated to the application:

```
                          +----------------------------------------------------------------+
                          |                                                                |
                          v                                                                |
+------------------+     +----------------+------------------+        +----------------+   |
| incoming message | --> | pending buffer | incoming message | --+--> | remaining data | --+
+------------------+     +----------------+------------------+   |    +----------------+
                                                                 |
                                                                 |    +----------------+
                                                                 +--> | uncrypted data | --> Application
                                                                      +----------------+
```

#### Receiving small chunks

In the case we receive a **TLS** record split in several packets, we won't be able to uncrypt them until we have received a full **TLS** record.

We need to collect at least a full TLS record before calling the _SslEngine.unwrap()_ method, otherwise it will return a **BUFFER_UNDERFLOW** error.

NOTE: the check is also done inside _SSLEngine_, but it's a good idea to do it outside, to avoid a good chunk of useless work to be done.

We use an inner buffer for that purpose, that will cumulate incoming data. This buffer should be large enough to receive at least a **TLS** maximum size bytes, and even more. We will pre-allocate such a buffer, which may be expanded (we may receive more than one **TLS** packet), and shrank (because if we keep it growing, it will use too much memory).


#### Receiving multiple record

We may also receive more than one TLS record. In this case, we will need to loop until we have consumed all of them.

## Handshake handling

Now that the *SslFilter* is set, the server is ready to process the handshake protocol.

Once the client has sent the first **Handshake** message (_ClientHello_), and the server has received it, the dialogue is all about completing the handshake exchange, up to the point the connection is secured or cancelled.

There are multiple phases, but all in all, it's about reading messages and sending back responses.

The very first message is sent by the client. That also mean we won't be able to process any message that is not part of the handshake: if we have some messages to send to the client, or message to be sent by the client, they will be stored in a queue until the handshake is completed.

Handshake packets are encoded using a header which always starts with the **0x16** byte. The following two bytes are the **TLS** version, and the next two bytes is the packet size:

```
+------+------+------+-----------+
| 0x16 | 0XMM | 0Xmm | 0xab 0xcd |
+------+------+------+-----------+
    ^      ^      ^        ^
    |      |      |        |
    |      |      |        +-- packet size, from 0 to 2^14 (or 2^15 on Windows)
    |      |      |        
    |      |      +----------- minor version
    |      |
    |      +------------------ major version
    |
    +------------------------- Handshake byte
```

The major and minor numbers are encoding for:

* _0x03 0x00_: **SSL 3.0** (deprecated)
* _0x03 0x01_: **TLS 1.0** (deprecated)
* _0x03 0x02_: **TLS 1.1**
* _0x03 0x03_: **TLS 1.2** and **TLS 1.3**

Beside this header, the handshake message has a type which is encoded in the protocol header:

```
+------+-----------+-----------+
| 0xNN | 0xab 0xcd | 0xabcd... |
+------+-----------+-----------+
    ^         ^          ^
    |         |          |
    |         |          +-- packet data
    |         |
    |         +------------- message size
    |
    +----------------------- Handshake type
```

The handshake type is one of:

* _0x00_: _hello_request_, used by the server to request a new handshake
* _0x01_: _client_hello_
* _0x02_: _server_hello_
* _0x03_: _hello_verify_request_RESERVED_ (**TLS 1.2** and **TLS 1.3**)
* _0X04_: _new_session_ticket_ (**TLS 1.3**)
* _0x05_: _end_of_early_data_ (**TLS 1.3**)
* _0x06_: _hello_retry_request_RESERVED_ (**TLS 1.2** and **TLS 1.3**)
* _0x08_: _encrypted_extensions_ (**TLS 1.2** and **TLS 1.3**)
* _0x0B_: _certificate_
* _0x0C_: _server_key_exchange_ (**TLS 1.0 **and **TLS 1.1**), server_key_exchange_RESERVED (**TLS 1.2** and **TLS 1.3**)
* _0x0D_: _certificate_request_
* _0x0E_: _server_hello_done_ (**TLS 1.0** and **TLS 1.1**), server_hello_done_RESERVED (**TLS 1.2** and **TLS 1.3**)
* _0x0F_: _certificate_verify_
* _0x10_: _client_key_exchange_ (**TLS 1.0** and **TLS 1.1)**, client_key_exchange_RESERVED (**TLS 1.2** and **TLS 1.3**)
* _0x14_: _finished_
* _0x15_: _certificate_url_RESERVED_ (**TLS 1.2** and **TLS 1.3**)
* _0x16_: _certificate_status_RESERVED_ (**TLS 1.2** and **TLS 1.3**)
* _0x17_: _supplemental_data_RESERVED_ (**TLS 1.2** and **TLS 1.3**)
* _0x18_: _key_update_ (**TLS 1.2** and **TLS 1.3**)
* _0xFE_: _message_hash_ (**TLS 1.2** and **TLS 1.3**)

The idea is to push any received message to the **SSLEngine** instance, asking it for a response message to send back to the remote peer, and so on until we reach the state where the _Handshake_ is completed or aborted.

### SSLEngine states

We have two states to consider:

* The _SSLEngine_ states
* The _Handshake_ states

The first one deal with the _SSLEngine_ status when called either during the _Handshake_ or the data transfert, and we have 4 of them:

* **BUFFER_UNDERFLOW**: The received **TLS** packet does not contain enough information to be correctly handled. In this case, we have to wait for more data from the remote peer, and retry.
* **BUFFER_OVERFLOW**: The buffer that was pre-allocated to receive the result of the _SSLEngine.wrap()/unwrap()_ call is not big enough. It needs to be resized, and the call should be done once more. It's clear that this should never happen, which mean we should always allocate a big enough buffer to receive the processed data.
* **CLOSED**: The _SSLEngine_ has been closed for one reason or another. We need to send the encrypted data to the remote peer, and shutdown the session.
* **OK**: The data processing was fine, we can go on with the generated buffer.

The second one deals with the _Handshake_ processing. We have 5 different states:

* **NEED_UNWRAP**: The _SSLEngine_ is expecting to receive some **TLS** packet to process, ie a **TLS** protocol message from the remote peer.
* **NEED_WRAP**:  The _SSLEngine_ is expecting to generate some **TLS** response packet, ie a **TLS** protocol message to send to the remote peer.
* **NEED_TASK**: Some expensive task are to be executed, and it can be done in a separate thread to avoid blocking the _SSLEngine_ during this processing.
* **NOT_HANDSHAKING**: 

The deal when processing the _Handshake_ protocol is to play with those two status. We start with the _SSLEngine_ status after each operation, then when we get an **OK**, we can check the _Handshake_ status to get to the next step.

### Synchronous vs asynchonous tasks

There are more than just _wrap()_ and _unwrap()_ synchronous methods, when it comes to interact with the _SSLEngine_ instance: it may provide a list of asynchronous tasks to execute. The idea is to avoid blocking the instance for long operations. However, doing so will still require some kind of synchronisation: when the tasks are completed, you need to proceed with the next steps (likely _wrap_).

We may decide to execute each task in the current thread, synchronously, or to delegate the execution to a separate thread.
In the first case, the _Handshake_ may take quite a while to be processed, as some long operation may have to be executed (like the validation of a cettificate froma  remote peer). Assuming we may have more than one task to process, the global time will be the sum of all tasks.
In the second case, we have a different problem: if we delegate the tasks to separate threads, then we have to implement a mechanism to know when all the delegated tasks are completed. 

The biggest advantage of the first approach is that it's easy to implement: we iterate on all the tasks, one after the other, and when done, we can keep going with the handshake processing.

The biggest advantage of the second approach is that we run the tasks in parallel, optimizing the CPU usage, likely speeding up the _Handshake_ completion.

The biggest drawback of the first approach is the increased time taken to handle the tasks, slowing down the _Hansdhake_ processing.

The biggest drawback of the second approach is potential usage of many threads, causing costly context switches when many session are processing a handshake. Using a thread pool also risks to cause a starvation and some augmented delay, compared to the first approach.


One more thing to consider: if we want to use *Virtual Threads*, as they still depend on a underlying physical thread, the starvation problem remains...

Note: all the _SSLEngine_ methods (_wrap()_, _unwrap()_, etc) are synchronized, so once you start a delegated task, any other _Handshake_ operation will be suspended, waiting for the task to be completed. That means tasks can be executed concurrently, but no other operation.

```
(SSLConsumer)
      ^
      |
      +-- [AlertConsumer]
      |
      +-- [CertificateStatusConsumer]
      |
      +-- [ClientHelloConsumer]
      |
      +-- [ClientKeyExchangeConsumer]
      |
      +-- [DHClientKeyExchangeConsumer]
      |
      +-- [DHServerKeyExchangeConsumer]
      |
      +-- [ECDHClientKeyExchangeConsumer]
      |
      +-- [ECDHEClientKeyExchangeConsumer]
      |
      +-- [ECDHServerKeyExchangeConsumer]
      |
      +-- [EncryptedExtensionsConsumer]
      |
      +-- [HelloRequestConsumer]
      |
      +-- [KeyUpdateConsumer]
      |
      +-- [KrbClientKeyExchangeConsumer]
      |
      +-- [NewSessionTicketConsumer]
      |
      +-- [RSAClientKeyExchangeConsumer]
      |
      +-- [RSAServerKeyExchangeConsumer]
      |
      +-- [S30CertificateVerifyConsumer]
      |
      +-- [ServerHelloConsumer]
      |
      +-- [ServerHelloDoneConsumer]
      |
      +-- [ServerKeyExchangeConsumer]
      |
      +-- [SSLHandshake]
      |
      +-- [T10CertificateRequestConsumer]
      |
      +-- [T10CertificateVerifyConsumer]
      |
      +-- [T10ChangeCipherSpecConsumer]
      |
      +-- [T12CertificateConsumer]
      |
      +-- [T12CertificateRequestConsumer]
      |
      +-- [T12CertificateVerifyConsumer]
      |
      +-- [T12FinishedConsumer]
      |
      +-- [T13CertificateConsumer]
      |
      +-- [T13CertificateRequestConsumer]
      |
      +-- [T13CertificateVerifyConsumer]
      |
      +-- [T13ChangeCipherSpecConsumer]
      |
      +-- [T13FinishedConsumer]
```


Here is an exemple for the _CLIENT_HELLO_ message on the server side:



## Application Data handling

Once the handshake has been successful, we can start exchange data with the remote peer. Those data will be encrypted, then transmitted into a **TLS** packet, and on the remote peer, the data are unencypted, then transmitted to the application handler:

```  
    Sender peer                               TLS packets              Network
+------------------+                      +-----------------+      
| Application data | --> {encryption} --> | i5*du7!!yyho_&y | ------------+
+------------------+                      +-----------------+             |
                                                                          v 
                                                                    _ ___________ 
                                                                   (_)___________)
                                                                          |
+------------------+                      +-----------------+             |
| Application data | <-- {decryption} <-- | i5*du7!!yyho_&y | <-----------+
+------------------+                      +-----------------+
   Receiving peer                             TLS packets
```

Each encrypted data are stored into **TLS** packet (and we may need more than one **TLS** packets to store the whole data).

The encryption and decryption are done by the **SslEngine** instance of the session.

Note: The **TLS** packets contain opaque data (bytes), so there must be some added logic to make sense of those data for the application to process them. 

In any case, we have two use cases:

* Writing data
* Reading data

### Reading data

Let's start with the reading side. As explained upper, we receive bytes which are parts or **TLS** packets, or complete **TLS** packets. We will decrypt them only when we have enough bytes to form a complete **TLS** packet. In this case, we just have to tell the **SslEngine** instance to decrypt it, which will product a decrypted buffer containing the original data. Last, not least, we have to send those data to the application handler.

The process is described by the following schema:

```
[[encrypted data]]           .--------.
        |                    |        |
        +--------------> [unwrap]     | --> [decrypted data] --+ 
                             |        |                        |
                             .________.                        |
                                                               v
                              SslEngine        nextFilter.received([decrypted data])
                              instance
```

This is a bit simplified, we have some additional steps to follow:

* Check that we have received enough data to be able to pass it to the _SslEngine_ instance (ie we have received at least a complete *TLS* data packet)
* Allocate a new buffer that will receive the decrypted data
* Check the status of the _SslEngine_ instance before and after the decryption, and act accordingly
* Loop on the received data

All in all, we can see that we end with a call to the _SSLEngine.unwrap()_ method, which is responsible for decoding what ha sbeen received.

Otherwise, it's pretty straightforward. Here are the calls

```
SslFilter.messageReceived()
 |
 +-- SslHandler.receive()
      | 
      +-- SslHandler.receiveStart(next, message);       // (1)
      |    |
      |    +-- SslHandler.resumeDecodeBuffer(message)   // (2)
      |    |
      |    +-- SslHandler.receiveLoop(next, source)     // (3)
      |    |    |
      |    |    +-- check if the inbound channel has been closed        // (4)
      |    |    |
      |    |    +-- SslHandler.allocateAppBuffer(source.remaining())    // (5)
      |    |    |
      |    |    +-- SSLEngine.unwrap(source.buf(), dest.buf())          // (6)
      |    |
      |    +-- SslHandler.suspendDecodeBuffer(source)   // (7)
      |
      +-- SslHandler.throwPendingError(next)           // (8)
      |
      +-- SslHandler.forwardWrites(next)                // (9)
      |
      +-- SslHandler.forwardReceived(next)              // (10)
      |    |
      |    +-- next.messageReceived(mSession, x)        // (11) Up to the Application handler
      |         
      +-- SslHandler.forwardEvents(next)                // (12)
```

* (1) Process the incoming message
* (2) Accumulate the received message in a session buffer
* (3) Loop until the session buffer has been consumed, and as soon as we have a complete **TLS** packet
* (4) Check if the remote peer has closed the connection. If so, shutdown the **TLS** layer
* (5) Allocate a buffer to store the decrypted message
* (6) Decrypt the message.
* (7) Clean up the decoding buffer 
* (8) Manage any possible errors
* (9) Process the pending writes
* (10) Process the decrypted message
* (11) Call the next filter in the stack with the decrypted message, if we are able of doing so
* (12) This all is necessary when processing the handshake, it does nothing here

Note: In step (4), we need to verify that the remote peer hasn't closed the outgoing connection. If so, we have to write everything that is pending.

### Writing data