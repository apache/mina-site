---
type: mina
title: Chapter 5 - Filters
navPrev: ../ch4-session/ch4-session.html
navPrevText: Chapter 4 - Session
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch6-transports/ch6-transports.html
navNextText: Chapter 6 - Transports
---

# Chapter 5 - Filters

* [5.1 - Blacklist Filter](ch5.1-blacklist-filter.html)
* [5.2 - Buffered Write Filter](ch5.2-buffered-write-filter.html)
* [5.3 - Compression Filter](ch5.3-compression-filter.html)
* [5.4 - Connection Throttle Filter](ch5.4-connection-throttle-filter.html)
* [5.5 - Error Generating Filter](ch5.5-error-generating-filter.html)
* [5.6 - Executor Filter](ch5.6-executor-filter.html)
* [5.7 - FileRegion Write Filter](ch5.7-file-region-write-filter.html)
* [5.8 - KeepAlive Filter](ch5.8-keep-alive-filter.html)
* [5.9 - Logging Filter](ch5.9-logging-filter.html)
* [5.10 - MDC Injection Filter](ch5.10-mdc-injection-filter.html)
* [5.11 - NOOP Filter](ch5.11-noop-filter.html)
* [5.12 - Profiler Filter](ch5.12-profiler-filter.html)
* [5.13 - Protocol Codec Filter](ch5.13-protocol-codec-filter.html)
* [5.14 - Proxy Filter](ch5.14-proxy-filter.html)
* [5.15 - Reference Counting Filter](ch5.15-reference-counting-filter.html)
* [5.16 - Request/Response Filter](ch5.16-request-response-filter.html)
* [5.17 - Session Attribute Initializing Filter](ch5.17-session-attribute-initializing-filter.html)
* [5.18 - Stream Write Filter](ch5.18-stream-write-filter.html)
* [5.19 - SSL/TLS Filter](ch5.19-ssl-filter.html)
* [5.20 - Write Request Filter](ch5.20-write-request-filter.html)

## Introduction

IoFilter is one of the MINA core constructs that serves a very important role. It filters all I/O events and requests between IoService and IoHandler. If you have an experience with web application programming, you can safely think that it's a cousin of Servlet filter. Many out-of-the-box filters are provided to accelerate network application development pace by simplifying typical cross-cutting concerns using the out-of-the-box filters such as:

* LoggingFilter logs all events and requests.
* ProtocolCodecFilter converts an incoming ByteBuffer into message POJO and vice versa.
* CompressionFilter compresses all data.
* SSLFilter adds SSL - TLS - StartTLS support.
* and many more!

In this tutorial, we will walk through how to implement an IoFilter for a real world use case. It's easy to implement an IoFilter in general, but you might also need to know specifics of MINA internals. Any related internal properties will be explained here.

{{% toc %}}

## Filters already present

We have many filters already written. The following table list all the existing filters, with a short description of their usage.

| Filter | class | Description |
|---|---|---|
| Blacklist | [BlacklistFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/firewall/BlacklistFilter.html) | Blocks connections from blacklisted remote addresses<br class="atl-forced-newline"> |
| Buffered Write | [BufferedWriteFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/buffer/BufferedWriteFilter.html) | Buffers outgoing requests like the BufferedOutputStream does |
| Compression | [CompressionFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/compression/CompressionFilter.html) | &nbsp; |
| ConnectionThrottle | [ConnectionThrottleFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/firewall/ConnectionThrottleFilter.html) | &nbsp; |
| ErrorGenerating | [ErrorGeneratingFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/errorgenerating/ErrorGeneratingFilter.html) | &nbsp; |
| Executor | [ExecutorFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/executor/ExecutorFilter.html) | &nbsp; |
| FileRegionWrite | [FileRegionWriteFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/stream/FileRegionWriteFilter.html) | &nbsp; |
| KeepAlive | [KeepAliveFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/keepalive/KeepAliveFilter.html) | &nbsp; |
| Logging | [LoggingFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/logging/LoggingFilter.html) | Logs event messages, like MessageReceived, MessageSent, SessionOpened, ... |
| MDC Injection | [MdcInjectionFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/logging/MdcInjectionFilter.html) | Inject key IoSession properties into the MDC |
| Noop | [NoopFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/util/NoopFilter.html) | A filter that does nothing. Useful for tests. |
| Profiler | [ProfilerTimerFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/statistic/ProfilerTimerFilter.html) | Profile event messages, like MessageReceived, MessageSent, SessionOpened, ... |
| ProtocolCodec | [ProtocolCodecFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/codec/ProtocolCodecFilter.html) | A filter in charge of encoding and decoding messages |
| Proxy | [ProxyFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/proxy/filter/ProxyFilter.html) | &nbsp; |
| Reference counting | [ReferenceCountingFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/util/ReferenceCountingFilter.html) | Keeps track of the number of usages of this filter |
| RequestResponse | [RequestResponseFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/reqres/RequestResponseFilter.html) | &nbsp; |
| SessionAttributeInitializing | [SessionAttributeInitializingFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/util/SessionAttributeInitializingFilter.html) | &nbsp; |
| StreamWrite | [StreamWriteFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/stream/StreamWriteFilter.html) | &nbsp; |
| SslFilter | [SslFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/ssl/SslFilter.html) | &nbsp; |
| WriteRequest | [WriteRequestFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/util/WriteRequestFilter.html) | &nbsp; |

