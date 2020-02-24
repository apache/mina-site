---
type: mina
title: 6.1 - APR Transport
navPrev: ch6-transports.html
navPrevText: Chapter 6 - Transports
navUp: ch6-transports.html
navUpText: Chapter 6 - Transports
navNext: ch6.2-serial-transport.html
navNextText: 6.2 - Serial Transport
---

# 6.1 - APR Transport

## Introduction

[APR (Apache Portable Runtime)](https://apr.apache.org/) provide superior scalability, performance, and better integration with native server technologies. APR transport is supported by MINA. In this section, we shall touch base upon how to use APR transport with MINA. We shall the Time Server example for this.

## Pre-requisite

<div class="info" markdown="1">
    APR transport depends following components<br>
    APR library - Download/install appropriate library for the platform from <a href="https://www.apache.org/dist/tomcat/tomcat-connectors/native/" class="external-link" rel="nofollow">https://www.apache.org/dist/tomcat/tomcat-connectors/native/</a><br>
    JNI wrapper (tomcat-apr-5.5.23.jar) The jar is shipped with release
    <p>Put the native library in PATH</p>
</div>

## Using APR Transport

Refer [Time Server](https://mina.apache.org/mina-project/xref/org/apache/mina/example/gettingstarted/timeserver/) example for complete source

Lets see how NIO based Time server implementation looks like

```java
IoAcceptor acceptor = new NioSocketAcceptor();

acceptor.getFilterChain().addLast( "logger", new LoggingFilter() );
acceptor.getFilterChain().addLast( "codec", new ProtocolCodecFilter( new TextLineCodecFactory( Charset.forName( "UTF-8" ))));

acceptor.setHandler(  new TimeServerHandler() );

acceptor.getSessionConfig().setReadBufferSize( 2048 );
acceptor.getSessionConfig().setIdleTime( IdleStatus.BOTH_IDLE, 10 );

acceptor.bind( new InetSocketAddress(PORT) );
```

Lets see how to use APR Transport
    
```java
IoAcceptor acceptor = new AprSocketAcceptor();

acceptor.getFilterChain().addLast( "logger", new LoggingFilter() );
acceptor.getFilterChain().addLast( "codec", new ProtocolCodecFilter( new TextLineCodecFactory( Charset.forName( "UTF-8" ))));

acceptor.setHandler(  new TimeServerHandler() );

acceptor.getSessionConfig().setReadBufferSize( 2048 );
acceptor.getSessionConfig().setIdleTime( IdleStatus.BOTH_IDLE, 10 );

acceptor.bind( new InetSocketAddress(PORT) );
```

We just change the NioSocketAcceptor to AprSocketAcceptor. That's it, now our Time Server shall use APR transport.

Rest complete process remains same.

