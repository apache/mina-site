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
                     |   .-----------------------.
                     '--| DefaultFtpServerContext |
                         '-----------------------'

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

## CommandFactory

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

The _User_ class contain information about the users:

* _ftpserver.user.{username}.homedirectory_: Path to the home directory for the user, based on the file system implementation used
* _ftpserver.user.{username}.userpassword_: The password for the user. Can be in clear text, MD5 hash or salted SHA hash based on the configuration on the user manager
* _ftpserver.user.{username}.enableflag_: true if the user is enabled, false otherwise
* _ftpserver.user.{username}.writepermission_: true if the user is allowed to upload files and create directories, false otherwise
* _ftpserver.user.{username}.idletime_: The number of seconds the user is allowed to be idle before disconnected. 0 disables the idle timeout
* _ftpserver.user.{username}.maxloginnumber_: The maximum number of concurrent logins by the user. 0 disables the check.
* _ftpserver.user.{username}.maxloginperip_: The maximum number of concurrent logins from the same IP address by the user. 0 disables the check.
* _ftpserver.user.{username}.uploadrate_: The maximum number of bytes per second the user is allowed to upload files. 0 disables the check.
* _ftpserver.user.{username}.downloadrate_: The maximum number of bytes per second the user is allowed to download files. 0 disables the check.

Here is an exemple of file containing some users:

```
ftpserver.user.admin.homedirectory=./test-tmp/ftproot
ftpserver.user.admin.userpassword=admin
ftpserver.user.admin.enableflag=true
ftpserver.user.admin.writepermission=true
ftpserver.user.admin.idletime=0
ftpserver.user.admin.maxloginnumber=0
ftpserver.user.admin.maxloginperip=0
ftpserver.user.admin.uploadrate=0
ftpserver.user.admin.downloadrate=0

```

In any case, we use a _UserManager_ instance to manage the users once read by one of the two previous factories.

### UserManager

The hierarchy is the following:


```goat

  .-----------.
 | UserManager |
  '-----------'
        ^
        |   .-------------------.
        '--| AbstractUserManager |
            '-------------------'
                       ^
                       |   .-------------.
                       +--| DbUserManager |
                       |   '-------------'
                       |
                       |   .---------------------.
                       '--| PropertiesUserManager |
                           '---------------------'
```

Those classes are used to get the **User** information. The **User** class stores the following data:

* *authorities*: The user's permissions. One of _WritePermission_, _TransferRatePermission_ and _ConcurrentLoginPermission_
* *homeDir*: The user's home directory
* *isEnabled*: A flag set to _true_ if teh user is enabled
* *maxIdleTimeSec*: The maximum time the user can remain iddle (default to infinite)
* *name*: The user's name
* *password*: The hashed user's password

The _User_ interface is used to expose the available methods. The class hierarchy is:

```goat

  .----.
 | User |
  '----'
     ^
     |   .--------.
     '--| BaseUser |
         '--------'
```

As the users are stored either in a property file or in a SQL Database, we need a way to manage those users. There is a class that can bbe used to add users in those containes: the _AddUser_ class. Otherwise, the _UserManager_ instance can be used to delete or get users from their container. Creating a user programatically can be done either with the _UserFactory_ or by instanciating a _BaseUser_ class.

### FileSystemFactory

This factory will be used to create the directory the user will access. The factory will be used later.

### FtpletContainer

The _FtpletCinainer_ is holding all the _Ftplet_ elements in a _HashMap_.

A _Ftplet_ is a piece of code that get executed before or after a command, and before and after a connection.

Here is the class hierarchy:

```goat

  .------.
 | Ftplet |
  '------'
      ^
      |   .---------------.
      '--| FtpletContainer |
          '---------------'
                       ^
                       |   .----------------------.
                       '--| DefaultFtpletContainer |
                           '----------------------'
```

### FtpStatistics

This is used to store statistics about the FtpServer usage. The class hierarchy is teh following:

```goat

  .-------------.
 | FtpStatistics |
  '-------------'
         ^
         |   .-------------------.
         '--| ServerFtpStatistics |
             '-------------------'
                       ^
                       |   .--------------------.
                       '--| DefaultFtpStatistics |
                           '--------------------'
```

The _FtpStatistics_ contains all the getters, the _ServerFtpStatistics_ contains all the setters.

The following values are followed:

* _startTime_
* _uploadCount_
* _downloadCount_
* _deleteCount_
* _mkdirCount_
* _rmdirCount_
* _currLogins_
* _totalLogins_
* _totalFailedLogins_
* _currAnonLogins_
* _totalAnonLogins_
* _currConnections_
* _totalConnections_
* _bytesUpload_
* _bytesDownload_

The methods are called by the *Command* instances.

### ConnectionConfigFactory

This class create a _ConnectionConfig_ instance.

It manages the following server parameters:

* _maxLogins_
* _anonymousLoginEnabled_
* _maxAnonymousLogins_
* _maxLoginFailures_
* _loginFailureDelay_
* _maxThreads_

By default, the server configuration will allow 3 fails login attempts, insert a 500ms delay between each attempt, allow 10 concurrent users, allow 10 anonymous users, and do not limit the number of threads dedicated for command processing.

### Listeners

The _Listeners_ are used to manage communications with the users. We keep a _Map_ of created listeners. Those listeners are created by a _ListenerFactory_.

The _ListenerFactory_ class contains a _DataConnectionConfiguration_ instance which is created by a _DataConnectionConfigurationFactory_ factory class.

The class hierarchy is the following:

```goat

  .--------.
 | Listener |
  '--------'
      ^
      |   .----------------.
      '--| AbstractListener |
          '----------------'
                  ^
                  |   .-----------.
                  '--| NioListener |
                      '-----------'
```

The _NioListener_ class is responsible for all the TCP communication with the user. It depends on **MINA** _SocketAcceptor__ class.

The _AbstractListener_ class 

The _SocketAcceptor_ instance is declared with the following parameters:

* _ReuseAddress_ is set to true
* The read buffer size is set to 2048
* The receive buffer size is set to 512
* The idle time is set to 300 seconds
* The service chain contains, in this order from server to handler:
  * An optional _SslFilter_
  * A _MdcInjectionFilter_
  * An optional _MinaSessionFilter_
  * A _ExecutorFilter_ 
  * A _ProtocolCodecFilter_: The decoder is a simple instance of a _TextLineDecoder_. The encoder is an instance of a _FtpResponseEncoder_.
  * A _MdcInjectionFilter_
  * A _FtpLoggingFilter_

A _Listener_ instance can be created through a call to the _ListenerFactory.createListener()_ method, it should not be created directly. This method instanciate a _NioListener_ after having chekced that the provided server name is valid.

Internally, it creates a _FtpHandler_ instances, which is used to handle all the incoming *FTP* requests.

The instanciated _listener_ will be added to the map of listeners, as *default*.

The server factory has been created, we now have to create the server and to start it.
