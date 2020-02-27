---
type: vysper
title: Vysper Service Discovery
---

# Using Service Discovery

## Disco quick start

Service Discovery (or 'disco') is a XMPP extensions specified at (Service Discovery, XEP-0030).

Disco resembles Directory services like LDAP, or even file systems.

Disco is a server-side service. It maintains a tree of nodes (branches) and items (leafs). Clients discover child nodes and items of the root node or some other already discovered node by sending info-requests (IQ stanzas).
The server replies with a IQ response containing a list of nodes and items.

## Using disco

In Vysper, Disco is itself implemented as a module (making it easy to swap disco implementations). The disco module must be loaded to link into it.

Any module can publish its own features, nodes and items through disco to become 'discoverable' by clients and other servers and to expose 'stuff', whatever makes sense for that module.

It is highly recommended that modules supporting disco extend DefaultDiscoAwareModule, which provides convenient integration with disco.

Via DefaultDiscoAwareModule overrides, modules can register listeners for disco requests. If applicable, they simply add their part to the response. So, the disco-aware module has full control over the stuff it exposes.

## The most simple form of disco is to advertise a feature. Clients knowing about that feature can then use it, for example by adding special payload to stanzas, by interacting with the module through dedicated stanzas or by using more disco.

This is how a feature is advertised in the XEP-0092 implementation:

```java
public class SoftwareVersionModule extends DefaultDiscoAwareModule implements ServerInfoRequestListener { 
    @Override 
    protected void addServerInfoRequestListeners(List<ServerInfoRequestListener> serverInfoRequestListeners) { 
        serverInfoRequestListeners.add(this); 
    } 

    public List<InfoElement> getServerInfosFor(InfoRequest request) { 
        List<InfoElement> infoElements = new ArrayList<InfoElement>(); 
        infoElements.add(new Feature(NamespaceURIs.JABBER_IQ_VERSION)); 
        return infoElements; 
    } 
}
```

At init time, the listener is registered, which is the module class itself ("this").
On every disco request occurring on server level, disco calls the listener via getServerInfosFor(), and the module advertises its support for XEP-0092. Please note that in an advanced scenario, we can make the module's behavior depending on the properties of the InfoRequest parameter.

## Item and Info discovery

They work similar, with similar listeners and callback.
TODO: elaborate!
