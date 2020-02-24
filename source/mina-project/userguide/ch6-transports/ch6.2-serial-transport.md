---
type: mina
title: 6.2 - Serial Transport
navPrev: ch6.1-apr-transport.html
navPrevText: 6.1 - APR Transport
navUp: ch6-transports.html
navUpText: Chapter 6 - Transports
navNext: ../ch7-handler/ch7-handler.html
navNextText: Chapter 7 - Handler
---

# 6.2 - Serial Transport

With the MINA 2.0 you are able to connect to serial port like you use to connect to a TCP/IP port with MINA.

## Getting MINA 2.0

You you can download the latest built version (2.0.2).

If you prefer to build the code from the trunk, and need assistance to do so, please consult the Developer Guide.

## Prerequisite

<div class="info" markdown="1">
    <strong>Useful Information</strong><br>
    Before accessing serial port from a Java program you need a native library (.DLL or .so depending of your OS). MINA use the one from RXTX.org : <a href="ftp://ftp.qbang.org/pub/rxtx/rxtx-2.1-7-bins-r2.zip" class="external-link" rel="nofollow">ftp://ftp.qbang.org/pub/rxtx/rxtx-2.1-7-bins-r2.zip</a>. <br>
    Just put the good .dll or .so in the jre/lib/i386/ path of your JDK/JRE or use the &#45;Djava.library.path= argument for specify where you placed the native libraries
</div>

<div class="info" markdown="1">
    <strong>Useful Information</strong><br>
    The <strong>mina-transport-serial</strong> jar is not included in the full distribution. You can download it from <a href="http://repo1.maven.org/maven2/org/apache/mina/mina-transport-serial/2.0.2/" class="external-link" rel="nofollow">here</a>
</div>

## Connecting to a serial port

Serial communication for MINA provide only an IoConnector, due to the point-to-point nature of the communication media.

At this point you are supposed to have already read the MINA tutorial.

Now for connecting to a serial port you need a SerialConnector :

```java
// create your connector
IoConnector connector = new SerialConnector()
connector.setHandler( ... here your buisness logic IoHandler ... );
```

Nothing very different of a SocketConnector.

Let's create an address for connecting to our serial port.

```java
SerialAddress portAddress=new SerialAddress( "/dev/ttyS0", 38400, 8, StopBits.BITS_1, Parity.NONE, FlowControl.NONE );
```

The first parameter is your port identifier. For Windows computer, the serial ports are called "COM1", "COM2", etc... For Linux and some other Unix : "/dev/ttyS0", "/dev/ttyS1", "/dev/ttyUSB0".

The remaining parameters are depending of the device you are driving and the supposed communications characteristics.

* the baud rate
* the data bits
* the parity
* the flow control mechanism

Once it's done, connect the connector to the address :

```java
ConnectFuture future = connector.connect( portAddress );
future.await();
IoSession sessin = future.getSession();
```

And voila ! Everything else is as usual, you can plug your filters and codecs.
for learn more about RS232 : <http://en.wikipedia.org/wiki/RS232>
