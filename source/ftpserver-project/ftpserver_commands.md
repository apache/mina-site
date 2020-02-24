---
type: ftpserver
title: FtpServer FTP Commands
---

# FTP Commands

This document describes all the FTP commands implemented.

## ABOR

Aborts the previous FTP service command and any associated transfer of data.

### Server Replies

    226 ABOR command successful.

## ACCT

Provides the user's account. Not used by FtpServer.

### Server Replies

    202 Command ACCT not implemented.

## APPE

Appends data to the end of a file on the remote host. If the file does not already exist, it is created. This command must be preceded by a PORT or PASV command.

### Server Replies

    501 Syntax error.
    550 Not a plain file.
    550 Permission denied.
    150 Opening data connection.
    425 Cannot open data connection.
    426 Data connection error.
    551 Error on output file.
    226 Transfer complete.

## AUTH

Establishes SSL encrypted session. Only SSL type is supported.

### Server Replies

    501 Syntax error.
    431 Service is unavailable.
    234 AUTH command okay; starting SSL connection.

## CDUP
Change to parent directory.

### Server Replies

    250 Command okay.
    550 No such directory.

## CWD

Changes the working directory. If directory name is not specified, root directory (/) is assumed.

### Server Replies

    250 Command okay.
    550 No such directory.

## DELE

Deletes the file specified by the provided path.

### Server Replies

    250 Command okay.
    450 No permission to delete.
    450 Can't delete file.
    550 Not a valid file.
    501 Syntax error in parameters or arguments.

## EPRT

The EPRT command allows for the specification of an extended address for the data connection. The extended address MUST consist of the network protocol as well as the network and transport addresses. The format of EPRT is EPRT |<net-prt>|<net-addr>|<tcp-port>|

### Server Replies

    501 Syntax error.
    510 EPRT is disabled.
    510 Syntax error.
    553 Host unknown.
    510 EPRT IP is not same as client IP.
    552 Not a valid port number.
    200 EPRT command okay.

## EPSV
The EPSV command requests that a server listen on a data port and wait for a connection.

### Server Replies

    425 Cannot open passive connection.
    229 Entering passive mode (<message>).

## FEAT

Displays the feature list.

### Server Replies

    221 List of all the extensions supported.

## HELP

Displays the help information.

### Server Replies

    214 Help information.

## LANG

A new command "LANG" is added to the FTP command set to allow server-FTP process to determine in which language to present server greetings and the textual part of command responses.

### Server Replies

    502 Not yet implemented.

## LIST

This command causes a list to be sent from the server to the passive DTP. If the pathname specifies a directory or other group of files, the server should transfer a list of files in the specified directory. If the pathname specifies a file then the server should send current information on the file. A null argument implies the user's current working or default directory. The data transfer is over the data connection. This command must be preceded by a PORT or PASV command.

### Server Replies

    150 Opening data connection.
    425 Cannot open data connection.
    426 Data connection error.
    551 File listing failed.
    501 Syntax error.
    226 Closing data connection.

## MDTM

Returns the date and time of when a file was modified.

### Server Replies

    501 Syntax error.
    550 File unavailable.
    213 <timestamp>

## MKD

This command causes the directory specified in the pathname to be created as a directory (if the pathname is absolute) or as a subdirectory of the current working directory (if the pathname is relative).

### Server Replies

    501 Syntax error.
    550 Not a valid file.
    550 Already exists.
    550 No permission.
    250 Directory created.
    550 Cannot create directory.

## MLSD

Causes a list to be sent from the server to the passive DTP

### Server Replies

    150 File status okay; about to open data connection.
    226 Closing data connection.
    425 Can't open data connection.
    426 Data connection error.
    501 Syntax error in parameters or arguments.
    551 File listing failed.

## MODE

Set data transfer mode. The valid values are S and Z.

### Server Replies

    501 Syntax error.
    504 Not implemented for this command.
    200 Command okay.

## NLST

This command causes a directory listing to be sent from server to user site. The pathname should specify a directory or other system-specific file group descriptor; a null argument implies the current directory. The server will return a stream of names of files and no other information.

### Server Replies

    150 Opening data connection.
    425 Cannot open data connection.
    426 Data connection error.
    551 File listing failed.
    501 Syntax error.
    226 Closing data connection.

## NOOP

No operation.

### Server Replies

    200 Command okay.

## OPTS

Cause the server use optional features for the command specified.

### Server Replies

    500 Execution failed.
    501 Syntax error in parameters or arguments.
    502 Command OPTS not implemented for ...
    Additional return codes available for different OPTS commands.

## PASS

The argument field is a Telnet string specifying the user's password. This command must be immediately preceded by the USER command.

### Server Replies

    501 Syntax error.
    503 Login with USER first.
    202 Already logged-in.
    421 Maximum anonymous login limit has been reached.
    421 Maximum login limit has been reached.
    530 Authentication failed.
    230 User logged in, proceed.

## PASV

This command requests the server-DTP to listen on a data port (which is not its default data port) and to wait for a connection rather than initiate one upon receipt of a transfer command. The response to this command includes the host and port address this server is listening on.

### Server Replies

    425 Cannot open passive connection.
    227 Entering passive mode (<h1,h2,h3,h4,p1,p2>)

## PBSZ

protection buffer size.

