---
type: mina
title: Message flow
---

# Message flow

When a selector receives some _OP_READ_ event, the associated _IoProcessor_ is awaken and starts to process this event. It all starts with reading the channel, then pushing the read data through the filter chain down to the _IoHandler_ (aka, the application). If the application decides to write back a response, it goes through the chain again, andultimately the data to be pushed into the channel is pushed into a queue (_writeRequestQueue), then the stack is unfolled, down to the _IoProcessor_, which pops the data from the queue and writes it into the channel.

Here is the representation of such a flow, where the _SslFilter_ has been included (we will come back to it later)

```text
                   +-------------------+
                   |     IoAcceptor    |
                   |    +---------+    |
                   |    | Select  |    |
                   |    +----+----+    |
                   |         |         |
                   +---------+---------+
                             .                                           flush/
+---------+                  .                  +---------+              wakeup
| Channel <-----read------+  .  +-----write-----> Channel |              +----+
+---------+               |  |  |               +---------+              |    |
                      +---+--v--+---+                               +----v----+---+
                      |             |       writeRequestQueue       |             |
                      | IoProcessor |       +-+-+-+-+-+-+-+-+       | IoProcessor |
                      |             <- pop -+ | | | | | | | <- put- |             |
                      +---+-----^---+       +-+-+-+-+-+-+-+-+       +---------^---+
                          |     .                                       .     |
      fireMessageReceived |     .                                       .     | write
                          |     .                                       .     |
                      +---v---------+                               +---v-----+---+
                      | HeadFilter  |                               | HeadFilter  <---------------filterWrite---------------+
                      +---+-----^---+                               +-------------+                                         |
                          |     .                                       .                                             +-----+------+
          MessageReceived |     .                                       .      +----------flushScheduledEvents--------> SslHandler |
                          |     .                                       .      |                                      +-----+------+
                      +---v---------+                               +---v------+--+                                         |
                      | SslFilter   |                               | SslFilter   +----put----+                             |
                      +---+-----^---+                               +---------^---+           |                             |
                          |     .                                       .     |               |  filterWriteQueue           |
          MessageReceived |     .                                       .     | filterWrite   |  +-+-+-+-+-+-+-+-+          |
                          |     .                                       .     |               +--> | | | | | | | <----pop---+
                      +---v---------+                               +---v---------+              +-+-+-+-+-+-+-+-+
                      | <filters>   |                               | <filters>   |
                      +---+-----v---+                               +-------------+
                          |     .                                       .     |
          MessageReceived |     .                                       .     | filterWrite
                          |     .                                       .     |
                      +---v---------+                               +---v-----+---+
                      | TailFilter  |                               | TailFilter  |
                      +---+-----^---+                               +---------^---+
                          |     .                                       .     |
          MessageReceived |     .                                       .     | fireFilterWrite
                          |     .                                       .     |
                      +---v---------+                                   .     |
                      | IoHandler   |                                   .     |
                      +---+-----^---+                                   .     |
                          |     .                                       .     |
                          |     .........................................     |
                          |                                                   |
                          +-------------------sessionWrite--------------------+
```

For instance, if we consider an application which filter chain contains the _MdcInjectionFilter_, _SslFilter_, _CompressionFilter_, _ProtocolCodecFilter_, _LoggingFilter_, we end uo with a stack of 77 calls, which needs to be emptied before the response can eventually be written. Here is the stack (in reverse order, the latest call on top of it):

