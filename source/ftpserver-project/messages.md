---
type: ftpserver
title: FtpServer Messages
---

# Messages

This document explains how to customize all the Apache FtpServer reply messages.

All the server messages are customizable. The default reply messages are bundled with the server. The user defined custom messages will be stored separately. This custom message file is configurable.

The FtpServer project is interested in localized message bundles, please [contact the project](mailing_list.html) if you would like to donate.

## Example

    <messages languages="se, no ,da">

## messages element

| Attribute | Description | Required | Default value |
|--|--|--|--|
| directory | The directory in which message bundles can be located | No | {{< html "&nbsp;" >}} |
| languages | A comma separated list of the languages that the server will provide messages in | No | {{< html "&nbsp;" >}} |

## Creating a customized message bundle

### Dynamic Values

Dynamic values can be embedded in the server message replies. User can specify different variables in message strings. Variables are represented by {variable} in the string. 

| | |
|--|--|
| Variable Name | Description |
| server.ip | Server IP address. |
| server.port | Server port. |
| client.ip | Client IP address. |
| client.con.time | Client connection time. The date format is yyyy-MM-dd'T'HH:mm:ss (ISO8601). |
| client.login.time | Client login time. The date format is yyyy-MM-dd'T'HH:mm:ss (ISO8601). |
| client.login.name | User login name. If the user has not passed the login name, it will be null. |
| client.access.time | Client last access time. The date format is yyyy-MM-ddTHH:mm:ss (ISO8601). |
| client.home | User home directory. |
| client.dir | User current directory. |
| request.line | User request line. |
| request.cmd | User FTP command. |
| request.arg | User request argument. If there is no argument it will be null. |
| stat.start.time | Server start time. The date format is yyyy-MM-ddTHH:mm:ss (ISO8601). |
| stat.con.total | Total number of connections after server startup. |
| stat.con.curr | Current connection number. |
| stat.login.total | Total number of logins after server startup. |
| stat.login.curr | Current login number. |
| stat.login.anon.total | Total number of anonymous logins after server startup. |
| stat.login.anon.curr | Current anonymous login number. |
| stat.file.upload.count | Total number of files uploaded. |
| stat.file.upload.bytes | Total number of bytes uploaded. |
| stat.file.download.count | Total number of files downloaded |
| stat.file.download.bytes | Total number of bytes downloaded |
| stat.file.delete.count | Total number of files deleted. |
| stat.dir.create.count | Total number of directories created. |
| stat.dir.delete.count | Total number of directories removed. |
| output.code | FTP Server 3 digit reply code. |
| output.msg | Basic core message which has to be available in the message. |
