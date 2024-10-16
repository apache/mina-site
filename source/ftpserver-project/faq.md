---
type: ftpserver
title: FtpServer FAQ
---

# FAQ

## General

{{% toc %}}

### My server fails with java.net.SocketException: Too many files open

Network sockets are treated like files and your operating system has a limit to the number of file handles it can manage. Running out of file handles is usually due to a large number of clients connecting and disconnecting frequently. As specified by TCP, after being closed sockets remain in the TIME_WAIT state for some additional time. The reason is to ensure that delayed packets arrive on the correct socket. In Windows, the default TIME_WAIT timeout is 4 minutes, in Linux it is 60 seconds.

### Change the timeout in Windows

1. Run regedit to start the Registry Editor
2. Locate the following key: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\tcpip\Parameters
3. Add a new value named TcpTimedWaitDelay asa decimal and set the desired timeout in seconds (30-300)
4. Reboot

### Change the timeout in Linux

1. Update the configuration value by running (30 seconds used in the example)

    echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout

2. Restart the networking component, for example by running

    /etc/init.d/networking restart

3. or

    service network restart

### How can I add other language translations?

First you need to specify your language name in config.message.languages configuration parameter. Then if you start the FTP server UI, you will see your language entry in the message panel. Translate messages and finally save your translated messages.

We are always interested in adding more translations to the official distribution of FtpServer. If you produce a translation and can contribute it back to the project, please create a new JIRA issue so that we can add it to the core product.

### How can I send binary data stored in a database when the FTP Server gets the RETR command?

You can write your own ftplet to do this. The following code will clarify this.

```java
public FtpletEnum onDownloadStart(FtpSession session, FtpRequest request,
        FtpReplyOutput response) throws FtpException, IOException {

    String requestedFile = request.getArgument();

    // get input stream from database - BLOB data
    InputStream in = getInputStreamFromDatabase(requestedFile);
    if (in == null) {
        response.write(new DefaultFtpReply(550, "Cannot find data " + requestedFile));
        return FtpletEnum.RET_SKIP;
    }

    // open data connection
    DataConnection out = null;
    response.write(new DefaultFtpReply(150, "Getting data connection."));
    try {
        out = session.getDataConnection().openConnection();
    } catch (Exception ex) {
    }
    
    if (out == null) {
        response.write(new DefaultFtpReply(425, "Cannot open data connection."));
        return FtpletEnum.RET_SKIP;
    }

    // transfer data
    try {
        out.transferToClient(in);
        response.write(new DefaultFtpReply(226, "Data transfer okay."));
    } catch (Exception ex) {
        response.write(new DefaultFtpReply(551, "Data transfer failed."));
    } finally {
        session.getDataConnection().closeDataConnection();
        in.close();
    }
    return FtpletEnum.RET_SKIP;
}
```

### Why I am getting ClassNotFoundException when I am trying to use database based user manager?

JDBC driver Jar file should be in CLASSPATH or it has to be copied in the INSTALL_DIR/common/lib directory. Did you specify fully qualified JDBC driver class name in config.user-manager.jdbc-driver configuration parameter?

### I am unable to run FtpServer on top of Glassfish although it is running correctly over tomcat.

This can be caused by Glassfish's QuickStartup mode which was the default one in some versions. In order to disable quick startup, add the following line to your domain.xml file:

```text
com.sun.enterprise.server.ss.ASQuickStartup=false
```
