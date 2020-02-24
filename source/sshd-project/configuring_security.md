---
type: sshd
title: SSHD Configuring Security
---

## Configuring Security

The SSHD server needs to be integrated and the security layer has to be customized to suit your needs.
This layer is pluggable and use the following interfaces:

* [PasswordAuthenticator](http://svn.apache.org/repos/asf/mina/sshd/trunk/sshd-core/src/main/java/org/apache/sshd/server/PasswordAuthenticator.java) for password based authentication
* [PublickeyAuthenticator](http://svn.apache.org/repos/asf/mina/sshd/trunk/sshd-core/src/main/java/org/apache/sshd/server/PublickeyAuthenticator.java) for key based authentication

Those custom classes can be configured on the SSHD server using the following code:

```java
SshServer sshd = SshServer.setUpDefaultServer();
sshd.setPasswordAuthenticator(new MyPasswordAuthenticator());
sshd.setPublickeyAuthenticator(new MyPublickeyAuthenticator());
```

If only one of those class is implemented, only the related authentication mechanism will be enabled.

## JAAS integration

SSHD provides a password based authentication that delegates to JAAS.
This can be configured in the following way:

```java
SshServer sshd = SshServer.setUpDefaultServer();
JaasPasswordAuthenticator pswdAuth = new JaasPasswordAuthenticator();
pswdAuth.setDomain("myJaasDomain");
sshd.setPasswordAuthenticator(pswdAuth);
```

The domain name must be set to the JAAS domain that will be used for authentication.
