---
type: mina
title: Related Projects
---

# Related Projects

This page lists the projects which use Apache MINA as its networking layer. Please contact us if you are using MINA and you want to add a link to this page. You could also read the users' testimonials. To compare MINA to other network application frameworks, please refer to the 'Other network application frameworks' section below.

{{% toc %}}

## Other network application frameworks

<div class="note" markdown="1">
    The projects referred in this section 'Other network application frameworks' are <strong>not</strong> based on MINA but are their own network application frameworks.  These links are provided for users who want to compare MINA to other network application frameworks.
</div>

### [Grizzly](https://grizzly.java.net/)

Grizzly framework has been designed to help developers to take advantage of the Java™ NIO API. Originally developed under the GlassFish umbrella, the framework is now available as a standalone project. Grizzly goals is to help developers to build scalable and robust servers using NIO.

### [Netty 3](http://www.jboss.org/netty/)

The new version of Netty Trustin Lee is working on now. The Netty project is an effort to provide an asynchronous event-driven network application framework and tools for rapid development of maintainable high performance and high scalability protocol servers and clients.

### [NIO Framework](http://nioframework.sourceforge.net/)

The NIO Framework is a library on top of NIO that hides most of the complexity of plain NIO. With the NIO Framework you can implement high-performance Java network applications without having to deal with all the nasty details of NIO. The issues above are resolved while the performance is preserved.

### [QuickServer](http://www.quickserver.org/)

QuickServer is an open source Java library/framework for quick creation of robust multi-client TCP server applications. QuickServer provides an abstraction over the ServerSocket, Socket and other network and input output classes and it eases the creation of powerful network servers.

### [xSocket](http://xsocket.sourceforge.net/)

xSocket is a easy to use NIO-based library to build high performance, highly scalable network applications. It supports writing client-side applications as well as server-side applications in an intuitive way. Issues like low level NIO selector programming, connection pool management, connection timeout detection or fragmented buffer reads are encapsulated by xSocket.

## Messaging

### [Apache Camel](http://activemq.apache.org/camel/)

Apache Camel is a POJO routing and mediation library for working with files, FTP, HTTP, MINA, JMS, JBI and web services.

### [Apache Qpid (incubating)](http://cwiki.apache.org/qpid/)

The Apache Qpid Project implemented [AMQP (Advanced Message Queuing Protocol)](http://www.amqp.org/) using Apache MINA.

### [Avis](http://avis.sourceforge.net/)

Avis is an event router service compatible with the commercial Elvin implementation developed by Mantara Software. Avis provides a fast, general-purpose publish/subscribe message bus.

### [MailsterSMTP](http://tedorg.free.fr/en/projects.php?section=smtp)

MailsterSMTP is designed to be a easy to understand Java library which provides a receptive SMTP server component. Using this library, you can easily receive mails using a simple Java interface, extend the set of implemented commands or control how mails are delivered by plugging your custom implementations.

## Instant Messaging

### [Jive Software Openfire](http://www.jivesoftware.com/products/openfire/)

Jive Software Openfire implemented [XMPP (Extensible Messaging and Presence Protocol)](http://www.xmpp.org/) server on top of Apache MINA. After switching to Apache MINA, [they gained 11 times scalability boost](http://community.igniterealtime.org/blogs/ignite/2006/12/19/scalability-turn-it-to-eleven/).

## Media Storage & Streaming

### [OpenLSD](http://openlsd.free.fr/en/OpenLSD.html)

OpenLSD is an open source framework for massive document archiving. The web site also contains an interesting performance test report.

### [Red5](http://www.osflash.org/red5)

OSFlash.org team implemented an open-source flash media streaming ([RTMP, Real Time Messaging Protocol](http://en.wikipedia.org/wiki/Real_Time_Messaging_Protocol)) server with Apache MINA.

## Miscellaneous

### [Apache Directory Project](http://directory.apache.org/)

The Apache Directory Project implemented LDAP v3, Kerberos, DNS, DHCP, NTP, and ChangePW using Apache MINA.

### [Beep4j](http://beep4j.sourceforge.net/)

Beep4j is an open-source implementation of the [BEEP](http://www.beepcore.org/) specification (RFC3080 and RFC3081).

### [VFS FTPServer Bridge](http://vfs-utils.sourceforge.net/ftpserver/index.html)

This project provides an Apache Commons VFS implementation for the Apache FTPServer project. Instead of working only on local files, with this VFS bridge you can connect to any VFS provider. You can still use a local file system, but you can also use a ZIP file, loop through to another FTP server, or use any other available VFS implementation such as DctmVFS.

### <a name="HDFSoverFTP" />[HDFS over FTP](https://sites.google.com/a/iponweb.net/hadoop/Home/hdfs-over-ftp)

FTP server which works on a top of HDFS. It aAllows to connect to HDFS using any FTP client. FTP server is configurable by hdfs-over-ftp.conf and users.conf. Also it allows to use secure connection over SSL and supports all HDFS permissions
