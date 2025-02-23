---
type: ftpserver
title: FtpServer Listeners
---

# Listeners

Listeners are the component in FtpServer which is responsible for listening on the network socket and when clients connect create the user session, execute commands and so on. An FtpServer can have multiple listeners at the same time, some examples include:

* one listener on port 21 (the default option)
* one cleartext listener on port 21 and one for implicit SSL on port 22
* one cleartext listener in an internal IP address only and one for implicit SSL for the external IP address

Listeners are identified by a name, the default listener is identified by "default".

The main network configuration is performed on the listeners, for example the port to listen on and SSL configuration.

Within the XML configuration format, all listeners are configured in the "listeners" element. A XML configuration example can therefore look like:

```xml
<listeners>
    <nio-listener name="default" port="2222" implicit-ssl="true" idle-timeout="60" local-address="1.2.3.4">
        <ssl>
            <keystore file="mykeystore.jks" password="secret" key-password="otherSecret" />
            <truststore file="mytruststore.jks" password="secret"/>
        </ssl>
        <data-connection idle-timeout="60">
            <active enabled="true" local-address="1.2.3.4" local-port="2323" ip-check="true">
            <passive ports="123-12" address="1.2.3.4" external-address="1.2.3.4" />
        </data-connection>
        <blacklist>1.2.3.0/16, 1.2.4.0/16, 1.2.3.4</blacklist>
    </nio-listener>
</listeners>
```

## nio-listener element

The listener shipped with FtpServer is called "nio-listener" since it is based Java NIO for performance and scalability.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| name | The listener name, if "default" it will override the settings on the default listener | Yes | {{< html "&nbsp;" >}} |
| port | The port on which the listener will accept connections | No | 21 |
| local-address | Server address the listener will bind to | No | All available |
| implicit-ssl | True if the listener should use implicit SSL | No | false |
| idle-timeout | The number of seconds before an inactive client is disconnected. If this value is set to 0, the idle time is disabled (a client can idle forever without getting disconnected by the server). If a lower maximum idle time is configured on a user (e.g. using the PropertiesUserManager idletime configuration), it will override the listener value. Thus, the listener value enforce the upper threshold, but lower values can be provided per user. | No | 300 |

## ssl element

Required for listeners that should provide FTPS support.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| protocol | The SSL protocol to use. Supported values are "SSL" and "TLS" | No | TLS |
|client-authentication | Should client authentication be performed? Supported values are "NEED", "WANT" and "NONE" | No | NONE |
| enabled-ciphersuites | A space-separated list of cipher suites to enable for this connection. The exact cipher suites that can be used depends on the Java version used, [here](http://java.sun.com/j2se/1.5.0/docs/guide/security/jsse/JSSERefGuide.html#AppA) are the names for Sun's JSSE provider. | No | All cipher suites are enabled |

## keystore element

This element is required if the ssl element is provided. It provides configuration for the key store used for finding the private key and server certificate for the FTP server.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| file | Path to the key store file | Yes | {{< html "&nbsp;" >}} |
| password | The password for the key store | Yes | {{< html "&nbsp;" >}} |
| key-password | Password for the key within the key store | No | Key store password |
| key-alias | Alias of the key to use within the key store | No <| Uses first key found |
| type | Key store type | No | JRE key store default type, normally JKS |
| algorithm | Key store algorithm | No | SunX509 |
## truststore element

This element provides configuration for the trust store used for locating trusted certificates.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| file | Path to the trust store file | Yes | {{< html "&nbsp;" >}} |
| password | The password for the trust store | No | Certificates can be read without password |
| type | Trust store type | No | JRE key store default type, normally JKS |
| algorithm | Trust store algorithm | No | SunX509 |>

## data-connection element

This element provides configuration for the data connection.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| idle-timeout | Number of seconds before an idle data connection is closed | No | 300 |

## active element

This element provides configuration for active data connections.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| enabled | False if active data connections should not be allowed | No | true |
| local-address | The local address the server will use when creating a data connection | No | Any available |
| local-port | The local prt the server will use when creating a data connection | No | Any available |
| ip-check | Should the server check that the IP address for the data connection is the same as for the control socket? | No | false |


## passive element

This element provides configuration for passive data connections.

| Attribute | Description | Required | Default value |
|---|---|---|---|
| ports| The ports on which the server is allowed to accept passive data connections, see [Configure passive ports](configuration_passive_ports.html) for details| No| Any available port |
| address| The address on which the server will listen to passive data connections| No| The same address as the control socket for the session |
| external-address| The address the server will claim to be listening on in the PASV reply. Useful when the server is behind a NAT firewall and the client sees a different address than the server is using | No | {{< html "&nbsp;" >}} |

## blacklist element

This element provides a list of black listed IP addresses and networks in [CIDR notation](http://en.wikipedia.org/wiki/CIDR).
