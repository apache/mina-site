---
type: mina
title: Road map
---

Please click the following links to find out what issues have been resolved and what issues will be resolved.

* [Road map for the future releases](http://issues.apache.org/jira/browse/DIRMINA?report=com.atlassian.jira.plugin.system.project:roadmap-panel&subset=-1)
* [Change log for the past releases](http://issues.apache.org/jira/browse/DIRMINA?report=com.atlassian.jira.plugin.system.project:changelog-panel&subset=-1)

## Genesis of MINA

by Trustin Lee 

In June 2004, I released a network application framework, 'Netty2'. It was the first network application framework that provides event-based architecture in Java community. It attracted network application programmers because of its simplicity and ease of use. As the Netty2 community matured, its problems also arose. Netty2 didn't work fine with text protocols and had a critical architectural flaw that prevents users from using it for applications with many concurrent clients.

Quite a large amount of information was collected about what users like about Netty2 and what improvements they want from it for 6 months. It was clear they like its ease of use and unit-testability. They wanted support for UDP/IP and text protocols. I had to invent a cleaner, more flexible, and more extensible API so that it is easy to learn yet full-featured.

Meanwhile around 2003 at Apache Directory, Alex Karasulu was wrestling with a network application framework he developed based on the [Matt Welsh's SEDA (Staged Event Driven Architecture)](http://www.sosp.org/2001/papers/welsh.pdf).  After several iterations Alex realized it was very difficult to manage, and started to research other network application frameworks looking for a replacement.  He wanted something for Java that would scale like SEDA yet was simple to use like [ACE](http://www.cs.wustl.edu/~schmidt/ACE.html).  Alex encountered Netty2 at [gleamynode.net](https://web.archive.org/web/20130502105932/http://gleamynode.net/) and contacted me asking if I wanted to work with him on a new network application framework.

In September 2004, I formally joined the Apache Directory team.  Alex and I decided to mix concepts between the two architectures to create a new network application framework.  We exchanged various ideas to extract the strengths of both legacy frameworks to ultimately come up with what is today's 'MINA'.

Since then MINA became the primary network application framework used by the Apache Directory project for the various implemented by Apache Directory Server (ApacheDS). Several complex protocols in ApacheDS are implemented with MINA: LDAP, Kerberos, DNS and NTP.
