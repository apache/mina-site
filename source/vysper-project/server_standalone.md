---
type: vysper
title: Vysper Standalone Server
---

# run main class

if you like to invoke the server from an IDE or the commandline, use the Java class

```java
org.apache.vysper.spring.ServerMain
```

for example by typing

```java
java org.apache.vysper.spring.ServerMain
```

be sure to include all jars in lib/ in your classpath plus the spring-config.xml.

It is also possible to load modules on the command line:

```java
java org.apache.vysper.spring.ServerMain -Dvysper.add.module=module1,module2...
```
