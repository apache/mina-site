---
type: sshd
title: Apache SSHD 2.13.0 Release
---

# Overview

Apache Mina SSHD 2.13.0 contains a number of enhancements and bug-fixes. See the lists at 
the [GitHub issue tracker](https://github.com/apache/mina-sshd/issues?q=milestone%3A2.13.0).


## Bug Fixes

* [GH-318](https://github.com/apache/mina-sshd/issues/318) Handle cascaded proxy jumps
* [GH-427](https://github.com/apache/mina-sshd/issues/427) SCP client: fix `DefaultScpClient.upload(InputStream, ...)`
* [GH-455](https://github.com/apache/mina-sshd/issues/455) Fix `BaseCipher`: make sure all bytes are processed
* [GH-461](https://github.com/apache/mina-sshd/issues/461) Fix heartbeats with `wantReply=true`
* [GH-470](https://github.com/apache/mina-sshd/issues/470) MontgomeryCurve: synchronize access to KeyPairGenerator
* [GH-489](https://github.com/apache/mina-sshd/issues/489) SFTP v3 client: better file type determination
* [GH-493](https://github.com/apache/mina-sshd/issues/493) Fix arcfour128 and arcfour256 ciphers (regression in 2.2.0)
* [GH-500](https://github.com/apache/mina-sshd/issues/500) SFTP file system: fix memory leak on exceptions
* [GH-504](https://github.com/apache/mina-sshd/issues/504) Pass through failure exception to `SessionListener.sessionNegotiationEnd()`
* [GH-509](https://github.com/apache/mina-sshd/issues/509) SFTP v[456] client: validate attribute flags
* [GH-510](https://github.com/apache/mina-sshd/issues/510) Fix class name in BuiltinIoServiceFactoryFactories (regression in 2.6.0)

* [PR-472](https://github.com/apache/mina-sshd/pull/472) sshd-spring-sftp: fix client start
* [PR-476](https://github.com/apache/mina-sshd/pull/476) Fix Android detection
* [PR-486](https://github.com/apache/mina-sshd/pull/486) Add missing `equals` and `hashCode` to U2F key classes


* [SSHD-1237](https://issues.apache.org/jira/browse/SSHD-1237) Handle keep-alive _channel_ requests

## New Features

### `sntrup761x25519-sha512@openssh.com` Key Exchange

The key exchange method sntrup761x25519-sha512@openssh.com is now available if the Bouncy Castle library is available.

This uses a post-quantum key encapsulation method (KEM) to make key exchange future-proof against quantum attacks.
More information can be found in IETF Memo [Secure Shell (SSH) Key Exchange Method Using Hybrid Streamlined NTRU Prime sntrup761 and X25519 with SHA-512: sntrup761x25519-sha512](https://www.ietf.org/archive/id/draft-josefsson-ntruprime-ssh-02.html).


## Behavioral changes and enhancements

### [GH-318](https://github.com/apache/mina-sshd/issues/318) Handle cascaded proxy jumps

Proxy jumps can be configured via host configuration entries in two ways. First, proxies can be _chained_
directly by specifiying several proxies in one `ProxyJump` directive:

```
Host target
Hostname somewhere.example.org
User some_user
IdentityFile ~/.ssh/some_id
ProxyJump jumphost2, jumphost1

Host jumphost1
Hostname jumphost1@example.org
User jumphost1_user
IdentityFile ~/.ssh/id_jumphost1

Host jumphost2
Hostname jumphost2@example.org
User jumphost2_user
IdentityFile ~/.ssh/id_jumphost2
```

Connecting to server `target` will first connect to `jumphost1`, then tunnel through to `jumphost2`, and finally
tunnel to `target`. So the full connection will be `client`&rarr;`jumphost1`&rarr;`jumphost2`&rarr;`target`.

Such proxy jump chains were already supported in Apache MINA SSHD.

Newly, Apache MINA SSHD also supports _cascading_ proxy jumps, so a configuration like

```
Host target
Hostname somewhere.example.org
User some_user
IdentityFile ~/.ssh/some_id
ProxyJump jumphost2

Host jumphost1
Hostname jumphost1@example.org
User jumphost1_user
IdentityFile ~/.ssh/id_jumphost1

Host jumphost2
Hostname jumphost2@example.org
ProxyJump jumphost1
User jumphost2_user
IdentityFile ~/.ssh/id_jumphost2
```

also works now, and produces the same connection `client`&rarr;`jumphost1`&rarr;`jumphost2`&rarr;`target`.

It is possible to mis-configure such proxy jump cascades to have loops. (For instance, if host `jumphost1` in
the above example had a `ProxyJump jumphost2` directive.) To catch such misconfigurations, Apache MINA SSHD
imposes an upper limit on the total number of proxy jumps in a connection. An exception is thrown if there
are more than `CoreModuleProperties.MAX_PROXY_JUMPS` proxy jumps in a connection. The default value of this
property is 10. Most real uses of proxy jumps will have one or maybe two proxy jumps only.

### [GH-461](https://github.com/apache/mina-sshd/issues/461) Fix heartbeats with `wantReply=true`

The client-side heartbeat mechanism has been updated. Such heartbeats are configured via the
`CoreModuleProperties.HEARTBEAT_INTERVAL` property. If this interval is > 0, heartbeats are sent to
the server.

Previously these heartbeats could also be configured with a `CoreModuleProperties.HEARTBEAT_REPLY_WAIT`
timeout. If the timeout was <= 0, the client would just send heartbeat requests without expecting any
answers. If the timeout was > 0, the client would send requests with a flag indicating that the server
should reply. The client would then wait for the specified duration for the reply and would terminate
the connection if none was received.

This mechanism could cause trouble if the timeout was fairly long and the server was slow to respond.
A timeout longer than the interval could also delay subsequent heartbeats.

The `CoreModuleProperties.HEARTBEAT_REPLY_WAIT` property is now _deprecated_.

There is a new configuration property `CoreModuleProperties.HEARTBEAT_NO_REPLY_MAX` instead. It defines a
limit for the number of heartbeats sent without receiving a reply before a session is terminated. If
the value is <= 0, the client still sends heartbeats without expecting any reply. If the value is > 0,
the client will request a reply from the server for each heartbeat message, and it will
terminate the connection if the number of unanswered heartbeats reaches
`CoreModuleProperties.HEARTBEAT_NO_REPLY_MAX`.

This new way to configure heartbeats aligns with the OpenSSH configuration options
`ServerAliveInterval` and `ServerAliveCountMax`.

For compatibility with older configurations that explicitly define `CoreModuleProperties.HEARTBEAT_REPLY_WAIT`,
the new code maps this to the new configuration (but only if `CoreModuleProperties.HEARTBEAT_INTERVAL` > 0
and the new property `CoreModuleProperties.HEARTBEAT_NO_REPLY_MAX` has _not_ been set) by setting
`CoreModuleProperties.HEARTBEAT_NO_REPLY_MAX` to
* `CoreModuleProperties.HEARTBEAT_REPLY_WAIT` <= 0: `CoreModuleProperties.HEARTBEAT_NO_REPLY_MAX = 0`
* otherwise: `(CoreModuleProperties.HEARTBEAT_REPLY_WAIT / CoreModuleProperties.HEARTBEAT_INTERVAL) + 1`.

### [GH-468](https://github.com/apache/mina-sshd/issues/468) SFTP: validate length of data received: must not be more than requested

SFTP read operations now check the amount of data they get back. If it's more than
requested an exception is thrown. SFTP servers must never return more data than the
client requested, but it appears that there are some that do so. If property
`SftpModuleProperties.TOLERATE_EXCESS_DATA` is set to `true`, a warning is logged and
such excess data is silently discarded.

## Potential compatibility issues

### AES-CBC ciphers removed from server's defaults

The AES-CBC ciphers `aes128-cbc`, `aes192-cbc`, and `aes256-cbc` have been removed from the default
list of cipher algorithms that a server proposes in the key exchange. OpenSSH has removed these
cipher algorithms from the server proposal in 2014, and has removed them from the client proposal
in 2017.

The cipher implementations still exist but they are not enabled by default. Existing code that
explicitly sets the cipher factories is unaffected. Code that relies on the default settings
will newly create a server that does not support the CBC-mode ciphers. To enable the CBC-mode
ciphers, one can use for instance

```
SshServer server = ServerBuilder.builder()
   ...
   .cipherFactories(BuiltinFactory.setUpFactories(false, BaseBuilder.DEFAULT_CIPHERS_PREFERENCES));
   ...
   .build();
```

For the SSH _client_, the CBC ciphers are still enabled by default to facilitate connecting to
legacy servers. We plan to remove the CBC ciphers from the client's defaults in the next release.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 2.13.0 Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.13.0/apache-sshd-2.13.0-src.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0-src.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0-src.tar.gz.sha512)
    * [Apache Mina SSHD 2.13.0 Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.13.0/apache-sshd-2.13.0-src.zip) [PGP](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0-src.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD 2.13.0 Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.13.0/apache-sshd-2.13.0.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0.tar.gz.sha512)
    * [Apache Mina SSHD 2.13.0 Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.13.0/apache-sshd-2.13.0.zip) [PGP](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.13.0/apache-sshd-2.13.0.zip.sha512)

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
