---
type: ftpserver
title: FtpServer Logging
---

# Logging

## FtpServer Logging

FtpServer uses [SLF4J](http://slf4j.org/) throughout its internal code allowing the developer to choose a logging configuration that suits their needs, e.g java.util.logging or Log4J. SLF4J provides FtpServer the ability to log hierarchically across various log levels without needing to rely on a particular logging implementation.

## MDC logging

FtpServer supports [MDC logging](http://www.slf4j.org/manual.html#mdc). Basically, it provides session based information for the logger. Of primary interest in the case of FtpServer are the user name and remote IP address for each session. The log4j example below shows how to enable these to be logged.

The following properties are made available for MDC logging

| Token | Description |
|---|---|
| session | A unique session ID, the same available from FtpSession.getSessionId() |
| userName | The user name of the user, only available after the USER command has been issued |
| remoteAddress | The IP and local port of the client |
| remoteIp | The IP of the client |
| remotePort | The port used for the socket at the client |
| localAddress | The local IP and port of the server for this session |
| localIp | The local IP of the server for this session |
| localPort | The local port of the server for this session |

## log4j

If you need to setup detailed logging from within FtpServer's code, then you can use a simple log4j configuration. Note that this logging can be very verbose depending on the log level you chose to use. The log4j jar is bundled with the binary distribution. This is an optional jar file.

The log4j configuration file location is <INSTALL_DIR>/common/classes/log4j.properties. You can modify this file to configure log4j.

```text
log4j.rootLogger=DEBUG, R
log4j.appender.R=org.apache.log4j.RollingFileAppender
log4j.appender.R.File=./res/log/log.gen
log4j.appender.R.MaxFileSize=10MB
log4j.appender.R.MaxBackupIndex=10
log4j.appender.R.layout=org.apache.log4j.PatternLayout
log4j.appender.R.layout.ConversionPattern=[%5p] %d [%X{userName}] [%X{remoteIp}] %m%n
```

This log4j configuration sets up a file called log.gen in your FTP Server ./res/log folder with a maximum file size of 10MB and up to 10 backups. DEBUG log level is specified.

You should consult the log4j documentation for more options.
