---
type: mina
title: Chapter 7 - Handler
navPrev: ../ch6-transports/ch6-transports.html
navPrevText: Chapter 6 - Transports
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch8-iobuffer/ch8-iobuffer.html
navNextText: Chapter 8 - IoBuffer
---

# Chapter 7 - Handler

Handles all I/O events fired by MINA. The interface is hub of all activities done at the end of the Filter Chain.

IoHandler has following functions

* sessionCreated
* sessionOpened
* sessionClosed
* sessionIdle
* exceptionCaught
* messageReceived
* messageSent

## sessionCreated Event

Session Created event is fired when a new connection is created. For TCP its the result of connection accept, and for UDP this is generated when a UDP packet is received. This function can be used to initialize session attributes, and perform one time activities for a particular connection.

This function is invoked from the I/O processor thread context, hence should be implemented in a way that it consumes minimal amount of time, as the same thread handles multiple sessions.

## sessionOpened Event

Session opened event is invoked when a connection is opened. Its is always called after sessionCreated event. If a thread model is configured, this function is called in a thread other than the I/O processor thread.

## sessionClosed Event

Session Closed event is closed, when a session is closed. Session cleaning activities like cash cleanup can be performed here.

## sessionIdle Event

Session Idle event is fired when a session becomes idle. This function is not invoked for UDP transport.

## exceptionCaught Event

This functions is called, when an Exception is thrown by user code or by MINA. The connection is closed, if its an IOException.

## messageReceived Event

Message Received event is fired whenever a message is received. This is where the most of the processing of an application happens. You need to take care of all the message type you expect here.

## messageSent Event

Message Sent event is fired, whenever a message aka response has been sent(calling IoSession.write()).
