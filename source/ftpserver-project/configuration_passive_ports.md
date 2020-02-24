---
type: ftpserver
title: FtpServer Configure passive ports
---

# Configure passive ports

When the client wants to use a passive data connection, the server should provide the port to use. By default, FtpServer will choose any available port. However this can be overridden using the configuration for the [passive data connection](configuration_listeners.html). The allowed passive ports can then be specified as a single port (e.g. 20020), multiple ports (e.g. 20020, 20030, 20040) or a range of ports (e.g. 20020-20030). Ranges can be closed (e.g. 20020-20030) or open ended (e.g. 60000-). Open ended ranges start at 1 and end at 65535, that is, the range 60000- will allow all ports between 60000 and 65535. Any combination of specified values or ranges can be used.

When the server has used up all passive ports (one per client doing passive data transfer), the next clients will have to wait for an available port. It is therefore advised to provide multiple passive ports.

If a value (specific port or start or end of an range) is outside of the allowed values of 0 and 65535, an error will be thrown at startup.

## Examples:

|   |   |
|---|---|
| 0 | Any available port is used as the passive port |
| 123 | Port 123 will be used as the passive port |
| 123,133 | Port 123 and 133 will be used as the passive port |
| 123-125 | Any port in a range from 123 to 125 will be used as the passive port |
| 123-125, 127, 129-130 | Any port in a range from 123 to 125, port 127 or in the range from 129 to 130 will be used as the passive port |
