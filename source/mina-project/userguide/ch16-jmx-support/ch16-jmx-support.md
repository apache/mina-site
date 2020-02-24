---
type: mina
title: Chapter 16 - JMX Support
navPrev: ../ch15-proxy/ch15-proxy.html
navPrevText: Chapter 15 - Proxy
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch17-spring-integration/ch17-spring-integration.html
navNextText: Chapter 17 - Spring Integration
---

# Chapter 16 - JMX Support

Java Management Extensions (JMX) is used for managing and monitoring java applications.  This tutorial will provide you with an example as to how you can JMX-enable your MINA based application.

This tutorial is designed to help you get the JMX technology integrated in to your MINA-based application. In this tutorial, we will integrate the MINA-JMX classes into the imagine server example program.

# Adding JMX Support

To JMX enable MINA application we have to perform following

* Create/Get MBean server
* Instantiate desired MBeans (IoAcceptor, IoFilter)  
* Register MBeans with MBean server

We shall follow \src\main\java\org\apache\mina\example\imagine\step3\server\ImageServer.java, for the rest of our discussion

## Create/Get MBean server

```java
// create a JMX MBean Server server instance
MBeanServer mBeanServer = ManagementFactory.getPlatformMBeanServer();
```

This lines get the MBean Server instance.

## Instantiate MBean(s)

We create an MBean for IoService

```java
// create a JMX-aware bean that wraps a MINA IoService object.  In this
// case, a NioSocketAcceptor. 
IoServiceMBean acceptorMBean = new IoServiceMBean( acceptor );
```

This creates an IoService MBean. It accepts instance of an acceptor that it exposed via JMX.

Similarly, you can add IoFilterMBean and other custom MBeans as well

## Registering MBeans with MBean Server

```java
// create a JMX ObjectName.  This has to be in a specific format.  
ObjectName acceptorName = new ObjectName( acceptor.getClass().getPackage().getName() +
        ":type=acceptor,name=" + acceptor.getClass().getSimpleName());
    
// register the bean on the MBeanServer.  Without this line, no JMX will happen for
// this acceptor.
mBeanServer.registerMBean( acceptorMBean, acceptorName );
```

We create an ObjectName that need to be used as logical name for accessing the MBean and register the MBean to the MBean Server. Our application in now JMX enabled. Lets see it in action.

## Start the Imagine Server

If you are using Java 5 or earlier:

```bash
java -Dcom.sun.management.jmxremote -classpath <CLASSPATH> org.apache.mina.example.imagine.step3.server.ImageServer
```

If you  are using Java 6:

```bash
java  -classpath <CLASSPATH> }}{{{}org.apache.mina.example.imagine.step3.server.ImageServer
```

## Start JConsole 

Start JConsole using the following command: 

```bash
<JDK_HOME>/bin/jconsole
```

We can see the different attributes and operations that are exposed by the MBeans
