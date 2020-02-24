---
type: vysper
title: Vysper Using the test client
---

# Using the test client

The test clients builds on the XMPP client library Smack.
It takes two parameters:

* login name for the 'from' user
* login name for the 'to' user

The domain is assumed to be 'vysper.org', the password to be 'password1'.
This relates to the default users correctly configured in the default spring configuration file.

The client logs into the server with the 'from' user login and starts to send messages to the 'to' user.

The client is invoked similar to the server like this:

```bash
java org.apache.vysper.smack.BasicClient user1 user2
```