### Server Replies

    200 Command okay.

## PORT

The argument is a HOST-PORT specification for the data port to be used in data connection. There are defaults for both the user and server data ports, and under normal circumstances this command and its reply are not needed. If this command is used, the argument is the concatenation of a 32-bit internet host address and a 16-bit TCP port address. This address information is broken into 8-bit fields and the value of each field is transmitted as a decimal number (in character string representation). The fields are separated by commas. A port command would be:

PORT h1,h2,h3,h4,p1,p2

### Server Replies

    501 Syntax error.
    510 Syntax error in parameters.
    510 Port is disabled.
    553 Host unknown.
    510 PORT IP mismatch.
    552 Invalid port number.
    200 Command PORT okay.

## PROT
Data channel protection level. The supported level values are C, P.

### Server Replies

    501 Syntax error.
    431 Security is disabled.
    504 Server does not understand the specified protection level.
    200 Command PROT okay.

## PWD

This command causes the name of the current working directory to be returned in the reply.

### Server Replies

    257 "<current directory>"

## QUIT

Closes connection.

### Server Replies

    200 Goodbye.

## REIN

Flushes a user, without affecting transfers in progress

### Server Replies

    220 Service ready for new user.

## REST

The argument field represents the server marker at which file transfer is to be restarted. This command does not cause file transfer but skips over the file to the specified data checkpoint. This command shall be immediately followed by the appropriate FTP service command which shall cause file transfer to resume.

### Server Replies

    501 Syntax error.
    501 Not a valid number.
    501 Marker cannot be negetive.
    350 Restarting at <position>. Send STORE or RETRIEVE to initiate transfer.

## RETR

This command causes the server-DTP to transfer a copy of the file, specified in the pathname, to the server- or user-DTP at the other end of the data connection. The status and contents of the file at the server site shall be unaffected.

### Server Replies

    501 Syntax error.
    550 No such file or directory.
    550 Not a plain file.
    550 Permission denied.
    150 Opening data connection.
    425 Cannot open the data connection.
    426 Data connection error.
    551 Error on input file.
    226 Transfer complete.

## RMD

This command causes the directory specified in the pathname to be removed as a directory (if the pathname is absolute) or as a subdirectory of the current working directory (if the pathname is relative).

### Server Replies

    501 Syntax error.
    550 No permission.
    550 Not a valid directory.
    250 Directory removed.
    550 Cannot remove directory.

## RNFR

This command specifies the old pathname of the file which is to be renamed. This command must be immediately followed by a RNTO command specifying the new file pathname.

### Server Replies

    501 Syntax error.
    550 File unavailable.
    350 Requested file action pending further information.

## RNTO

This command specifies the new pathname of the file specified in the immediately preceding RNFR command. Together the two commands cause a file to be renamed.

### Server Replies

    501 Syntax error.
    503 Cannot find the file which has to be renamed.
    553 Not a valid file name.
    553 No permission.
    250 Requested file action okay, file renamed.
    553 Cannot rename file.

## SITE

Handle Apache FTP Server specific custom commands. Please see the SITE commands page.

### Server Replies

    200 Command SITE okay.
    502 Command SITE not implemented for this argument.
    500 Execution failed.
    530 Access denied.

## SIZE

Returns the size of the file in bytes.

### Server Replies

    501 Syntax error.
    550 No such file or directory.
    550 Not a plain file.
    213 <size>

## STAT

This command shall cause a status response to be sent over the control connection in the form of a reply.

### Server Replies

    211 Statistics information.

## STOR

This command causes the server-DTP to accept the data transferred via the data connection and to store the data as a file at the server site. If the file specified in the pathname exists at the server site, then its contents shall be replaced by the data being transferred. A new file is created at the server site if the file specified in the pathname does not already exist.

### Server Replies

    501 Syntax error.
    550 Invalid path.
    550 Permission denied.
    150 Opening data connection.
    425 Cannot open the data connection.
    426 Data connection error.
    551 Error on output file.
    226 Transfer complete.

## STOU

This command behaves like STOR except that the resultant file is to be created in the current directory under a name unique to that directory. The 250 Transfer Started response must include the name generated.

### Server Replies

    550 Unique file name error.
    550 Permission denied.
    150 Opening data connection.
    425 Cannot open the data connection.
    250 <file> Transfer started.
    426 Data connection error.
    551 Error on output file.
    226 Transfer complete.

## STRU

The argument is a single Telnet character code specifying file structure. The allowed argument is F.

### Server Replies

    501 Syntax error.
    504 Command not implemented.
    200 Command okay.

## SYST

This command is used to find out the type of operating system at the server.

### Server Replies

    215 UNIX Type: Apache FTP Server

## TYPE

The argument specifies the representation type. The allowed types are A and I.

### Server Replies

    501 Syntax error.
    504 Command not implemented.
    200 Command okay.

## USER

The argument field is a Telnet string identifying the user. The user identification is that which is required by the server for access to its file system. This command will normally be the first command transmitted by the user after the control connections are made.

### Server Replies

    501 Syntax error.
    230 Already logged-in.
    530 Invalid user name.
    530 Anonymous connection is not allowed.
    421 Maximum anonymous login limit has been reached.
    421 Maximum login limit has been reached.
    331 Guest login okay, send your complete e-mail address as password.
    331 User name okay, need password.
