---
type: ftpserver
title: FtpServer SITE Commands
---

# SITE Commands

This document describes all the FTP SITE commands implemented.

## SITE DESCUSER

It displays the user details.

### Sample Server Replies

    200-
    DESCUSER : display user information.
    HELP     : display this message.
    STAT     : show statistics.
    WHO      : display all connected users.
    ZONE     : display timezone.
    200 End of help.

## SITE HELP

It displays all the available SITE commands.

### Server Replies

    200-
    DESCUSER : display user information.
    HELP     : display this message.
    STAT     : show statistics.
    WHO      : display all connected users.
    ZONE     : display timezone.
    200 End of help.

## SITE STAT

This command displays different server statistics information. Only admin user has the permission to execute this.

### Sample Server Reply

    200-
    Start Time               : 2005-09-01T12:10:11
    File Upload Number       : 0
    File Download Number     : 0
    File Delete Number       : 0
    File Upload Bytes        : 0
    File Download Bytes      : 0
    Directory Create Number  : 0
    Directory Remove Number  : 0
    Current Logins           : 1
    Total Logins             : 1
    Current Anonymous Logins : 0
    Total Anonymous Logins   : 0
    Current Connections      : 1
    Total Connections        : 1
    200

## SITE WHO

This command displays all currently logged-in user information. It displays the user name, client IP, login time and last access time. Only admin user has the permission to execute this.

### Sample Server Reply

    200-
    admin           127.0.0.1       2005-09-01T12:20:26 2005-09-01T12:20:52
    anonymous       127.0.0.1       2005-09-01T12:20:37 2005-09-01T12:20:37
    200

## SITE ZONE

This command displays the timezone information of the FTP server in RFC 822 4-digit time zone format. The format is
Sign TwoDigitHours TwoDigitMinutes

### Sample Server Reply

    200 +0530
