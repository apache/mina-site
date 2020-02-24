---
type: mina
title: Chapter 9 - Codec Filter
navPrev: ../ch8-iobuffer/ch8-iobuffer.html
navPrevText: Chapter 8 - IoBuffer
navUp: ../user-guide-toc.html
navUpText: User Guide
navNext: ../ch10-executor-filter/ch10-executor-filter.html
navNextText: Chapter 10 - Executor Filter
---

# Chapter 9 - Codec Filter

This tutorial tries to explain why and how to use a ProtocolCodecFilter.

## Why use a ProtocolCodecFilter?

* TCP guarantees delivery of all packets in the correct order.
But there is no guarantee that one write operation on the sender-side will result in one read event on the receiving side.
see <http://en.wikipedia.org/wiki/IPv4#Fragmentation_and_reassembly> and <http://en.wikipedia.org/wiki/Nagle%27s_algorithm>
In MINA terminology: without a ProtocolCodecFilter one call of IoSession.write(Object message) by the sender can result in multiple messageReceived(IoSession session, Object message) events on the receiver; and multiple calls of IoSession.write(Object message) can lead to a single messageReceived event. You might not encounter this behavior when client and server are running on the same host (or an a local network) but your applications should be able to cope with this.
* Most network applications need a way to find out where the current message ends and where the next message starts.
* You could implement all this logic in your IoHandler, but adding a ProtocolCodecFilter will make your code much cleaner and easier to maintain.
* It allows you to separate your protocol logic from your business logic (IoHandler).

## How ?

Your application is basically just receiving a bunch of bytes and you need to convert these bytes into messages (higher level objects).

There are three common techniques for splitting the stream of bytes into messages:

