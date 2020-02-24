---
type: mina
title: Performance Test Reports
---

# Before You Read the Performance Test Reports...

This page exhibits the performance test results under various conditions (e.g. various protocols and system environments).  Please [contact us|Mailing Lists] if you have any specific performance test results to publish for your MINA-based application.

<div class="note" markdown="1">
The following performance test results may have critical flaws in test design or contain wrong values.  Please regard these reports as just a hint for understanding general performance characteristics of Apache MINA.  Additionally, these reports are not meant to claim that Apache MINA outperforms a certain product purposely{note}
</div>

## Apache MINA 2.0.0-M1-SNAPSHOT + AsyncWeb 0.9.0-SNAPSHOT

[Trustin Lee](http://gleamynode.net/) ran a HTTP performance test with the latest snapshot of Apache MINA and [AsyncWeb](https://svn.apache.org/repos/asf/mina/asyncweb/trunk/) combo, using [the AsyncWeb lightweight HTTP server example](https://svn.apache.org/repos/asf/mina/asyncweb/trunk/examples/src/main/java/org/apache/asyncweb/examples/lightweight/).  

* Protocol
    * HTTP
    * Tested keep-alive mode using [ApacheBench](http://en.wikipedia.org/wiki/ApacheBench). 
    * Content length: 128 (excluding the header)
* Client
    * Pentium 4 3GHz
    * Ubuntu Linux 6.10
* Server
    * 2 dual-core Opterons (4 cores, 270 Italy)
    * Gentoo Linux 2.6.18-r6 x86_64
* Network
    * 100Mbit Ethernet  (direct link)
* JVM
    * Sun Java HotSpot(TM) 64-Bit Server VM (build 1.6.0-b105, mixed mode)
    * {{-server -Xms512m -Xmx512m -Xss128k -XX:+AggressiveOpts -XX:+UseParallelGC -XX:+UseBiasedLocking -XX:NewSize=64m}}

To show the performance characteristics of Apache MINA doesn't differ with the production-ready Web servers, the same test has been run on [the Apache HTTPD 2.0.58|http://httpd.apache.org/].  Because I don't know how to write an Apache HTTPD module, I simply used a dummy static file.  Because the amount of the response header two HTTP servers generate is different, I changed the AsyncWeb to generate more traffic in the content.  The size of one response was about 405 bytes.

<center>
![Asyncweb performances](/assets/img/AsyncWeb-0.9.0-SNAPSHOT.png)
</center>

The client machine in my company doesn't have 1Gbps Ethernet adapter nor a gigabit-capable CPU, I was not able to increase the content size.  I made sure the network didn't saturate while the test at least.
