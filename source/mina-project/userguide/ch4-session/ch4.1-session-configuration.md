---
type: mina
title: 4.1 - Session Configuration
navPrev: ch4-session.html
navPrevText: Chapter 4 - Session
navUp: ch4-session.html
navUpText: Chapter 4 - Session
navNext: ch4.2-session-statistics.html
navNextText: 4.2 - Session Statistics
---

# 4.1 - Session Configuration

Depending on the Session's type, we can configure various elements. Some of those elements are shared across all the session's type, some other are specific.

We currently support 4 session flavors :

* Socket : support for the TCP transport
* Datagram : support for the UDP transport
* Serial : support for the RS232 transport
* VmPipe : support for the IPC transport


## General parameters

Here is the list of all the global parameters (they can be set fo any of the Session flavors) :

| Parameter | type | Description | Default value |
|---|---|---|---|
| idleTimeForBoth | int | The number of seconds to wait before notify a session that is idle on reads and writes | Infinite |
| idleTimeForRead | int | The number of seconds to wait before notify a session that is idle on reads | Infinite |
| idleTimeForWrite | int | The number of seconds to wait before notify a session that is idle on writes | Infinite |
| maxReadBufferSize | int | The maximum size of the buffer used to read incoming data | 65536 bytes |
| minReadBufferSize | int | The minimal size of the buffer used to read incoming data | 64 bytes |
| readBufferSize | int | The default size of the buffer used to read incoming data | 2048 bytes |
| throughputCalculationInterval | int | The interval (seconds) between each throughput calculation. | 3s |
| useReadOperation | boolean | A flag set to TRUE when we allow an application to do a __session.read()_ | FALSE |
| writeTimeout | int | Delay to wait for completion before bailing out a write operation | 60s |

All those parameters can be accessed through the use of getters and setters (the _useReadOperation_ parameter getter is using the _isUseReadOperation()_ method).

## Socket specific parameters

| Parameter | type | Description | Default value |
|---|---|---|---|
| defaultReuseAddress | boolean | The value for the SO_REUSEADDR flag | true |
| keepAlive | boolean | The value for the SO_KEEPALIVE flag | false |
| oobInline | boolean | The value for the SO_OOBINLINE flag | false |
| receiveBufferSize | int | The value for the SO_RCVBUF parameter | -1 |
| reuseAddress | boolean | The value for the SO_REUSEADDR flag | false |
| sendBufferSize | int | The value for the SO_SNDBUF parameter | -1 |
| soLinger | int | The value for the SO_LINGER parameter | -1 |
| tcpNoDelay | boolean | The value for the TCP_NODELAY flag | false |
| trafficClass | int | The value for the IP_TOS parameter. One of IPTOS_LOWCOST(0x02), IPTOS_RELIABILITY(0x04), IPTOS_THROUGHPUT (0x08) or IPTOS_LOWDELAY (0x10) | 0 |

## Datagram specific parameters

| Parameter | type | Description | Default value |
|---|---|---|---|
| broadcast | boolean | The value for the SO_BROADCAST flag | false |
| closeOnPortUnreachable | boolean | Tells if we should close the session if the port is unreachable | true |
| receiveBufferSize | int | The value for the SO_RCVBUF parameter | -1 |
| reuseAddress | boolean | The value for the SO_REUSEADDR flag | false |
| sendBufferSize | int | The value for the SO_SNDBUF parameter | -1 |
| trafficClass | int | The value for the IP_TOS parameter. One of IPTOS_LOWCOST(0x02), IPTOS_RELIABILITY(0x04), IPTOS_THROUGHPUT (0x08) or IPTOS_LOWDELAY (0x10) | 0 |

## Serial specific parameters 

| Parameter | type | Description | Default value |
|---|---|---|---|
| inputBufferSize | int | The input buffer size to use | 8 |
| lowLatency | boolean | Set the Low Latency mode | false |
| outputBufferSize | int | The output buffer size to use | 8 |
| receiveThreshold | int | Set the receive threshold in byte (set it to -1 for disable) | -1 |

