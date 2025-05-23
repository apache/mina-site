---
type: sshd
title: Apache SSHD 2.14.0 Release
---

# Overview

## Bug Fixes

* [GH-524](https://github.com/apache/mina-sshd/issues/524) Performance improvements
* [GH-533](https://github.com/apache/mina-sshd/issues/533) Fix multi-step authentication
* [GH-582](https://github.com/apache/mina-sshd/issues/582) Fix filtering in `NamedFactory`
* [GH-587](https://github.com/apache/mina-sshd/issues/587) Prevent `NullPointerException`on closed channel in `NettyIoSession`
* [GH-590](https://github.com/apache/mina-sshd/issues/590) Better support for FIPS
* [GH-597](https://github.com/apache/mina-sshd/issues/597) Pass on `Charset` in `ClientSession.executeRemoteCommand()`

## New Features

* New utility methods `SftpClient.put(Path localFile, String remoteFileName)` and
  `SftpClient.put(InputStream in, String remoteFileName)` facilitate SFTP file uploading.

### [GH-590](https://github.com/apache/mina-sshd/issues/590) Better support for FIPS

Besides fixing a bug with bc-fips (the `RandomGenerator` class exists in normal Bouncy Castle,
but not in the FIPS version, but Apache MINA sshd referenced it even if only bc-fips was present),
support was improved for running in an environment restricted by FIPS.

There is a new system property `org.apache.sshd.security.fipsEnabled`. If set to `true`, a number
of crypto-algorithms not approved by FIPS 140 are disabled:

* key exchange methods sntrup761x25519-sha512, sntrup761x25519-sha512<!-- -->@openssh.com, curve25519-sha256, curve25519-sha256<!-- -->@libssh.org, curve448-sha512.
* the chacha20-poly1305 cipher.
* the bcrypt KDF used in encrypted private key files in [OpenSSH format](https://github.com/openssh/openssh-portable/blob/master/PROTOCOL.key).
* all ed25519 keys and signatures.

Additionally, the new "SunJCEWrapper" `SecurityProviderRegistrar` (see below) and the
`EdDSASecurityProviderRegistrar` are disabled, and the `BouncyCastleScurityProviderRegistrar`
looks only for the "BCFIPS" security provider, not for the normal "BC" provider.

If the system property is _not_ set to `true`, FIPS mode can be enabled programmatically
by calling `SecurityUtils.setFipsMode()` before any other call to Apache MINA sshd.

## Potential compatibility issues

### New security provider registrar
There is a new `SecurityProviderRegistrar` that is registered by default
if there is a `SunJCE` security provider. It uses the AES and
HmacSHA* implementations from `SunJCE` even if Bouncy Castle is also
registered. `SunJCE` has native implementations, whereas Bouncy Castle
may not.

The new registrar has the name "SunJCEWrapper" and can be configured
like any other registrar. It can be disabled via the system property
`org.apache.sshd.security.provider.SunJCEWrapper.enabled=false`. It is also
disabled in FIPS mode (see above).

### [GH-582](https://github.com/apache/mina-sshd/issues/582) Fix filtering in `NamedFactory`

The methods `NamedFactory.setupBuiltinFactories(boolean ignoreUnsupported, ...)` and
`NamedFactory.setupTransformedFactories(boolean ignoreUnsupported, ...)` had a bug that
gave the "ignoreUnsupported" parameter actually the meaning of "include unsupported".

This was fixed in this release, but existing code calling these or one of the following methods:

* `BaseBuilder.setUpDefaultMacs(boolean ignoreUnsupported)`
* `BaseBuilder.setUpDefaultCiphers(boolean ignoreUnsupported)`
* `ClientBuilder.setUpDefaultCompressionFactories(boolean ignoreUnsupported)`
* `ClientBuilder.setUpDefaultKeyExchanges(boolean ignoreUnsupported)`
* `ClientBuilder.setUpDefaultSignatureFactories(boolean ignoreUnsupported)`
* `ServerBuilder.setUpDefaultCompressionFactories(boolean ignoreUnsupported)`
* `ServerBuilder.setUpDefaultKeyExchanges(boolean ignoreUnsupported)`
* `ServerBuilder.setUpDefaultSignatureFactories(boolean ignoreUnsupported)`
* any of the methods starting with `SshConfigFileReader.configure`
* `SshClientConfigFileReader.configure(...)`
* `SshServerConfigFileReader.configure(...)`

should be reviewed:

* if the method is called with parameter value `true`, the result will no longer include unsupported algorithms. Formerly it wrongly did.
* if the method is called with parameter value `false`, the result may include unsupported algorithms. Formerly it did not.

So if existing code used parameter value `false` to ensure it never got unsupported algorithms, change it to `true`.

## Major Code Re-factoring

### JDK requirements

* [GH-536](https://github.com/apache/mina-sshd/issues/536) The project now requires
  JDK 17 at build time, while the target runtime still remains unchanged to support JDK 8.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD 2.14.0 Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.14.0/apache-sshd-2.14.0-src.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0-src.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0-src.tar.gz.sha512)
    * [Apache Mina SSHD 2.14.0 Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.14.0/apache-sshd-2.14.0-src.zip) [PGP](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0-src.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD 2.14.0 Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.14.0/apache-sshd-2.14.0.tar.gz) [PGP](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0.tar.gz.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0.tar.gz.sha512)
    * [Apache Mina SSHD 2.14.0 Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/2.14.0/apache-sshd-2.14.0.zip) [PGP](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0.zip.asc) [SHA512](https://www.apache.org/dist/mina/sshd/2.14.0/apache-sshd-2.14.0.zip.sha512)

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
