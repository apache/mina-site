---
type: ftpserver
title: Chapter 6 - FtpServer internals
navPrev: ../ch5-developping/ch5-developping.html
navPrevText: Chapter 5 - Developping
navUp: ../documentation-toc.html
navUpText: Documentation
---

# Chapter 6 - Internals

Creating a **FtpServer** instance is done using a **FtpServerFactory**. The is done with such code:

```java
    FtpServerFactory serverFactory = new FtpServerFactory();
    FtpServer server = serverFactory.createServer();
    server.start();
    ...
```

Let's see what happens when we create the factory and when the server is created

## FtpServerFactory creation

The **FtpServerFactory** is associated with a **FtpServerContext** instance, which define a set of elements:

* a **CommandFactory** instance
* a **ConnectionConfig** instance
* a **FileSystemFactory** instance
* a **FtpletContainer** instance
* a **FtpStatistics** instance
* a set of **Listener** instances
* a **MessageResource** instance
* a **UserManager** instance

The class hierarchy is the following:

```goat

 .-------------.
| FtpletContext |
 '-------------'
        ^
        |   .----------------.
        '--| FtpServerContext |
            '----------------'
                     ^
                     |  .-------------------------.
                     '--| DefaultFtpServerContext |
                        '-------------------------'

```

