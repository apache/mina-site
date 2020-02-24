---
type: vysper
title: Vysper Extending the Server
---

# How to extend the server functionality

## XMPP support for extensions

[XMPP](http://www.xmpp.org/) provides a bunch of already specified extensions. See <http://www.xmpp.org/extensions> for a complete list.

XMPP also allows for custom extensions of the core stanza types 'message', 'iq' and 'presence'. All XMPP clients and servers should be able to savely ignore them unless they are able to deal with them. See the [relevant specification chapter](http://www.xmpp.org/internet-drafts/draft-saintandre-rfc3920bis-05.html#stanzas-extended).

Most XMPP extensions rely on Disco (Service Discovery, XEP-0030).
It's easy to integrate modules with Vysper's Disco extension.

Most XMPP extensions rely on Disco ([Service Discovery, XEP-0030](http://xmpp.org/extensions/xep-0030.html)).
It's easy to integrate modules with [Vysper's Disco extension](service_discovery.html).

## Modules

Regardless which kind of extension it is (Vysper internal, XMPP standardized or home-brewn) they all can be deployed using the Vysper Modules.

Vysper Modules are implementations of interface org.apache.vysper.xmpp.modules.Module, but it is probably more convenient to extend DefaultModule. Modules supporting disco should extend DefaultDiscoAwareModule.

An example of a Vysper-internal module is org.apache.vysper.xmpp.modules.roster.RosterModule.

## Handlers and Dictionaries

Every incoming stanza is processed by one dedicated StanzaHandler instance. For implementing a new functionality, we'd have to code new StanzaHandlers. They are registered with the server. The server introspects the stanza and decides which handler is tailored for it by basically looking at the stanza name ('message'/'iq'/'presence') and the namespace attributes ('xmlns') on the top and first-child XML elements.

Dictionary objects are used to compile handlers for the same namespace.

## A custom handler

It is highly recommended that custom handlers do subclass

* org.apache.vysper.xmpp.modules.core.base.handler.DefaultIQHandler
* org.apache.vysper.xmpp.modules.core.base.handler.MessageHandler
* org.apache.vysper.xmpp.modules.core.im.handler.PresenceHandler

## Activate a module in the server

Modules are registered with the server calling ServerRuntimeContext.addModule(Module module).

Using spring-config.xml, they are configured in bean 'server'. Simply add a new bean for the module to the config. Then add a bean reference to property 'modules' list in 'server'. On server startup, these modules are loaded and activated.
