---
type: sshd
title: Loading SSHD in Eclipse or IDEA
---

# Loading SSHD in Eclipse or IDEA

If you want to debug or develop on SSHD, chances are you want to load it in your IDE. Most IDE now have some maven support (either natively or through plugins), but if you don't have those plugins installed, you can create the required project files using one of the following command:

    mvn eclipse:eclipse

or 

    mvn idea:idea

If you want to have the source code for the various dependencies available for debugging, you can add the -DdownloadSources=true parameter on the command line.

Next step is to load the generated project from Eclipse or IDEA.

Note that you may have to set up some global variables to point to the local maven repository.



