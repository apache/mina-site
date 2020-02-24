---
type: ftpserver
title: FtpServer Ftplet
---

# Ftplet

## Overview

The Ftplet API is a simple API used to handle different FtpServer notifications. Apache FtpServer is a Ftplet container, allowing administrators to deploy Ftplet to carry out a variety of complex FTP event handler tasks.

Implementing a custom Ftplet is generally a simple task, most of whose complexity lies in coding the actual work to be done by the Ftplet. This is largely due to the simplicity of the Ftplet interface and the fact that a DefaultFtplet class is provided as part of the Ftplet package.

The Ftplet interface supports two lifecycle methods to provide initialization (the init() method) and shutdown (the destroy() method). Main processing is done in different notification methods, which take a FtpSession object and a FtpRequest object. All the notification methods return FtpletResult object to indicate the future action.

There will be one instance of Ftplet object. Notification methods will be called from different connections running in different threads. So Ftplet implementation has to be thread-safe. Each connection will have its own request (FtpRequest) and session (FtpSession) objects.

## Main Classes

### FtpletResult

This class encapsulates the return values of the ftplet methods. There are four static FtpletResult values.

* __DEFAULT__ : This return value indicates that the next ftplet method will be called. If no other ftplet is available, the FtpServer will process the request.
* __NO_FTPLET__ : This return value indicates that the other ftplet methods will not be called but the FtpServer will continue processing this request.
* __SKIP__ : It indicates that the server will skip everything. No further processing will be done for this request.
* __DISCONNECT__ : It indicates that the server will skip and disconnect the client. No other request from the same client will be served.

So, DEFAULT < NO_FTPLET < SKIP > DISCONNECT. If the Ftplet returns null, DEFAULT is assumed.

## FtpSession

The session object is kept for the entire user session. So the attributes set by setAttribute() will be always available later unless that attribute is removed. Different session will have different FtpSession objects. From here we can get user information, data streams, user file system view etc.

Ftplets can use this to send custom codes and messages to client.

## FtpRequest

Provides the client request information to a ftplet. Contains the FTP command and argument.

## Ftplet

There will be only one instance of Ftplet. During startup the Ftplets will be initialized. The initialization sequence is same as the Ftplet sequence in the configuration. Then all notification methods will be called and when the FtpServer goes down, the Ftplet will be destroyed. The following method describes all the notification methods.

| Method | Description |
|---|---|
| onConnect | Client connect notification method. This is the first method FtpServer will call. If it returns SKIP, IP restriction check, connection limit check will not be performed and the server will not send the welcome message (220). |
| onDisconnect | Client disconnect notification method. This is the last method FtpServer will call. Whatever it returns, the client connection will be closed. |
| beforeCommand | Called before the server invoke the command. |
| afterCommand | Called after the server as invoked the command. |

## DefaultFtplet

DefaultFtplet provides some convenience methods for common FTP commands. Users can easily extend the DefaultFtplet class and choose what methods to override and handle.

