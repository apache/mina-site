---
type: vysper
title: Embed Vysper into another application
---

# Embed into another application

## About logging

Embedding software making use of logging into another one making use of logging itself can be cumbersome.
Vysper uses slf4j for logging, which foremost is a logging facade. The actual logging worker is then bound at runtime. It can be log4j, as in standalone Vysper, or some other logging framework. If you make use of one of these in your embedding application, just put the proper slf4j adapter lib onto the classpath. For more info about slf4j, see the website at slf4j.org.

## Libraries

This example doesn't make use of the Spring-based deployment. So we don't need the Spring libraries here.

TODO: elaborate about the other libs needed.

## Start server (naivly)

Having a Vysper XMPP server instance embedded into your own application is easy:

```java
import org.apache.vysper.xmpp.server;

XMPPServer server = new XMPPServer("myembeddedjabber.com");
server.start();
```

Unfortunately, this is not the whole story, we need to do some more preparations first. Hang on!

## Start server (full story)

We make use of the JCR-persistent storage, and we add one user.
If you need more users, add more. Just make sure their Jabber ID domain matches the server's domain ("myembeddedjabber.com", in this case).

```java
// choose the storage you want to use
StorageProviderRegistry providerRegistry = new JcrStorageProviderRegistry();
//StorageProviderRegistry providerRegistry = new MemoryStorageProviderRegistry();

final AccountManagement accountManagement = (AccountManagement) providerRegistry.retrieve(AccountManagement.class);

if(!accountManagement.verifyAccountExists(EntityImpl.parse("user1@myembeddedjabber.com"))) {
    accountManagement.addUser(EntityImpl.parse("user1@myembeddedjabber.com"), "password1");
}
```

Now, instantiate the server and set the fundamental stuff: endpoint, user management and TLS.

SSL needs a TLS certificate. There is one coming along with Vysper for testing purposes only, just make sure it is properly referenced on the file system.
Or, even better, create your own.

```java
XMPPServer server = new XMPPServer("myembeddedjabber.com");
server.addEndpoint(new TCPEndpoint());
server.setStorageProviderRegistry(providerRegistry);

server.setTLSCertificateInfo(new File("src/main/config/bogus_mina_tls.cert"), "boguspw");
```

With initializing completed, just give it a go:

```java
try {
    server.start();
    System.out.println("server is running...");
} catch (Exception e) {
    e.printStackTrace();
}
```

## Adding modules to the server.

The server starts up with two built-in modules, Roster and Service Discovery. Both can be considered as optional, but for a proper server you would normally want to have them (and if you don't, remove them from code in XMPPServer.start() and rebuild).

Some handy modules can be added, but this is optional:

```java
server.addModule(new SoftwareVersionModule());
server.addModule(new EntityTimeModule());
server.addModule(new VcardTempModule()); // depends on Jcr persistence
```

## Reference

The full and probably improved latest version of this code can be found [here](http://svn.apache.org/repos/asf/mina/sandbox/vysper/trunk/server/core/src/main/java/org/apache/vysper/xmpp/server/ServerMain.java)
