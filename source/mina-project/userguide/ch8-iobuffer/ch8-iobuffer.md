---
type: mina
title: Chapter 8 - IoBuffer
navPrev: ../ch7-handler/ch7-handler.html
navPrevText: Chapter 7 - IoHandler
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch9-codec-filter/ch9-codec-filter.html
navNextText: Chapter 9 - Codec Filter
---

# Chapter 8 - IoBuffer

A byte buffer used by MINA applications.

This is a replacement for [ByteBuffer](http://java.sun.com/j2se/1.5.0/docs/api/java/nio/ByteBuffer.html). MINA does not use NIO ByteBuffer directly for two reasons:

* It doesn't provide useful getters and putters such as fill, get/putString, and get/putAsciiInt() .
* It is difficult to write variable-length data due to its fixed capacity

<div class="note" markdown="1">
    This will change in MINA 3. The main reason why MINA has its own wrapper on top of nio ByteBuffer is to have extensible buffers. This was a very bad decision. Buffers are just buffers : a temporary place to store temporary data, before it is used. Many other solutions exist, like defining a wrapper which relies on a list of NIO ByteBuffers, instead of copying the existing buffer to a bigger one just because we want to extend the buffer capacity.
    <p>It might also be more comfortable to use an InputStream instead of a byte buffer all along the filters, as it does not imply anything about the nature of the stored data : it can be a byte array, strings, messages...</p>
    <p>Last, not least, the current implementation defeat one of the target : zero-copy strategy (ie, once we have read the data from the socket, we want to avoid a copy being done later). As we use extensible byte buffers, we will most certainly copy those data if we have to manage big messages. Assuming that the MINA ByteBuffer is just a wrapper on top of NIO ByteBuffer, this can be a real problem when using direct buffers.</p>
</div>

## IoBuffer Operations

### Allocating a new Buffer

IoBuffer is an abstract class, hence can't be instantiated directly. To allocate IoBuffer, we need to use one of the two allocate() methods.

```java
// Allocates a new buffer with a specific size, defining its type (direct or heap)
public static IoBuffer allocate(int capacity, boolean direct)

// Allocates a new buffer with a specific size
public static IoBuffer allocate(int capacity)
```

The allocate() method takes one or two arguments. The first form takes two arguments :

* __capacity__ - the capacity of the buffer
* __direct__ - type of buffer. true to get direct buffer, false to get heap buffer

The default buffer allocation is handled by [SimpleBufferAllocator](http://mina.apache.org/mina-project/xref/org/apache/mina/core/buffer/SimpleBufferAllocator.html)

Alternatively, following form can also be used

```java
// Allocates heap buffer by default.
IoBuffer.setUseDirectBuffer(false);

// A new heap buffer is returned.
IoBuffer buf = IoBuffer.allocate(1024);
```

When using the second form, don't forget to set the default buffer type before, otherwise you will get Heap buffers by default.

## Creating Auto Expanding Buffer

Creating auto expanding buffer is not very easy with java NIO API's, because of the fixed size of the buffers. Having a buffer, that can auto expand on needs is a big plus for networking applications. To address this, IoBuffer has introduced the autoExpand property. It automatically expands its capacity and limit value.

Lets see how to create an auto expanding buffer :

```java
IoBuffer buffer = IoBuffer.allocate(8);
buffer.setAutoExpand(true);
buffer.putString("12345678", encoder);

// Add more to this buffer
buffer.put((byte)10);
```

The underlying ByteBuffer is reallocated by IoBuffer behind the scene if the encoded data is larger than 8 bytes in the example above. Its capacity will double, and its limit will increase to the last position the string is written. This behavior is very similar to the way StringBuffer class works.

<div class="note" markdown="1">
    This mechanism is very likely to be removed from MINA 3.0, as it's not really the best way to handle increased buffer size. It should be replaced by something like a InputStream hiding a list or an array of fixed sized ByteBuffers.
</div>

## Creating Auto Shrinking Buffer

There are situations which calls for releasing additionally allocated bytes from the buffer, to preserve memory. IoBuffer provides autoShrink property to address the need.  If autoShrink is turned on, IoBuffer halves the capacity of the buffer when compact() is invoked and only 1/4 or less of the current capacity is being used. To manually shrink the buffer, use shrink() method.

Lets see this in action :

```java
IoBuffer buffer = IoBuffer.allocate(16);
buffer.setAutoShrink(true);
buffer.put((byte)1);
System.out.println("Initial Buffer capacity = "+buffer.capacity());

buffer.shrink();
System.out.println("Initial Buffer capacity after shrink = "+buffer.capacity());

buffer.capacity(32);
System.out.println("Buffer capacity after incrementing capacity to 32 = "+buffer.capacity());

buffer.shrink();
System.out.println("Buffer capacity after shrink= "+buffer.capacity());
```

We have initially allocated a capacity as 16, and set the autoShrink property as true.

Lets see the output of this :

```java
Initial Buffer capacity = 16
Initial Buffer capacity after shrink = 16
Buffer capacity after incrementing capacity to 32 = 32
Buffer capacity after shrink= 16
```

Lets take a break and analyze the output

* Initial buffer capacity is 16, as we created the buffer with this capacity. Internally this becomes the minimum capacity of the buffer
* After calling shrink(), the capacity remains 16, as capacity shall never be less than minimum capacity
* After incrementing capacity to 32, the capacity becomes 32
* Call to shrink(), reduces the capacity to 16, thereby eliminating extra storage

<div class="note" markdown="1">
    Again, this mechanism should be a default one, without needing to explicitely tells the buffer that it can shrink.
</div>

## Buffer Allocation

IoBufferAllocator is responsible for allocating and managing buffers. To have precise control on the buffer allocation policy, implement the IoBufferAllocator interface.

MINA ships with following implementations of IoBufferAllocator

* __SimpleBufferAllocator (default)__ - Create a new buffer every time
* __CachedBufferAllocator__ - caches the buffer which are likely to be reused during expansion

<div class="note" markdown="1">
    With the new available JVM, using cached IoBuffer is very unlikely to improve performances.
</div>

You can implement you own implementation of IoBufferAllocator and call setAllocator() on IoBuffer to use the same.
