---
type: vysper
title: Vysper XM Processing
---

# XML Processing

XML data is the payload of the XMPP protocol. More precisely, XMPP only works on a subset of XML. See RFC3920 for details.

The core handler and protocol code does not deal with xml strings directly. They only deal with java objects representing well-formed XMPP commands, called stanzas.

To create these objects, the actual XML is processed in stages at the xml processing layer.

While raw XML continues streaming in, we are faced with arbitrary partitioned stanza and even partial xml. We have to determine the end of a stanza to process it.
A stanza can go over multiple lines so the line end is not a useful indicator for command boundaries. We have to check for the stanza's closing element.

What we do is every time new characters arrive in the character stream, we cut what we got into two kinds of fragments, those starting with < and ending with >, and those containing all the characters in between > and <. These fragments are analyzed if they could result in balanced xml. If not, we wait for more data to come.

At the next stage, fragments are more extensively parsed and if everything works out fine, a Stanza java object is constructed from it and forwarded to the [stanza processing layer](stanza_processing_layer.html).
