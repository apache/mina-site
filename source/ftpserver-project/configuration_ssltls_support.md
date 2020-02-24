---
type: ftpserver
title: FtpServer TLS-SSL Support
---

# TLS-SSL Support

This document explains how to enable Apache FTP Server to use Transport Layer Security (TLS) for encrypted client-server communication.

FtpServer uses the Java Secure Sockets Extension (JSSE) infrastructure to provide TLS/SSL sockets. JSSE comes packaged with several vendor Java distributions (i.e. Sun Java 1.4.x, IBM Java 1.3.x). For these distributions, please follow the vendor provided instructions for configuring the JVM to use JSSE services.

## Security mode

### Explicit Security (default)

In this mode server supports both secure and non-secure connection. Upon request from client (AUTH SSL) the server switches to the SSL/TLS mode.

In this case, the listener should not use implicit SSL (the default value):

```xml
<nio-listener name="default" implicit-ssl="false">
```

### Implicit Security

If you want to use implicit SSL connection, that is, SSL is always enabled on the control socket. The first thing you need to do is to tell the listener to use implicit SSL mode:

```xml
<nio-listener name="default" implicit-ssl="true">
```

If you set the listener to use implicit security, enabling implicit security for the data connection should be considered

### Data connection security

Implicit secure listener does not ensure encrypted data transfer. To use SSL/TLS in data connection, client either has to send "PROT P" command or implicit security must be enabled for the data connection.

```xml
<data-connection implicit-ssl="true">
```

If no explicit configuration for SSL keystores and truststores is provided for the data connection, it will be inherited from the listener. This is the normal configuration.

Different FTP clients behave different with regards to implicit security on the data connection, some assume an SSL enabled socket, while some will always send a "PROT P" command. The following table shows the characteristics of some clients, please report others.

| FTP client | Behavior |
|---|---|
| FileZilla | Sends "PROT P" command automatically in implicit security mode |
| DartFTP/PowerTCP | Assumes an SSL enabled data connection, does not send "PROT P" |

### Detailed configuration

Full documentation on all provided configuration is available on the [Listeners](configuration_listeners.html) page
