---
type: asyncweb
title: AsyncWeb
slug: index
---

# Apache AsyncWeb

<div class="note" markdown="1" >
The **AsyncWeb** project is currently dormant. We don't have committers for it, so if you feel like you can give an hand, please do contact us !
</div>

Apache AsyncWeb (built on top of the Apache MINA network framework) employs non-blocking selector driven IO at the transport level, and is asynchronous throughout - from the initial parsing of requests, right through to and including the services implemented by users.

Apache AsyncWeb breaks away from the blocking request / response architecture found in today's popular HTTP engines. This allows it to be highly scalable and capable of supporting very high throughput - even in high processing latency scenarios.

A simple API allows new asynchronous services to be created easily - and out-of-the-box Spring integration allows them to be configured simply and with great flexibility. In addition to "endpoint" HTTP services, AsyncWeb also allows configurable "chains" of behaviour - enabling "filter" like behaviour to be applied to all requests. Pluggable "resolvers" map incoming requests to their target HTTP service - and are given access to the entire incoming request - allowing the routing possibilities to be very flexible.


