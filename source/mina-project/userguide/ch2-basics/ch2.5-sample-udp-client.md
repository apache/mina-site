---
type: mina
title: 2.5 - Sample UDP Client
navPrev: ch2.4-sample-udp-server.html
navPrevText: 2.4 - Sample UDP Server
navUp: ch2-basics.html
navUpText: Chapter 2 - Basics
navNext: ch2.6-summary.html
navNextText: 2.6 - Summary
---

# 2.5 -Sample UDP Client

Lets look at the client code for the UDP Server from previous section.

To implement the Client we need to do following:

* Create Socket and Connect to Server
* Set the IoHandler
* Collect free memory
* Send the Data to the Server

We will begin by looking at the file [MemMonClient.java](http://mina.apache.org/mina-project/xref/org/apache/mina/example/udp/client/MemMonClient.html), found in the org.apache.mina.example.udp.client java package. The first few lines of the code are simple and straightforward.

```java
connector = new NioDatagramConnector();
connector.setHandler( this );
ConnectFuture connFuture = connector.connect( new InetSocketAddress("localhost", MemoryMonitor.PORT ));
```

Here we create a NioDatagramConnector, set the handler and connect to the server. One gotcha I ran into was that you must set the host in the InetSocketAddress object or else nothing seems to work. This example was mostly written and tested on a Windows XP machine, so things may be different elsewhere. Next we will wait for acknowledgment that the client has connected to the server. Once we know we are connected, we can start writing data to the server. Here is that code:

```java
connFuture.addListener( new IoFutureListener(){
            public void operationComplete(IoFuture future) {
                ConnectFuture connFuture = (ConnectFuture)future;
                if( connFuture.isConnected() ){
                    session = future.getSession();
                    try {
                        sendData();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                } else {
                    log.error("Not connected...exiting");
                }
            }
        });
```

Here we add a listener to the ConnectFuture object and when we receive a callback that the client has connected, we will start to write data. The writing of data to the server will be handled by a method called sendData. This method is shown below:

```java
private void sendData() throws InterruptedException {
    for (int i = 0; i < 30; i++) {
        long free = Runtime.getRuntime().freeMemory();
        IoBuffer buffer = IoBuffer.allocate(8);
        buffer.putLong(free);
        buffer.flip();
        session.write(buffer);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
            throw new InterruptedException(e.getMessage());
        }
    }
}
```

This method will write the amount of free memory to the server once a second for 30 seconds. Here you can see that we allocate a IoBuffer large enough to hold a long variable and then place the amount of free memory in the buffer. This buffer is then flipped and written to the server.

Our UDP Client implementation is complete.