```text
NioProcessor(AbstractPollingIoProcessor<S>).flush(S) line: 449  
NioProcessor(AbstractPollingIoProcessor<S>).write(S, WriteRequest) line: 436  
NioProcessor(AbstractPollingIoProcessor<S>).write(IoSession, WriteRequest) line: 68 
SimpleIoProcessorPool<S>.write(S, WriteRequest) line: 278 
SimpleIoProcessorPool<S>.write(IoSession, WriteRequest) line: 80  
DefaultIoFilterChain$HeadFilter.filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 914 
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.access$1500(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, WriteRequest) line: 49 
DefaultIoFilterChain$EntryImpl$1.filterWrite(IoSession, WriteRequest) line: 1146  
IoFilterEvent.fire() line: 131  
MdcInjectionFilter.filter(IoFilterEvent) line: 162  
MdcInjectionFilter(CommonEventFilter).filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 68  
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.access$1500(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, WriteRequest) line: 49 
DefaultIoFilterChain$EntryImpl$1.filterWrite(IoSession, WriteRequest) line: 1146  
SslHandler.flushScheduledEvents() line: 330 
SslFilter.filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 671 
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.access$1500(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, WriteRequest) line: 49 
DefaultIoFilterChain$EntryImpl$1.filterWrite(IoSession, WriteRequest) line: 1146  
CompressionFilter.filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 152 
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.access$1500(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, WriteRequest) line: 49 
DefaultIoFilterChain$EntryImpl$1.filterWrite(IoSession, WriteRequest) line: 1146  
ProtocolCodecFilter.filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 340 
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.access$1500(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, WriteRequest) line: 49 
DefaultIoFilterChain$EntryImpl$1.filterWrite(IoSession, WriteRequest) line: 1146  
LoggingFilter(IoFilterAdapter).filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 138  
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.access$1500(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, WriteRequest) line: 49 
DefaultIoFilterChain$EntryImpl$1.filterWrite(IoSession, WriteRequest) line: 1146  
DefaultIoFilterChain$TailFilter(IoFilterAdapter).filterWrite(IoFilter$NextFilter, IoSession, WriteRequest) line: 138  
DefaultIoFilterChain.callPreviousFilterWrite(IoFilterChain$Entry, IoSession, WriteRequest) line: 753  
DefaultIoFilterChain.fireFilterWrite(WriteRequest) line: 746  
NioSocketSession(AbstractIoSession).write(Object, SocketAddress) line: 570  
NioSocketSession(AbstractIoSession).write(Object) line: 515 
ChatProtocolHandler.messageReceived(IoSession, Object) line: 106  
DefaultIoFilterChain$TailFilter.messageReceived(IoFilter$NextFilter, IoSession, Object) line: 1015  
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.access$1300(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, Object) line: 49 
DefaultIoFilterChain$EntryImpl$1.messageReceived(IoSession, Object) line: 1128  
LoggingFilter.messageReceived(IoFilter$NextFilter, IoSession, Object) line: 208 
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.access$1300(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, Object) line: 49 
DefaultIoFilterChain$EntryImpl$1.messageReceived(IoSession, Object) line: 1128  
ProtocolCodecFilter$ProtocolDecoderOutputImpl.flush(IoFilter$NextFilter, IoSession) line: 413 
ProtocolCodecFilter.messageReceived(IoFilter$NextFilter, IoSession, Object) line: 257 
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.access$1300(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, Object) line: 49 
DefaultIoFilterChain$EntryImpl$1.messageReceived(IoSession, Object) line: 1128  
CompressionFilter.messageReceived(IoFilter$NextFilter, IoSession, Object) line: 169 
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.access$1300(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, Object) line: 49 
DefaultIoFilterChain$EntryImpl$1.messageReceived(IoSession, Object) line: 1128  
SslHandler.flushScheduledEvents() line: 335 
SslFilter.messageReceived(IoFilter$NextFilter, IoSession, Object) line: 553 
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.access$1300(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, Object) line: 49 
DefaultIoFilterChain$EntryImpl$1.messageReceived(IoSession, Object) line: 1128  
IoFilterEvent.fire() line: 105  
MdcInjectionFilter.filter(IoFilterEvent) line: 162  
MdcInjectionFilter(CommonEventFilter).messageReceived(IoFilter$NextFilter, IoSession, Object) line: 84  
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.access$1300(DefaultIoFilterChain, IoFilterChain$Entry, IoSession, Object) line: 49 
DefaultIoFilterChain$EntryImpl$1.messageReceived(IoSession, Object) line: 1128  
DefaultIoFilterChain$HeadFilter(IoFilterAdapter).messageReceived(IoFilter$NextFilter, IoSession, Object) line: 122  
DefaultIoFilterChain.callNextMessageReceived(IoFilterChain$Entry, IoSession, Object) line: 650  
DefaultIoFilterChain.fireMessageReceived(Object) line: 643  
NioProcessor(AbstractPollingIoProcessor<S>).read(S) line: 539 
AbstractPollingIoProcessor<S>.access$1200(AbstractPollingIoProcessor, AbstractIoSession) line: 68 
AbstractPollingIoProcessor$Processor.process(S) line: 1223  
AbstractPollingIoProcessor$Processor.process() line: 1212 
AbstractPollingIoProcessor$Processor.run() line: 683  
NamePreservingRunnable.run() line: 64 
ThreadPoolExecutor.runWorker(ThreadPoolExecutor$Worker) line: 1149  
ThreadPoolExecutor$Worker.run() line: 624 
Thread.run() line: 748  
```

