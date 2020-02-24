---
type: mina
title: Chapter 12 - Logging Filter
navPrev: ../ch11-ssl-filter/ch11-ssl-filter.html
navPrevText: Chapter 11 - SSL Filter
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch13-debugging/ch13-debugging.html
navNextText: Chapter 13 - Debugging
---

# Chapter 12 - Logging Filter

{{% toc %}}

# Background

The Apache MINA uses a system that allows for the developer of the MINA-base application to use their own logging system.

## SLF4J

MINA employs the Simple Logging Facade for Java (SLF4J). You can find information on SLF4J here. This logging utility allows for the implementation of any number of logging systems. You may use log4j, java.util.logging or other logging systems. The nice part about this is that if you want to change from java.util.logging to log4j later on in the development process, you do not need to change your source code at all.

### Choosing the Right JARs

SLF4J uses a static binding. This means there is one JAR file for each supported logging framework. You can use your favorite logging framework by choosing the JAR file that calls the logging framework you chose statically. The following is the table of required JAR files to use a certain logging framework.

| Logging framework | Required JARs |
|---|---|
| Log4J 1.2.x | **sl**f4j-api.jar**, **slf4j-log4j12.jar** |
| Log4J 1.3.x | **slf4j-api.jar**, **slf4j-log4j13.jar** |
| java.util.logging | <tt>slf4j-api.jar**, **slf4j-jdk14.jar** |
| Commons Logging | **slf4j-api.jar**, **slf4j-jcl.jar** |

There are a few things to keep in mind:

* slf4j-api.jar is used commonly across any implementation JARs.
* __IMPORTANT__ You should not put more than one implementation JAR files in the class path (e.g. slf4j-log4j12.jar and slf4j-jdk14.jar); it might lead your application to a unexpected behavior.
* The version of slf4j-api.jar and slf4j-<impl>.jar should be identical.

Once configured properly, you can continue to configure the actual logging framework you chose (e.g. modifying log4j.properties).

### Overriding Jakarta Commons Logging

SLF4J also provides a way to convert the existing applications that use Jakarta Commons Logging to use SLF4J without changing the application code. Just remove commons-logging JAR file from the class path, and add jcl104-over-slf4j.jar to the class path.

## log4j example

For this example we will use the log4j logging system. We set up a project and place the following snippet into a file called log4j.properties:

```text
# Set root logger level to DEBUG and its only appender to A1.
log4j.rootLogger=DEBUG, A1

# A1 is set to be a ConsoleAppender.
log4j.appender.A1=org.apache.log4j.ConsoleAppender

# A1 uses PatternLayout.
log4j.appender.A1.layout=org.apache.log4j.PatternLayout
log4j.appender.A1.layout.ConversionPattern=%-4r [%t] %-5p %c{1} %x - %m%n
```

This file will be placed in the src directory of our project. If you are using an IDE, you essentially want the configuration file to be in the classpath for the JVM when you are testing your code.

<div class="note" markdown="1">
    Although this shows you how to set up an <tt>IoAcceptor</tt> to use logging, understand that the SLF4J API may be used anywhere in your program in order to generate proper logging information suitable to your needs.
</div>

Next we will set up a simple example server in order to generate some logs. Here we have taken the EchoServer example project and added logging to the class:

```java
public static void main(String[] args) throws Exception {
    IoAcceptor acceptor = new SocketAcceptor();
    DefaultIoFilterChainBuilder chain = acceptor.getFilterChain();

    LoggingFilter loggingFilter = new LoggingFilter();
    chain.addLast("logging", loggingFilter);                  

    acceptor.setLocalAddress(new InetSocketAddress(PORT));
    acceptor.setHandler(new EchoProtocolHandler());
    acceptor.bind();

    System.out.println("Listening on port " + PORT);
}
```

As you can see we removed the addLogger method and added in the 2 lines added to the example EchoServer. With a reference to the LoggingFilter, you can set the logging level per event type in your handler that is associated with the IoAcceptor here. In order to specify the IoHandler events that trigger logging and to what levels the logging is performed, there is a method in the LoggingFilter called setLogLevel(IoEventType, LogLevel). Below are the options for this method:

| IoEventType | Description |
|---|---|
| SESSION_CREATED | Called when a new session has been created |
| SESSION_OPENED | Called when a new session has been opened |
| SESSION_CLOSED | Called when a session has been closed |
| MESSAGE_RECEIVED | Called when data has been received |
| MESSAGE_SENT | Called when a message has been sent |
| SESSION_IDLE | Called when a session idle time has been reached |
| EXCEPTION_CAUGHT | Called when an exception has been thrown |


Here are the descriptions of the LogLevels:

| LogLevel | Description |
|---|---|
| NONE | This will result in no log event being created regardless of the configuration |
| TRACE | Creates a TRACE event in the logging system |
| DEBUG | Generates debug messages in the logging system |
| INFO | Generates informational messages in the logging system |
| WARN | Generates warning messages in the logging system |
| ERROR | Generates error messages in the logging system |

With this information, you should be able to get a basic system up and running and be able to expand upon this simple example in order to be generating log information for your system.
