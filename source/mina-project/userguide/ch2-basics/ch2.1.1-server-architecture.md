---
type: mina
title: 2.1.1 - Server Architecture
navPrev: ch2.1-application-architecture.html
navPrevText: 2.1 - Application Architecture
navUp: ch2.1-application-architecture.html
navUpText: 2.1 - Application Architecture
navNext: ch2.1.2-client-architecture.html
navNextText: 2.1.2 - Client Architecture
---

# 2.1.1 - Server Architecture

We have exposed the **MINA** Application Architecture in the previous section. Let's now focus on the Server Architecture. Basically, a Server listens on a port for incoming requests, process them and send replies. It also creates and handles a session for each client (whenever we have a TCP or UDP based protocol), this will be explain more extensively in the [chapter 4](../ch4-session/ch4-session.html).

![](/assets/img/mina/Server_arch.png)

* IOAcceptor listens on the network for incoming connections/packets
* For a new connection, a new session is created and all subsequent request from IP Address/Port combination are handled in that Session
* All packets received for a Session, traverses the Filter Chain as specified in the diagram. Filters can be used to modify the content of packets (like converting to Objects, adding/removing information etc). For converting to/from raw bytes to High Level Objects, PacketEncoder/Decoder are particularly useful
* Finally the packet or converted object lands in `IOHandler`. `IOHandler`s can be used to fulfill business needs.

## Session creation

Whenever a client connects on a MINA server, we will create a new session to store persistent data into it. Even if the protocol is not connected, this session will be created. The following schema shows how **MINA** handles incoming connections :

![Incoming connections handling](/assets/img/mina/incoming-connections.png)


## Incoming messages processing

We will now explain how **MINA** processes incoming messages.

Assuming that a session has been created, any new incoming message will result in a selector being waken up