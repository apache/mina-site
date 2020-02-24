---
type: ftpserver
title: FtpServer Server
---

# Server

Some configuration is done for the entire server. This affects all listeners, for login limits, the sum of the logins for all listeners are enforced.

Using the XML configuration, this following examples shows all available configurations for the server

```xml
<server xmlns="http://mina.apache.org/ftpserver/spring/v1"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://mina.apache.org/ftpserver/spring/v1 http://mina.apache.org/ftpserver/ftpserver-1.0.xsd"
    id="server"     
    max-logins="500"
    anon-enabled="false"
    max-anon-logins="123"
    max-login-failures="124"
    login-failure-delay="125">
...
</server>
```

## server element

| Attribute | Description | Required | Default value |
|---|---|---|---|
| id | A unique identifier for this server within this XML configuration | Yes |&nbsp;|
| max-threads | The maximum number of threads used in the thread pool for handling client connections  | No | max-logins, or 16 if neither value is set |
| max-logins | The maximum number of simultaneous users  | No | 10 |
| max-anon-logins | The maximum number of simultaneous anonymous users  | No | 10 |
| anon-enabled | Are anonymous logins enabled? | No | true |
| max-login-failures | The number of failed login attempts before the connection is closed | No | 3 |
| login-failure-delay | The number of milliseconds that the connection is delayed after a failed login attempt. Used to limit to possibility of brute force guessing passwords. | No | 500 |


