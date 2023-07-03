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

The **FtpServerFactory** is associated with a **FtpServerContext** instance, which defines a set of elements:

* a **CommandFactory** instance
* a **ConnectionConfig** instance
* a **FileSystemFactory** instance
* a **FtpletContainer** instance
* a **FtpStatistics** instance
* a set of **Listener** instances
* a **MessageResource** instance. It manages the messages  (code and sub-ids) associated with the various supported languages.
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

### MessageResourceFactory and MessageResource

The **MessageResourceFactory** is used to create the **MessageResource** instance which will be an instance of the **DefaultMessageResource** class).

The **MessageResource** instance contains the messages for all the supported languages. Those messages are those sent to the client when a command is executed. For instance, the response for a **STOR** command may be:

```
Can't open data connection.
```

This is defined in the _FtpStatus.properties_ file, among other response messages:

```
...
425.STOR=Can't open data connection.
...
```

Those messages are read from various places (the &lt;lang&gt; tag is the name of the language to use, like **en**, **fr**, etc):

* Default messages
  * _org/apache/ftpserver/message/FtpStatus.properties_
  * _org/apache/ftpserver/message/FtpStatus_&lt;lang&gt;.properties_
* Custom messages
  * _org/apache/ftpserver/message/FtpStatus.gen_
  * _org/apache/ftpserver/message/FtpStatus_&lt;lang&gt;.gen_

## Commandfactory

This factory creates a **Map** which contains the _Command_ instances associated with the command name. The current version support those commands:

| Command | RFC reference |
| --- | --- |
| ABOR | rfc959, 4.1.3 |
| ACCT | rfc959, 4.1.1 |
| APPE | rfc959, 4.1.3 |
| AUTH | rfc2228, 3 |
| CDUP | rfc959, 4.1.1 |
| CWD | rfc959, 4.1.1 |
| DELE | rfc959, 4.1.3 |
| EPRT | rfc2428, 2 |
| EPSV | rfc2428, 3 |
| FEAT | rfc2389, 3 |
| HELP | rfc959, 4.1.3 |
| LANG | rfc2640, 4.1 |
| LIST | rfc959, 4.1.3 |
| MD5 | draft-twine-ftpmd5-00.txt , 3.1 |
| MMD5 | draft-twine-ftpmd5-00.txt , 3.2 |
| MDTM | rfc3659, 3 |
| MFMT | draft-somers-ftp-mfxx, 3 |
| MKD | rfc959, 4.1.3 |
| MLSD | rfc3659, 7 |
| MLST | rfc3659, 7 |
| MODE | rfc959, 4.1.2 |
| NLST | rfc959, 4.1.3 |
| NOOP | rfc959, 4.1.3 |
| OPTS | rfc2389, 4 |
| PASS | rfc959, 4.1.1 |
| PASV | rfc959, 4.1.2 |
| PBSZ | rfc2228, 3 |
| PORT | rfc959, 4.1.2 |
| PROT | rfc2228, 3 |
| PWD | rfc959, 4.1.3 |
| QUIT | rfc959, 4.1.1 |
| REIN | rfc959, 4.1.1 |
| REST | rfc959, 4.1.3, rfc3659, 5 |
| RETR | rfc959, 4.1.3 |
| RMD | rfc959, 4.1.3 |
| RNFR | rfc959, 4.1.3 |
| RNTO | rfc959, 4.1.3 |
| SITE | rfc959, 4.1.3 |
| SITE_DESCUSER | rfc959, 4.1.3 |
| SITE_HELP | rfc959, 4.1.3 |
| SITE_STAT | rfc959, 4.1.3 |
| SITE_WHO | rfc959, 4.1.3 |
| SITE_ZONE | rfc959, 4.1.3 |
| SIZE | rfc3659, 4 |
| STAT | rfc959, 4.1.3 |
| STOR | rfc959, 4.1.3 |
| STOU | rfc959, 4.1.3 |
| STRU | rfc959, 4.1.2 |
| SYST | rfc959, 4.1.3 |
| TYPE | rfc959, 4.1.2 |
| USER | rfc959, 4.1.1 |

The class hierarchy is the following:

```goat

 .--------------.
| CommandFactory |
 '--------------'
        ^
        |   .----------------------.
        '--| DefaultCommandFactory  |
            '----------------------'

```


And instance of a _CommandFactory_ can be obtained by calling the _CommandFactoryFactory.createCommandFactory_:

```java
        CommandFactoryFactory commandFactoryFactory = new CommandFactoryFactory();

		CommandFactory commandFactory = commandFactoryFactory.createCommandFactory();    
```

The _CommandFactory_ instance will contain all the previously listed commands.

You can add some commands in the default list:

```java
        CommandFactoryFactory commandFactoryFactory = new CommandFactoryFactory();

        commandFactoryFactory.addCommand("PASV", new PASVTest());

		CommandFactory commandFactory = commandFactoryFactory.createCommandFactory();    
```

The _CommandFactory_ instance will contain all the previously listed commands plus the added **PASV** command.

You can also create non standard commands by setting the _CommandFactoryFactory.useDefaultCommands_ to false. here is an example:

```java
        CommandFactoryFactory commandFactoryFactory = new CommandFactoryFactory();

        // Add a non standard command
        commandFactoryFactory.addCommand("foo", new NOOP());

        // tell the factory it will contain non-standard commands
        commandFactoryFactory.setUseDefaultCommands(false);

        // Get the commandfactory having only the created non standard command
		CommandFactory commandFactory = commandFactoryFactory.createCommandFactory();


```

Here, the _Commandfactory_ instance will onkly contain non-standard commands, and none of the default commands.

## UserManagerFactory

This factory creates an _UserManager_ instance, which may be file based or Database based.

There are two implementations of this factory:

* _DbUserManagerFactory_ which takes the information relative to the user from a **SQL** Database
* _PropertiesUserManagerFactory_ which takes the information relative to the user from properties file
