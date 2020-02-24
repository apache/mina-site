---
type: mina
title: 2.1.2 - Client Architecture
navPrev: ch2.1.1-server-architecture.html
navPrevText: 2.1.1 - Server Architecture
navUp: ch2.1-application-architecture.html
navUpText: 2.1 - Application Architecture
navNext: ch2.1-application-architecture.html
navNextText: 2.1 - Application Architecture
---

# 2.1.2 - Client Architecture


We had a brief look at MINA based Server Architecture, lets see how Client looks like. Clients need to connect to a Server, send message and process the responses.

![diagram](/assets/img/mina/clientdiagram.png)

* Client first creates an IOConnector (MINA Construct for connecting to Socket), initiates a bind with Server
* Upon Connection creation, a Session is created and is associated with Connection
* Application/Client writes to the Session, resulting in data being sent to Server, after traversing the Filter Chain
* All the responses/messages received from Server are traverses the Filter Chain and lands at IOHandler, for processing