* use fixed length messages
* use a fixed length header that indicates the length of the body
* using a delimiter; for example many text-based protocols append a newline (or CR LF pair) after every message (<http://www.faqs.org/rfcs/rfc977.html>)

In this tutorial we will use the first and second method since they are definitely easier to implement. Afterwards we will look at using a delimiter.

## Example

We will develop a (pretty useless) graphical chargen server to illustrate how to implement your own protocol codec (ProtocolEncoder, ProtocolDecoder, and ProtocolCodecFactory).
The protocol is really simple. This is the layout of a request message:

| 4 bytes | 4 bytes | 4 bytes |
|---|---|---|
| width | height | numchars |

* width: the width of the requested image (an integer in network byte-order)
* height: the height of the requested image (an integer in network byte-order)
* numchars: the number of chars to generate (an integer in network byte-order)

The server responds with two images of the requested dimensions, with the requested number of characters painted on it.
This is the layout of a response message:

| 4 bytes | variable length body | 4 bytes | variable length body | 
|---|---|---|---|
| length1 | image1 | length2 | image2 | 

Overview of the classes we need for encoding and decoding requests and responses:

 * __ImageRequest__: a simple POJO representing a request to our ImageServer.
 * __ImageRequestEncoder__: encodes ImageRequest objects into protocol-specific data (used by the client)
 * __ImageRequestDecoder__: decodes protocol-specific data into ImageRequest objects (used by the server)
 * __ImageResponse__: a simple POJO representing a response from our ImageServer.
 * __ImageResponseEncoder__: used by the server for encoding ImageResponse objects
 * __ImageResponseDecoder__: used by the client for decoding ImageResponse objects
 * __ImageCodecFactory__: this class creates the necessary encoders and decoders

 Here is the ImageRequest class :

```java
public class ImageRequest {
    
    private int width;
    private int height;
    private int numberOfCharacters;
    
    public ImageRequest(int width, int height, int numberOfCharacters) {
        this.width = width;
        this.height = height;
        this.numberOfCharacters = numberOfCharacters;
    }
    
    public int getWidth() {
        return width;
    }
    
    public int getHeight() {
        return height;
    }
    
    public int getNumberOfCharacters() {
        return numberOfCharacters;
    }
}
```

Encoding is usually simpler than decoding, so let's start with the ImageRequestEncoder:

```java
public class ImageRequestEncoder implements ProtocolEncoder {
    
    public void encode(IoSession session, Object message, ProtocolEncoderOutput out) throws Exception {
        ImageRequest request = (ImageRequest) message;
        IoBuffer buffer = IoBuffer.allocate(12, false);
        buffer.putInt(request.getWidth());
        buffer.putInt(request.getHeight());
        buffer.putInt(request.getNumberOfCharacters());
        buffer.flip();
        out.write(buffer);
    }
    
    public void dispose(IoSession session) throws Exception {
        // nothing to dispose
    }
}
```

Remarks:

* MINA will call the encode function for all messages in the IoSession's write queue. Since our client will only write ImageRequest objects, we can safely cast message to ImageRequest.
* We allocate a new IoBuffer from the heap. It's best to avoid using direct buffers, since generally heap buffers perform better.
 see <http://issues.apache.org/jira/browse/DIRMINA-289>)
* You do not have to release the buffer, MINA will do it for you, see <http://mina.apache.org/mina-project/apidocs/org/apache/mina/core/buffer/IoBuffer.html>
* In the dispose() method you should release all resources acquired during encoding for the specified session. If there is nothing to dispose you could let your encoder inherit from ProtocolEncoderAdapter.

Now let's have a look at the decoder. The CumulativeProtocolDecoder is a great help for writing your own decoder: it will buffer all incoming data until your decoder decides it can do something with it.
In this case the message has a fixed size, so it's easiest to wait until all data is available:

```java
public class ImageRequestDecoder extends CumulativeProtocolDecoder {
    
    protected boolean doDecode(IoSession session, IoBuffer in, ProtocolDecoderOutput out) throws Exception {
        if (in.remaining() >= 12) {
            int width = in.getInt();
            int height = in.getInt();
            int numberOfCharachters = in.getInt();
            ImageRequest request = new ImageRequest(width, height, numberOfCharachters);
            out.write(request);
            return true;
        } else {
            return false;
        }
    }
}
```

Remarks:

* every time a complete message is decoded, you should write it to the ProtocolDecoderOutput; these messages will travel along the filter-chain and eventually arrive in your IoHandler.messageReceived method
* you are not responsible for releasing the IoBuffer
* when there is not enough data available to decode a message, just return false

The response is also a very simple POJO:

```java
public class ImageResponse {
    
    private BufferedImage image1;
    
    private BufferedImage image2;
    
    public ImageResponse(BufferedImage image1, BufferedImage image2) {
        this.image1 = image1;
        this.image2 = image2;
    }
    
    public BufferedImage getImage1() {
        return image1;
    }
    
    public BufferedImage getImage2() {
        return image2;
    }
}
```

Encoding the response is also trivial:

```java
public class ImageResponseEncoder extends ProtocolEncoderAdapter {
    
    public void encode(IoSession session, Object message, ProtocolEncoderOutput out) throws Exception {
        ImageResponse imageResponse = (ImageResponse) message;
        byte[] bytes1 = getBytes(imageResponse.getImage1());
        byte[] bytes2 = getBytes(imageResponse.getImage2());
        int capacity = bytes1.length + bytes2.length + 8;
        IoBuffer buffer = IoBuffer.allocate(capacity, false);
        buffer.setAutoExpand(true);
        buffer.putInt(bytes1.length);
        buffer.put(bytes1);
        buffer.putInt(bytes2.length);
        buffer.put(bytes2);
        buffer.flip();
        out.write(buffer);
    }
    
    private byte[] getBytes(BufferedImage image) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "PNG", baos);
        return baos.toByteArray();
    }
}
```

Remarks:

* when it is impossible to calculate the length of the IoBuffer beforehand, you can use an auto-expanding buffer by calling buffer.setAutoExpand(true);

Now let's have a look at decoding the response:

```java
public class ImageResponseDecoder extends CumulativeProtocolDecoder {
    
    private static final String DECODER_STATE_KEY = ImageResponseDecoder.class.getName() + ".STATE";
    
    public static final int MAX_IMAGE_SIZE = 5 * 1024 * 1024;
    
    private static class DecoderState {
        BufferedImage image1;
    }
    
    protected boolean doDecode(IoSession session, IoBuffer in, ProtocolDecoderOutput out) throws Exception {
        DecoderState decoderState = (DecoderState) session.getAttribute(DECODER_STATE_KEY);
        if (decoderState == null) {
            decoderState = new DecoderState();
            session.setAttribute(DECODER_STATE_KEY, decoderState);
        }
        if (decoderState.image1 == null) {
            // try to read first image
            if (in.prefixedDataAvailable(4, MAX_IMAGE_SIZE)) {
                decoderState.image1 = readImage(in);
            } else {
                // not enough data available to read first image
                return false;
            }
        }
        if (decoderState.image1 != null) {
            // try to read second image
            if (in.prefixedDataAvailable(4, MAX_IMAGE_SIZE)) {
                BufferedImage image2 = readImage(in);
                ImageResponse imageResponse = new ImageResponse(decoderState.image1, image2);
                out.write(imageResponse);
                decoderState.image1 = null;
                return true;
            } else {
                // not enough data available to read second image
                return false;
            }
        }
        return false;
    }
    
    private BufferedImage readImage(IoBuffer in) throws IOException {
        int length = in.getInt();
        byte[] bytes = new byte[length];
        in.get(bytes);
        ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        return ImageIO.read(bais);
    }
}
```

Remarks:

* We store the state of the decoding process in a session attribute. It would also be possible to store this state in the Decoder object itself but this has several disadvantages:
    * every IoSession would need its own Decoder instance
    * MINA ensures that there will never be more than one thread simultaneously executing the decode() function for the same IoSession, but it does not guarantee that it will always be the same thread. Suppose the first piece of data is handled by thread-1 who decides it cannot yet decode, when the next piece of data arrives, it could be handled by another thread. To avoid visibility problems, you must properly synchronize access to this decoder state (IoSession attributes are stored in a ConcurrentHashMap, so they are automatically visible to other threads).
    * a discussion on the mailing list has lead to this conclusion: choosing between storing state in the IoSession or in the Decoder instance itself is more a matter of taste. To ensure that no two threads will run the decode method for the same IoSession, MINA needs to do some form of synchronization => this synchronization will also ensure you can't have the visibility problem described above.
(Thanks to Adam Fisk for pointing this out)
see <https://www.mail-archive.com/dev@mina.apache.org/msg03038.html>
* IoBuffer.prefixedDataAvailable() is very convenient when your protocol uses a length-prefix; it supports a prefix of 1, 2 or 4 bytes.
* don't forget to reset the decoder state when you've decoded a response (removing the session attribute is another way to do it)

If the response would consist of a single image, we would not need to store decoder state:

```java
protected boolean doDecode(IoSession session, IoBuffer in, ProtocolDecoderOutput out) throws Exception {
    if (in.prefixedDataAvailable(4)) {
        int length = in.getInt();
        byte[] bytes = new byte[length];
        in.get(bytes);
        ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        BufferedImage image = ImageIO.read(bais);
        out.write(image);
        return true;
    } else {
        return false;
    }
}
```

Now let's glue it all together:

```java
public class ImageCodecFactory implements ProtocolCodecFactory {
    private ProtocolEncoder encoder;
    private ProtocolDecoder decoder;
    
    public ImageCodecFactory(boolean client) {
        if (client) {
            encoder = new ImageRequestEncoder();
            decoder = new ImageResponseDecoder();
        } else {
            encoder = new ImageResponseEncoder();
            decoder = new ImageRequestDecoder();
        }
    }
    
    public ProtocolEncoder getEncoder(IoSession ioSession) throws Exception {
        return encoder;
    }
    
    public ProtocolDecoder getDecoder(IoSession ioSession) throws Exception {
        return decoder;
    }
}
```

Remarks:

* for every new session, MINA will ask the ImageCodecFactory for an encoder and a decoder.
* since our encoders and decoders store no conversational state, it is safe to let all sessions share a single instance.

This is how the server would use the ProtocolCodecFactory:

```java
public class ImageServer {
    public static final int PORT = 33789;
    
    public static void main(String[] args) throws IOException {
        ImageServerIoHandler handler = new ImageServerIoHandler();
        NioSocketAcceptor acceptor = new NioSocketAcceptor();
        acceptor.getFilterChain().addLast("protocol", new ProtocolCodecFilter(new ImageCodecFactory(false)));
        acceptor.setLocalAddress(new InetSocketAddress(PORT));
        acceptor.setHandler(handler);
        acceptor.bind();
        System.out.println("server is listenig at port " + PORT);
    }
}
```

Usage by the client is identical:

```java
public class ImageClient extends IoHandlerAdapter {
    public static final int CONNECT_TIMEOUT = 3000;
    
    private String host;
    private int port;
    private SocketConnector connector;
    private IoSession session;
    private ImageListener imageListener;
    
    public ImageClient(String host, int port, ImageListener imageListener) {
        this.host = host;
        this.port = port;
        this.imageListener = imageListener;
        connector = new NioSocketConnector();
        connector.getFilterChain().addLast("codec", new ProtocolCodecFilter(new ImageCodecFactory(true)));
        connector.setHandler(this);
    }
    
    public void messageReceived(IoSession session, Object message) throws Exception {
        ImageResponse response = (ImageResponse) message;
        imageListener.onImages(response.getImage1(), response.getImage2());
    }
    ...
```

For completeness, I will add the code for the server-side IoHandler:

```java
public class ImageServerIoHandler extends IoHandlerAdapter {
    
    private final static String characters = "mina rocks abcdefghijklmnopqrstuvwxyz0123456789";
    
    public static final String INDEX_KEY = ImageServerIoHandler.class.getName() + ".INDEX";
    
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    public void sessionOpened(IoSession session) throws Exception {
        session.setAttribute(INDEX_KEY, 0);
    }
    
    public void exceptionCaught(IoSession session, Throwable cause) throws Exception {
        IoSessionLogger sessionLogger = IoSessionLogger.getLogger(session, logger);
        sessionLogger.warn(cause.getMessage(), cause);
    }
    
    public void messageReceived(IoSession session, Object message) throws Exception {
        ImageRequest request = (ImageRequest) message;
        String text1 = generateString(session, request.getNumberOfCharacters());
        String text2 = generateString(session, request.getNumberOfCharacters());
        BufferedImage image1 = createImage(request, text1);
        BufferedImage image2 = createImage(request, text2);
        ImageResponse response = new ImageResponse(image1, image2);
        session.write(response);
    }
    
    private BufferedImage createImage(ImageRequest request, String text) {
        BufferedImage image = new BufferedImage(request.getWidth(), request.getHeight(), BufferedImage.TYPE_BYTE_INDEXED);
        Graphics graphics = image.createGraphics();
        graphics.setColor(Color.YELLOW);
        graphics.fillRect(0, 0, image.getWidth(), image.getHeight());
        Font serif = new Font("serif", Font.PLAIN, 30);
        graphics.setFont(serif);
        graphics.setColor(Color.BLUE);
        graphics.drawString(text, 10, 50);
        return image;
    }
    
    private String generateString(IoSession session, int length) {
        Integer index = (Integer) session.getAttribute(INDEX_KEY);
        StringBuffer buffer = new StringBuffer(length);
    
        while (buffer.length() < length) {
            buffer.append(characters.charAt(index));
            index++;
            if (index >= characters.length()) {
                index = 0;
            }
        }
        session.setAttribute(INDEX_KEY, index);
        return buffer.toString();
    }
}
```

![](/assets/img/mina/codec-filter.jpeg)

## Conclusion

There is a lot more to tell about encoding and decoding. But I hope this tutorial already gets you started.
I will try to add something about the DemuxingProtocolCodecFactory in the near future.
And then we will also have a look at how to use a delimiter instead of a length prefix.
