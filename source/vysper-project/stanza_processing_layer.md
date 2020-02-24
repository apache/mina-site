---
type: vysper
title: Vysper Stanza Processing
---

# Stanza Processing

Commands in the XMPP world are called Stanzas.

At the transport layer, when going over the net between client and server, they have a textual representation in XML.

In Vysper, the Stanza processing layer only deals with Stanza java objects. They are created by the transport layer, or using Builder utility classes from within Vysper. That makes this layer independent from any underlying transport layer. Stanzas are directly injectable on this level. This helps when testing. It makes accessing specific stanza elements easier.

Every Stanza is processed in the context of a Session and a Server. The general approach is comparable to the Servlet architecture.
A Session has a state which indicates how far the process of stream negotiation has advanced. The protocol worker determines that the incoming stanza can be processed, depending on the session state. Otherwise, an stream error is returned. For example, Message stanzas can only be compliantly processed after the session is bound to a resource.

In the next step, the protocol worker searches for the right Stanza Handler. This often requires inspecting the Stanza,
The handler incorporates the actual command execution logic.
