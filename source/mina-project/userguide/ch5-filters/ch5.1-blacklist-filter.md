---
type: mina
title: 5.1 - Blacklist Filter
navPrev: ch5-filters.html
navPrevText: Chapter 5 - Filters
navUp: ch5-filters.html
navUpText: Chapter 5 - Filters
navNext: ch5.2-buffered-write-filter.html
navNextText: 5.2 - Buffered Write Filter
---

# 5.1 - Blacklist Filter

This filter blocks connections from blacklisted remote addresses. One can block _Addresses_ or _Subnets_. In any case, when an event happens on a blocked session, the session will simply be closed. Here are the events this filter handles :

* _event_ (MINA 2.1)
* _messageReceived_
* _messageSent_
* _sessionCreated_
* _sessionIdle_
* _sessionOpened_

There is no need to handle any other event.

## Blocking an address

Any address or subnet can be blocked live, ie it does not matter if a session is already active or not, this dynamically activated. 
It's enough to add the filter in the chain, and to set (or unset) the addresses to block:

```java
...
BlacklistFilter blackList = new BlacklistFilter();
blackList.block(InetAddress.getByName("1.2.3.4"));
acceptor.getFilterChain().addLast("blacklist", new BlacklistFilter());
...
```

Here, the "1.2.3.4" address will be blocked. 

## Unblocking an address

It's possible to unblock an address, it's just a matter of fetching the filter and remove a previously blocked address:

```java
...
BlacklistFilter blackList = (BlacklistFilter)session.getFilterChain().get(BlacklistFilter.class);
blackList.unblock(InetAddress.getByName("1.2.3.4"));
...
```

Here, the "1.2.3.4" address will be unblocked. 

## Performances

Currently, the implementation is not really optimal... We use a _List_ to store the blocked addresses/subnet, so the more of them you have in the list the longer it will take to process any event.
