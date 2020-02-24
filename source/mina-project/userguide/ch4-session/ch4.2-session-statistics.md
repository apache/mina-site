---
type: mina
title: 4.2 - Session Statistics
navPrev: ch4.1-session-configuration.html
navPrevText: 4.1 - Session Configuration
navUp: ch4-session.html
navUpText: Chapter 4 - Session
navNext: ../ch5-filters/ch5-filters.html
navNextText: Chapter 5 - Filters
---

# 4.2 - Session Statistics

We keep some statistics in each sessions about what's going on. Not all those statistics are computed fr every message though : some of them are computed on demand.

| Parameter | type | Description | automatic |
|---|---|---|---|
| readBytes | long | The total number of bytes read since the session was created | yes |
| readBytesThroughput | double | The number of bytes read per second in the last interval | no |
| readMessages | long | The total number of messages read since the session was created | yes |
| readMessagesThroughput | double | The number of messages read per second in the last interval | no |
| scheduledWriteBytes | AtomicInteger | The number of bytes waiting to be written | yes |
| scheduledWriteMessages | AtomicInteger | The number of messages waiting to be written | yes |
| writtenBytes | long | The total number of bytes written since the session was created | yes |
| writtenBytesThroughput | double | The number of bytes written per second in the last interval | no |
| writtenMessages | long | The total number of messages written since the session was created | yes |
| writtenMessagesThroughput | double | The number of messages written per second in the last interval | no |

All those parameters can be read using getters.