Writing the data is done when we are back in the AbstractPollingIoProcessor$Processor.run() call. Here is the stack for that action :

```text
NioProcessor.write(NioSession, IoBuffer, int) line: 384 
NioProcessor.write(AbstractIoSession, IoBuffer, int) line: 47 
AbstractPollingIoProcessor$Processor.writeBuffer(S, WriteRequest, boolean, int, long) line: 1107  
AbstractPollingIoProcessor$Processor.flushNow(S, long) line: 994  
AbstractPollingIoProcessor$Processor.flush(long) line: 921  
AbstractPollingIoProcessor$Processor.run() line: 688  
NamePreservingRunnable.run() line: 64 
ThreadPoolExecutor.runWorker(ThreadPoolExecutor$Worker) line: 1149  
ThreadPoolExecutor$Worker.run() line: 624 
Thread.run() line: 748  
```

## The SslFilter implementation

As we can see,the _SslFilter_ never calls the next filter. It delegates that to the _SslHandler_ class. The trick is that it uses a queue to store encrypted messages, which will wait until the message is fully encrypted before flushing them. The rational is that a message can be pretty big, and teh **SSL/TLS** protocol just allows limited encrypted data blocks (around 16k), so it keeps each block of encrypted data into the queue temporarily.


# Room for improvements


## Reducing the stack size

This is clearly sub-optimal. First of all, the stack is crazy big, there is no reason for that. The idea was initially to allow a session to dynamically update the chain, by adding or removing a filter while a session is active. This is a fine idea, as some protocols need to do that: typically, LDAP allows a user to send a _startTls_ extended request which tells the server to establish a secured communication. In this very case, we add the _SslFilter_ in the session's filter chain.

Now, we can do that more efficiently. A session's filter chain is created when the session itself is created. Adding a new filter in this chain is done by the application, and at this point, no other thread uses this session (each session is associated with one single _IoProcessor_ instance's thread), unless an _ExecutorFilter_ has been added to the chain. In this case, things get complicated... Having an _ExecutorFilter_ in the chain means any event can be processed concurrently, in different threads. Although they are sharing the same filter chain. We have to protect this chain against concurrent modifications, and we must also guarantee that any change made in the chain will not be an issue for the application.
Typically, adding a _SslFilter_ in a chain while a message is being written is problematic: 
* we have to wait for any pending messages to be sent to the remote peer, which may have already initiated a handshake (although it's the client responsibility to handle this situation), or we decide to ditch any of those messages (the right thing to do, IMHO)
* we have to deal with any message that are somewhere in the chain before the _SslFilter_. Again, the strategy would be to discard them
* and we have to deal with any message somewhere in the chain after the _SslFilter_ and before they are pushed into the session write queue, for the exact same reason.

For messages received *before* the addition of the _SslFilter_, but still in the chain, we should ditch them for the exact same reason.

Bottom line, this is a application issue, and should be handled by the application, because **MINA** can't deal with all the possible. starties in place of the application.

That being said, we can use the _IoProcessor_ as a controller. It would be its responsibility to propagate events from one filter to the other, using such a loop:

```
for each filter in the chain 
  do
    propagate the event to the filter with the previous result
    store the result 
  done
```

What we call the 'result' is just the transformed data. Typically, when calling the _ProtocolCodecFilter.messageReceived_ event, the result will be the decoded message, not the _IoBuffer_ (or whatever) input. This will be passed to the next filter (remember that the _IoFilter.messageReceived_ method takes an _Object_ as a parameter).