| Method | Description |
|---|---|
| onLogin | Client login notification method. This will be called after the user authentication. In this case the FtpServer has already sent the login OK (230) reply. This is called during FTP PASS request. The FTP session will be disconnected in the return value is FtpletResult.DISCONNECT. |
| onDeleteStart | Before file deletion this method will be called. Before this FtpServer will not check anything like file existence or permission. The requested file name can be get from request argument. We can get the file object from the request file system view. This is called in DELE FTP command. The method should send some responses (like 250, 450, 550) in case of SKIP return value. In this case, the server will skip the command processing and the ftplet has to send appropriate response values. |
| onDeleteEnd | This method will be called after the file deletion, successful or not. In this case the FtpServer has already sent the reply message. This is called in DELE FTP command. |
| onUploadStart | This method will be called before the file upload. The file name can be get from the request argument. We can get the data input stream from request. This will be called before the permission check. This is called during STOR command. If the method returns SKIP, it has to send responses before and after processing. For example, before opening the data input stream, the method has to notify the client with a response code 150. Similarly, after the data transfer, the method has to notify the client with a response code 226. In case of any error, the method should send different response codes like 450, 425, 426, 551. |
| onUploadEnd | This notification method will be called to indicate that the file transfer is successful and the server has send the replies. In case of any error this method will not be called. This is called in STOR command. |
| onDownloadStart | This is file download request notification method called during RETR command. This will be called before the file download. We can get the file name argument from request. Similarly, the data output stream can be get from the request. This will be called before the file existence and permission check. If the method returns SKIP, it has to send responses before and after processing. For example, before opening the data output stream, the method has to notify the client with a response code 150. Similarly, after the data transfer, the method has to notify the client with a response code 226. In case of any error, the method should send different response codes like 450, 425, 426, 551. |
| onDownloadEnd | This notification method will be called to indicate that the file transfer is successful and the server has send the replies in RETR command. |
| onRmdirStart | Before directory deletion this method will be called during RMD command. Before this FtpServer will not check anything like directory existence or permission. The requested directory name can be get from request argument. If the method returns the SKIP, it has to send appropriate response codes to clients like 250, 450, 550. |
| onRmdirEnd | This method will be called after the invocation of the RMD command. In this case the FtpServer has already sent the reply message. |
| onMkdirStart | Before directory creation this method will be called during MKD command. Before this FtpServer will not check anything like directory existence or permission. The requested directory name can be get from request argument. If it returns SKIP, it has to send appropriate response codes to clients like 250, 550. |
| onMkdirEnd | This method will be called if the directory creation is successful in MKD command. In this case the FtpServer has already sent the reply message. |
| onAppendStart | This is file append request notification method called in APPE command. The file name can be get from the request argument. We can get the data input stream from request. This will be called before the permission check. If the method returns SKIP, it has to send responses before and after processing. For example, before opening the data input stream, the method has to notify the client with a response code 150. Similarly, after the data transfer, the method has to notify the client with a response code 226. In case of any error, the method should send different response codes like 450, 425, 426, 551. |
| onAppendEnd | This is file append success notification method called in APPE command. |
| onUploadUniqueStart | This is unique file create request notification method called in STOU command. We can get the data input stream from request. This will be called before the permission check. If the method returns SKIP, it has to send responses before and after processing. For example, before opening the data input stream, the method has to notify the client with a response code 150. Similarly, after the data transfer, the method has to notify the client with a response code 226. In case of any error, the method should send different response codes like 450, 425, 426, 551. |
| onUploadUniqueEnd | This is unique file create success notification method called in STOU command. This notification method will be called to indicate the the server has send the replies. |
| onRenameStart | This is file rename start notification method called in RNTO command. This will be called before the file existence or permission check. The "rename from" file object can be get from request object. If it returns SKIP, it has to send appropriate response codes like 503, 553, 250. |
| onRenameEnd | This is file rename success notification method called in RNFR command. This will be called before the file existence or permission check. The "rename from" file object an be get from request object. This notification method will be called after the invocation of the RNTO command and the server has send the reply message. |
| onSite | This is SITE command start notification method. It gives a chance to implement custom SITE command. If this method returns SKIP or DISCONNECT, the existing SITE commands will not be executed. |

## Response Codes

This section gives an overview on different response codes which might be useful in developing custom ftplet. These commands might be used when the ftplet method return value is SKIP.

