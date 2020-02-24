---
type: sshd
title: SSHD Required dependencies
---

# Required dependencies

SSHD has 2 compile-time dependencies:

* [MINA Core 2.0.x](http://repo1.maven.org/maven2/org/apache/mina/mina-core/2.0.7/mina-core-2.0.7.jar) : http://repo1.maven.org/maven2/org/apache/mina/mina-core/2.0.7/mina-core-2.0.7.jar
* [SLF4J API 1.6.4](http://repo2.maven.org/maven2/org/slf4j/slf4j-api/1.6.4/slf4j-api-1.6.4.jar) : http://repo2.maven.org/maven2/org/slf4j/slf4j-api/1.6.4/slf4j-api-1.6.4.jar

Note that since SSHD 0.9.0, the Mina Core library is optional when running in JDK 1.7 and SSHD will default to using nio2 if available.

To be able to run SSHD, you will also need one SLF4J Logger implementation. The simplest one is the one using java.util.logging underneath which can be downloaded at <http://repo2.maven.org/maven2/org/slf4j/slf4j-jdk14/1.6.4/slf4j-jdk14-1.6.4.jar>
