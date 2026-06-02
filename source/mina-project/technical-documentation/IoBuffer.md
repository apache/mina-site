---
type: mina
title: IoBuffer
---

# IoBuffer

The *IoBuffer* interface and the implementing classes is a extensible version of the *ByteBuffer* class, with many interesting extensions.

The biggest issue of *ByteBuffer* is that you can't extend it, you have to reallocate a new buffer if you want to put more data into it.
We also wanted to add some useful methods to manipulate the buffer content, mainly getters/setters for some specific values (like enums, strings, prefixed strings, etc.) 

The *IoBuffer* implementations may also be expanded or shrinked.

Otherwise, the method really mimic the *ByteBuffer* API.

There are a few implentations, here is the hierarchy:

```
(Comparable)
     o
     |
[[IoBuffer]]
    ^  ^
    |  |
    |  +--[[AbstractIoBuffer]]
    |         ^     ^     ^
    |         |     |     |
    |         |     |     +--[CachedBuffer]
    |         |     |     
    |         |     +--------[IoBufferImpl]
    |         |
    |         +--------------[SimpleBuffer]
    |
    +-----[IoBufferWrapper]
                  ^
                  |
                  +--[ProxyHandshakeIoBuffer]
```

## Abstract class IoBuffer

This abstract class contains the buffer allocator, and implements a few common methods.

You can allocate a direct buffer, or a heap buffer.

## Abstract class AbstractIoBuffer

## Class CachedBuffer

## Class IoBufferImpl

## Class SimpleBuffer

## Class IoBufferWrapper

## Class ProxyHandshakeIoBuffer