| Method | Response Code | Description |
|---|---|---|
| onConnect | 220 | Service ready for new user. |
| onConnect | 530 | No server access from the IP. |
| onConnect | 530 | Maximum server connection has been reached. |
| onDisconnect | &nbsp; | &nbsp; |
| onLogin | &nbsp; | &nbsp; |
| onDeleteStart | 250 | Requested file action okay |
| onDeleteStart | 450 | No permission to delete. |
| onDeleteStart | 550 | Not a valid file. |
| onDeleteStart | 450 | Can't delete file. |
| onDeleteEnd | &nbsp; | &nbsp; |
| onUploadStart | 150 | File status okay; about to open data connection. |
| onUploadStart | 226 | Transfer complete. |
| onUploadStart | 550 | Invalid path. |
| onUploadStart | 550 | Permission denied. |
| onUploadStart | 425 | Can't open data connection. |
| onUploadStart | 426 | Data connection error. |
| onUploadStart | 551 | Error on output file. |
| onUploadEnd | &nbsp; | &nbsp; |
| onDownloadStart | 150 | File status okay; about to open data connection. |
| onDownloadStart | 226 | Transfer complete. |
| onDownloadStart | 550 | No such file or directory. |
| onDownloadStart | 550 | Not a plain file. |
| onDownloadStart | 550 | Permission denied. |
| onDownloadStart | 425 | Can't open data connection. |
| onDownloadStart | 426 | Data connection error. |
| onDownloadStart | 551 | Error on input file. |
| onDownloadEnd | &nbsp; | &nbsp; |
| onRmdirStart | 250 | Directory removed. |
| onRmdirStart | 550 | Not a valid directory. |
| onRmdirStart | 550 | Permission denied. |
| onRmdirStart | 550 | Can't remove directory. |
| onRmdirEnd | &nbsp; | &nbsp; |
| onMkdirStart | 250 | Directory created. |
| onMkdirStart | 550 | Not a valid file. |
| onMkdirStart | 550 | Permission denied |
| onMkdirStart | 550 | Directory already exists. |
| onMkdirStart | 550 | Can't create directory. |
| onMkdirEnd | &nbsp; | &nbsp; |
| onAppendStart | 150 | File status okay; about to open data connection. |
| onAppendStart | 226 | Transfer complete. |
| onAppendStart | 550 | Not a plain file. |
| onAppendStart | 550 | Permission denied. |
| onAppendStart | 425 | Can't open data connection. |
| onAppendStart | 426 | Data connection error. |
| onAppendStart | 551 | Error on output file. |
| onAppendEnd | &nbsp; | &nbsp; |
| onUploadUniqueStart | 150 | File status okay; about to open data connection. |
| onUploadUniqueStart | 250 | filename: Transfer started. |
| onUploadUniqueStart | 226 | filename: Transfer complete. |
| onUploadUniqueStart | 550 | Unique file name error. |
| onUploadUniqueStart | 550 | Permission denied. |
| onUploadUniqueStart | 425 | Can't open data connection. |
| onUploadUniqueStart | 426 | Data connection error. |
| onUploadUniqueStart | 551 | Error on output file. |
| onUploadUniqueEnd | &nbsp; | &nbsp; |
| onRenameStart | 250 | Requested file action okay, file renamed. |
| onRenameStart | 503 | Can't find the file which has to be renamed. |
| onRenameStart | 553 | Not a valid file name. |
| onRenameStart | 553 | Permission denied. |
| onRenameStart | 553 | No such file or directory. |
| onRenameStart | 553 | Can't rename file. |
| onRenameEnd | &nbsp; | &nbsp; |
| onSite | 200 | Command SITE okay. |
| onSite | 530 | Permission denied. |
| onSite | 502 | Not implemented. |
| onSite | 500| Execution failed. |

## Configuration

Ftplet will get the Ftplet specific configuration as the init() method argument.

## Implementation

Ftplets are regular POJOs. If running the server as embedded they can be added to the FtpletContainer as normal instances of the object. If using the XML configuration, they are configured and Spring beans within the ftplets element. Here's an example:

```xml
<ftplets>
    <ftplet name="ftplet1">
        <beans:bean class="org.apache.ftpserver.examples.MyFtplet">
            <beans:property name="foo" value="123" />
        </beans:bean>
    </ftplet>
</ftplets>
```

## Deployment

The Ftplet must be added to Apache FtpServer classpath so that the Ftplet can be loaded. There are three ways you can do that.

1. Modify your system CLASSPATH environment variable to include your ftplet classes.
2. Copy your ftplet class files (unpacked) in the common/classes directory of the FtpServer installation.
3. Place a jar file containing the custom ftplet class files in the common/lib subdirectory of the FtpServer installation.
