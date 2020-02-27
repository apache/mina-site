---
type: vysper
title: Vysper SOCKS5 bytestream module
---

# SOCKS5 bytestream module

<div class="info" markdown="1">
    Available since version 0.7.
</div>

The Vysper SOCKS5 Bytestream module implements mediated connections from XEP-0065 SOCKS5 Bytestream. Direct connections requires no support from the server and thus works without this module. For mediated connections, this module will supply a SOCKS5 proxy that transfers data between the requester and target clients. The module also provides all the required service discovery support used to negotiate the address of the SOCKS5 proxy.

The example below shows how to add the module using the API:

```java
XMPPServer server = new XMPPServer("vysper.org");
server.addEndpoint(new TCPEndpoint());

// other initialization
server.addModule(new Socks5Module());

server.start();
```

This will enable the SOCKS5 component on socks.vysper.org and start a proxy on port 5777. Make sure socks.vysper.org resolves to the server running Vysper.

To configure the subdomain name, provide the subdomain in the constructor:

```java
server.addModule(new Socks5Module("proxy"));
```

In this case, the SOCKS5 component would be available on proxy.vysper.org.

It is also possible to supply a socket address on which the proxy will be listening. This can be used to configure the port for the proxy, or the local address to bind the proxy to. For example:

```java
server.addModule(new Socks5Module("proxy", new InetSocketAddress("foo.vysper.org", 18100)));
```

With this code, the proxy will use the JID proxy.vysper.org, the hostname foo.vysper.org and the port 18100. It will only listen on the network interface for foo.vysper.org.

```java
server.addModule(new Socks5Module("proxy";, new> InetSocketAddress(18100)));
```

In this case, the proxy will use the JID and hostname proxy.vysper.org and the port 18100. It will listen on all network interfaces.

## Limitations

The module currently only supports unauthenticated SOCKS5 connections (support for username/password connections is tracked in [VYSPER-280](https://issues.apache.org/jira/browse/VYSPER-280)).
