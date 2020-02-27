---
type: mina
title: 2.1 - Application Architecture
navPrev: ch2-basics.html
navPrevText: Chapter 2 - Basics
navUp: ch2-basics.html
navUpText: Chapter 2 - Basics
navNext: ch2.2-sample-tcp-server.html
navNextText: 2.2 - Sample TCP Server
---

* [2.1.1 - Server Architecture](ch2.1.1-server-architecture.html)
* [2.1.2 - Client Architecture](ch2.1.2-client-architecture.html)

# 2.1 -  MINA based Application Architecture

It's the question most asked : 'How does a **MINA** based application look like'? In this article lets see what's the architecture of MINA based application. Have tried to gather the information from presentations based on **MINA**.

A Bird's Eye View :

![](/assets/img/mina/apparch_small.png)

Here, we can see that **MINA** is the glue between your application (be it a client or a server) and the underlying network layer, which can be based on TCP, UDP, in-VM communication or even a RS-232C serial protocol for a client.

You just have to design your application on top of MINA without having to handle all the complexity of the newtork layer.

Lets take a deeper dive into the details now. The following image shows a bit more the internal of **MINA**, and what are each of the **MINA** components doing :

![](/assets/img/mina/mina_app_arch.png)

(The image is from Emmanuel L{{< html "&eacute;" >}}charny presentation [MINA in real life (ApacheCon EU 2009)](/assets/pdfs/Mina_in_real_life_ASEU-2009.pdf))

Broadly, MINA based applications are divided into 3 layers

* I/O Service - Performs actual I/O
* I/O Filter Chain - Filters/Transforms bytes into desired Data Structures and vice-versa
* I/O Handler - Here resides the actual business logic

So, in order to create a MINA based Application, you have to :

1. Create an I/O service - Choose from already available Services (*Acceptor) or create your own
2. Create a Filter Chain - Choose from already existing Filters or create a custom Filter for transforming request/response
3. Create an I/O Handler - Write business logic, on handling different messages

This is pretty much it. 

You can get a bit deeper by reading those two pages :

* [2.1.1 - Server Architecture](ch2.1.1-server-architecture.html)
* [2.1.2 - Client Architecture](ch2.1.2-client-architecture.html)

Of course, **MINA** offers more than just that, and you will probably have to take care of many other aspects, like the messages encoding/decoding, the network configuration how to scale up, etc... We will have a further look at those aspects in the next chapters.

