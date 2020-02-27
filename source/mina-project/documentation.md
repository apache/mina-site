---
type: mina
title: Documentation
---

# Documentation

<div class="note" markdown="1">
    The MINA 2.0 User Guide can be found here : [User Guide](userguide/user-guide-toc.html)
</div>

{{% toc %}}

## Presentation Materials

These presentation materials will help you understand the overall architecture and core constructs of MINA

* [MINA in real life (ApacheCon EU 2009)](resources/Mina_in_real_life_ASEU-2009.pdf) by Emmanuel L{{< html "&eacute;" >}}charny
* [Rapid Network Application Development with Apache MINA (JavaOne 2008)](resources/JavaOne2008.pdf) by Trustin Lee
* [Apache MINA - The High Performance Protocol Construction Toolkit (ApacheCon US 2007)](resources/ACUS2007.pdf) by Peter Royal
* [Introduction to MINA (ApacheCon Asia 2006)](resources/ACAsia2006.pdf) by Trustin Lee

## Versions & References

There are currently three branches in MINA:

|JavaDoc|Source Code|Description|
|---|---|---|
| [2.0](http://mina.apache.org/mina-project/gen-docs/latest-2.0/apidocs/index.html) | [main](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/), [test](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref-test/) | The officially recommended production-ready branch |
| [2.1](http://mina.apache.org/mina-project/gen-docs/latest-2.1/apidocs/index.html) | [main](http://mina.apache.org/mina-project/gen-docs/latest-2.1/xref/), [test](http://mina.apache.org/mina-project/gen-docs/latest-2.1/xref-test/) | The new recommended production-ready branch |
| 3.0 | [trunk](http://svn.apache.org/viewvc/mina/mina/trunk/)| The version we are currently working on |

You might also want to read the [frequently asked questions](faq.html] and learn how to [contact us](../contact.html) before getting started.

## Tutorials


* [MINA v2.0 Quick Start Guide](quick-start-guide.html) - Create your first MINA based program using MINA version 2.0
* [Logging Configuration](userguide/ch12-logging-filter/ch12-logging-filter.html) - Configuring your MINA-based application for logging
* Transport-specific Configuration
    * [Serial Tutorial](userguide/ch6-transports/ch6.2-serial-transport.html) - Serial communications with MINA trunk
    * [UDP Tutorial](userguide/ch6-transports/ch6-transports) - Writing a User Datagram Protocol (UDP) client and server using MINA
    * [APR Transport](userguide/ch6-transports/ch6.1-apr-transport.html) - Describes use of APR Transport with MINA
* [Integrating with Spring](userguide/ch17-spring-integration/ch17-spring-integration.html) - Demonstrates how to integrate MINA application with Spring
* [Codec Repository](codec-repo.html) - Links to available codec implementations for MINA
* Advanced Topic
    * [Writing IoFilter](userguide/ch5-filters/ch5-filters.html) - Writing your own _IoFilter_ implementation to deal with cross-cutting concerns
    * [Writing Protocol Codec for MINA 2.x](userguide/ch9-codec-filter/ch9-codec-filter.html) - Implementing a protocol codec for separation of concern
    * [Using an Executor Filter](userguide/ch10-executor-filter/ch10-executor-filter.html) - Controlling the size of thread pool and choosing the right thread model
    * [JMX Integration](userguide/ch16-jmx-support/ch16-jmx-support.html) - Making your network application manageable
    * [Introduction to mina-statemachine](userguide/ch14-state-machine/ch14-state-machine.html) - Implementing state machine based MINA applications using Java5 annotations
* [User Guide](userguide/user-guide-toc.html) - The new draft MINA User Guide.

### For Developers

* [Developer Guide](developer-guide.html) \- Building & deploying MINA, Coding Standard, and more

## Examples

You can browse all examples [here](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/).

| Name | Feature it demonstrates | Side |
|---|---|---|
| [Reverser](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/reverser/) | Text protocol based on a protocol codec | Server |
| [SumUp server](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/sumup/) | Complex binary protocol based on a protocol codec | Both |
| [Echo server](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/echoserver/) | Low-level I/O and SSL | Server |
| [NetCat](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/netcat/) | Client programming | Client |
| [HTTP server](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/http/) | Stream-based synchronous I/O | Server |
| [Tennis](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/tennis/) | In-VM pipe communication | Both |
| [Chat server](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/chat/) | Spring integration | Both |
| [Proxy](http://mina.apache.org/mina-project/gen-docs/latest-2.0/xref/org/apache/mina/example/proxy/) | Resending received bytes on another session. | Both |

## Older Presentation Materials

* [Building TCP/IP Servers with Apache MINA (ApacheCon EU 2007)](resources/ACEU2007.pdf) by Peter Royal
* [Building TCP/IP Servers with Apache MINA (ApacheCon EU 2006)](resources/ACEU2006.pdf) by Peter Royal
* [Introduction to MINA (ApacheCon US 2005)](resources/ACUS2005.pdf) by Trustin Lee ([Demo movie](resources/ACUS2005.swf))

