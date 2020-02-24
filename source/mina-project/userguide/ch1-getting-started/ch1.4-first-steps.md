---
type: mina
title: 1.4 - First Steps
navPrev: ch1.3-features.html
navPrevText: 1.3 - Features
navUp: ch1-getting-started.html
navUpText: Chapter 1 - Getting Started
navNext: ch1.5-summary.html
navNextText: 1.5 - Summary
---

# First Steps

We will show you how easy it is to use MINA, running a very simple example provided with the **MINA** package. 

The first thing you have to do is to setup your environment when you want to use **MINA** in your application. We will describe what you need to install and how to run a **MINA** program. Nothing fancy, just a first taste of **MINA**...

## Download

First, you have to download the latest **MINA** release from [MINA 2.0 Downloads Section](../../downloads_2_0.html) or [MINA 2.1 Downloads Section](../../downloads_2_1.html). Just take the latest version, unless you have very good reasons not to do so...

Generally speaking, if you are going to use **Maven** to build your project, you won't even have to download anything, as soon as you will depend on a repository which already contains the **MINA** libraries : you just tell your **Maven** poms that you want to use the **MINA** jars you need.

## What's inside

After the download is complete, extract the content of _tar.gz_ or _zip_ file to local hard drive. The downloaded compressed file has following contents

On UNIX system, type :

    $ tar xzpf apache-mina-2.0.7-tar.gz
    
In the _apache-mina-2.0.7_ directory, you will get :

     |
     +- dist
     +- docs
     +- lib
     +- src
     +- LICENSE.txt
     +- LICENSE.jzlib.txt
     +- LICENSE.ognl.txt
     +- LICENSE.slf4j.txt
     +- LICENSE.springframework.txt
     +- NOTICE.txt

## Content Details

* _dist_ - Contains jars for the **MINA** library code
* _docs_ - Contains API docs and Code xrefs
* _lib_ - Contains all needed jars for all the libraries needed for using **MINA**

Additional to these, the base directory has couple of license and notice files

# Running your first MINA program

Well, we have downloaded the release, let's run our first **MINA** example, shipped with the release.

Put the following jars in the classpath

* mina-core-2.0.7.jar
* mina-example-2.0.7.jar
* slf4j-api-1.6.6.jar
* slf4j-log4j12-1.6.6.jar
* log4j-1.2.17.jar

<div class="tip" markdown="1">
<strong>Logging Tip</string>

<ul>
  <li>Log4J 1.2 users: slf4j-api.jar, slf4j-log4j12.jar, and Log4J 1.2.x</li>
  <li>Log4J 1.3 users: slf4j-api.jar, slf4j-log4j13.jar, and Log4J 1.3.x</li>
  <li>java.util.logging users: slf4j-api.jar and slf4j-jdk14.jar</li>
</ul>
    
<strong>IMPORTANT:<strong> Please make sure you are using the right <em>slf4j-*.jar</em> that matches to your logging framework.
For instance, <em>slf4j-log4j12.jar</em> and <em>log4j-1.3.x.jar</em> can not be used together, and will malfunction.
If you don't need a logging framework you can use <em>slf4j-nop.jar</em> for no logging or <em>slf4j-simple.jar</em> for
very basic logging.
</div>

On the command prompt, issue the following command :

    $ java org.apache.mina.example.gettingstarted.timeserver.MinaTimeServer

This shall start the server. Now telnet and see the program in action

Issue following command to telnet

    telnet 127.0.0.1 9123

Well, we have run our first **MINA** program. Please try other sample programs shipped with **MINA** as examples.