## Overriding Events Selectively

You can extend IoAdapter instead of implementing IoFilter directly. Unless overridden, any received events will be forward to the next filter immediately:

```java
public class MyFilter extends IoFilterAdapter {
    @Override
    public void sessionOpened(NextFilter nextFilter, IoSession session) throws Exception {
        // Some logic here...
        nextFilter.sessionOpened(session);
        // Some other logic here...
    }
}
```

## Transforming a Write Request

If you are going to transform an incoming write request via IoSession.write(), things can get pretty tricky. For example, let's assume your filter transforms HighLevelMessage to LowLevelMessage when IoSession.write() is invoked with a HighLevelMessage object. You could insert appropriate transformation code to your filter's filterWrite() method and think that's all. However, you have to note that you also need to take care of messageSent event because an IoHandler or any filters next to yours will expect messageSent() method is called with HighLevelMessage as a parameter, because it's irrational for the caller to get notified that LowLevelMessage is sent when the caller actually wrote HighLevelMessage. Consequently, you have to implement both filterWrite() and messageSent() if your filter performs transformation.

Please also note that you still need to implement similar mechanism even if the types of the input object and the output object are identical (e.g. CompressionFilter) because the caller of IoSession.write() will expect exactly what he wrote in his or her messageSent() handler method.

Let's assume that you are implementing a filter that transforms a String into a char[]. Your filter's filterWrite() will look like the following:

```java
public void filterWrite(NextFilter nextFilter, IoSession session, WriteRequest request) {
    nextFilter.filterWrite(
        session, new DefaultWriteRequest(
                ((String) request.getMessage()).toCharArray(), request.getFuture(), request.getDestination()));
}
```

Now, we need to do the reverse in messageSent():

```java
public void messageSent(NextFilter nextFilter, IoSession session, Object message) {
    nextFilter.messageSent(session, new String((char[]) message));
}
```

What about String-to-ByteBuffer transformation? We can be a little bit more efficient because we don't need to reconstruct the original message (String). However, it's somewhat more complex than the previous example:

```java
public void filterWrite(NextFilter nextFilter, IoSession session, WriteRequest request) {
    String m = (String) request.getMessage();
    ByteBuffer newBuffer = new MyByteBuffer(m, ByteBuffer.wrap(m.getBytes());
    
    nextFilter.filterWrite(
            session, new WriteRequest(newBuffer, request.getFuture(), request.getDestination()));
}
        
public void messageSent(NextFilter nextFilter, IoSession session, Object message) {
    if (message instanceof MyByteBuffer) {
        nextFilter.messageSent(session, ((MyByteBuffer) message).originalValue);
    } else {
        nextFilter.messageSent(session, message);
    }
}

private static class MyByteBuffer extends ByteBufferProxy {
    private final Object originalValue;
    private MyByteBuffer(Object originalValue, ByteBuffer encodedValue) {
        super(encodedValue);
        this.originalValue = originalValue;
    }
}
```

If you are using MINA 2.0, it will be somewhat different from 1.0 and 1.1. Please refer to [CompressionFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/compression/CompressionFilter.html) and [RequestResponseFilter](http://mina.apache.org/mina-project/xref/org/apache/mina/filter/reqres/RequestResponseFilter.html) meanwhile.

## Be Careful When Filtering sessionCreated Event

sessionCreated is a special event that must be executed in the I/O processor thread (see Configuring Thread Model). Never forward sessionCreated event to the other thread.

```java
public void sessionCreated(NextFilter nextFilter, IoSession session) throws Exception {
    // ...
    nextFilter.sessionCreated(session);
}

// DON'T DO THIS!
public void sessionCreated(final NextFilter nextFilter, final IoSession session) throws Exception {
    Executor executor = ...;
    executor.execute(new Runnable() {
        nextFilter.sessionCreated(session);
        });
    }
```

## Watch out the Empty Buffers!

MINA uses an empty buffer as an internal signal at a couple of cases. Empty buffers sometimes become a problem because it's a cause of various exceptions such as IndexOutOfBoundsException. This section explains how to avoid such a unexpected situation.

ProtocolCodecFilter uses an empty buffer (i.e. buf.hasRemaining() = 0) to mark the end of the message. If your filter is placed before the ProtocolCodecFilter, please make sure your filter forward the empty buffer to the next filter if your filter implementation can throw a unexpected exception if the buffer is empty:

```java
public void messageSent(NextFilter nextFilter, IoSession session, Object message) {
    if (message instanceof ByteBuffer && !((ByteBuffer) message).hasRemaining()) {
        nextFilter.messageSent(nextFilter, session, message);
        return;
    }
    ...
}

public void filterWrite(NextFilter nextFilter, IoSession session, WriteRequest request) {
    Object message = request.getMessage();
    if (message instanceof ByteBuffer && !((ByteBuffer) message).hasRemaining()) {
        nextFilter.filterWrite(nextFilter, session, request);
        return;
    }
    ...
}
```

Do we always have to insert the if block for every filters? Fortunately, you don't have to. Here's the golden rule of handling empty buffers:

* If your filter works without any problem even if the buffer is empty, you don't need to add the if blocks at all.
* If your filter is placed after ProtocolCodecFilter, you don't need to add the if blocks at all.
* Otherwise, you need the if blocks.

If you need the if blocks, please remember you don't always need to follow the example above. You can check if the buffer is empty wherever you want as long as your filter doesn't throw a unexpected exception.
