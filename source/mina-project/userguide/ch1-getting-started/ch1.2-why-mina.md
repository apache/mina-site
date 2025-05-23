---
type: mina
title: 1.2 - Why MINA
navPrev: ch1.1-nio-overview.html
navPrevText: 1.1 - NIO Overview
navUp: ch1-getting-started.html
navUpText: Chapter 1 - Getting Started
navNext: ch1.3-features.html
navNextText: 1.3 - Features
---

# Why MINA?

Writing network applications are generally seen as a burden and perceived as low level development. It is an area which is not frequently studied or known by developers, either because it has been studied in school a long time ago and everything has been forgotten, or because the complexity of the network layer is frequently hidden by higher level layers, so you never get deep into it.

Added to that (when it comes to asynchronous IO) an extra layer of complexity comes into play: time.

The big difference between **BIO** (Blocking IO) and **NIO** (Non-Blocking IO) is that in **BIO**, you send a request, and you wait until you get the response. On the server side, it means one thread will be associated with any incoming connection, so you won't have to deal with the complexity of multiplexing the connections. In **NIO**, on the other hand, you have to deal with the  synchronous nature of a non-blocking system, which means that your application will be invoked when some events occur. In **NIO**, you don't call and wait for a result, you send a command and you are informed when the result is ready.

## The need of a framework

Considering those differences, and the fact that most of the applications are usually expecting a blocking mode when invoking the network layer, the best solution is to hide this aspect by writing a framework that mimics a blocking mode. This is what **MINA** does!

But **MINA** does more. It provides a common IO vision to an application that needs to communicate over **TCP**, **UDP** or whatever mechanism. If we consider only **TCP** and **UDP**, one is a connected protocol (**TCP**) where the other is connectionless (**UDP**). **MINA** masks this difference, and makes you focus on the two parts that are important for your application: the application code and the application protocol encoding/decoding.

***MINA** does not only handle **TCP** and **UDP**, it also offers a layer on top of serial communication (**RSC232**), over **VmpPipe** or **APR**. 

Last but not least, **MINA** is a network framework that has been specifically designed to work on both the client side and server side. Writing a server makes it critical to have a scalable system, which is tunable to fit the server needs, in terms of performance and memory usage. This is what **MINA** is good for, making it easy to develop you server.

## When to use MINA?

This is an interesting question! **MINA** does not expect to be the best possible choice in all cases. There are a few elements to take into account when considering using **MINA**. Let's list them:

 * Ease of use
     When you have no special performance requirements, **MINA** is probably a good choice as it allows you to develop a server or a client easily, without having to deal with the various parameters and use cases to handle when writing the same application on top of **BIO** or **NIO**. You could probably write your server with only a few lines of code, and there are less pitfalls in which you are likely to fall.
    
 * A high number of connected users
    **BIO** is definitively faster that **NIO**. The difference is something like 30% in favor of **BIO**. This is true for up to a few thousands of connected users, but up to a point, the **BIO** approach just stops scaling; you won't be able to handle millions of connected users using one thread per user! **NIO** can. Now, one other aspect is that the time spent in the **MINA** part of your code is probably non significant, compared to whatever your application will consume. At some point, it's probably not worthwhile to spend the energy trying to writing a faster network layer on your own for a gain which will be barely noticeable.
    
 * A proven system
     **MINA** is used by many applications all over the world. There are some *Apache* projects based on **MINA**, and they are working pretty well. This gives you the ease of mind that you won't have to spend hours on some cryptic errors in your own implementation of the network layer.
    
 * Existing supported protocols
    **MINA** ships with various implemented protocols: HTTP, XML, TCP, LDAP, DHCP, NTP, DNS, XMPP, SSH, FTP... At some point, **MINA** can be seen not only as a **NIO** framework, but as a network layer with some protocol implementation. In the near future **MINA** may offer a more extensive collection of protocols for you to use.
    
