---
type: vysper
title: Vysper Documentation
---

## What is it?

Apache Vysper aims to be a full blown [XMPP](http://www.xmpp.org/) (=eXtensible Messaging and Presence Protocol) server.
The core of XMPP is defined in the standards [RFC3920](http://www.ietf.org/rfc/rfc3920.txt) and [RFC3921](http://www.ietf.org/rfc/rfc3921.txt).

XMPP is more commonly known as 'Jabber'.

## XMPP Specifications

A [list of the implementation status](standards_supported.html) of the various specifications are available.

## Architecture

* [XML Processing](xml_processing.html)
* [Stanza processing](stanza_processing_layer.html)
* [User authentication and management](user_mgmt.html)

## Using the server

Apache Vysper can run stand-alone or [embedded into another application](embed.html)
It should work with any [compliant XMPP client](http://en.wikipedia.org/wiki/List_of_Jabber_client_software).
A [test client](test_client.html) is included with the project.

## Modules/endpoints

Here you can find documentation for using some of the Vysper extensions. Modules usually implement different XEP specifications, while Endpoints implement network protocols.

* [Server-to-server connections](server_to_server_comm.html)
* [SOCKS5 bytestream module](socks5.html)
* [Websockets endpoint](websocket_endpoint.html)
