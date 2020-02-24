---
type: mina
title: 5.9 - Logging Filter
navPrev: ch5.8-keep-alive-filter.html
navPrevText: 5.8 - KeepAlive Filter
navUp: ch5-filters.html
navUpText: Chapter 5 - Filters
navNext: ch5.10-mdc-injection-filter.html
navNextText: 5.10 - MDC Injection Filter
---

# 5.9 - Logging Filter

The _Logging_ filter allows an application to logs **MINA** protocol events while they are transiting on the filters chain. It can be added dynamically (ie, a session may add a filter whenever it wants).

The tracked events are :

* _exceptionCaught_
* _messageReceived_
* _messageSent_
* _sessionClosed_
* _sessionCreated_
* _sessionIdle_
* _sessionOpened_

The _event_, _filterClose_, _filterWrite_ and _inputClosed_ events are not tracked.

## Adding the filter

This can be done once and for each session, while creating the _IoFilterChainBuilder_ instance :

```java
...
NioSocketAcceptor acceptor = new NioSocketAcceptor();
DefaultIoFilterChainBuilder builderChain = acceptor.getFilterChain();
builderChain.addLast("logger", new LoggingFilter());
...
```

or it can be added dynamically, in a given session:

```java
...
session.getFilterChain().addLast("logger", new LoggingFilter());
...
```

(here, the filter is added at the end of the filter's chain, but it can added at the beginning, using _addFirst_, or before or after a given filter, with _addBefore_ or _addAfter_)

## Configuring the filter

Each event can be configured individually. For instance, to log the _messageReceived_ event in _DEBUG_ mode, simply add this code in  your _IoHandler_ implementation:

```java
...
LoggingFilter loggingFilter = (LoggingFilter)session.getFilterChain().get( LoggingFilter.class );

if (logginFilter != null) {
    loggingFilter.setMessageReceivedLogLevel( LogLevel.DEBUG);
}
...
```

This is per session, and it's dynamic.


## Removing the filter

It's always possible to remove the filter for a given session :

```java
...
session.getFilterChain().remove("logger");
...
```
