---
type: asyncweb
title: AsyncWeb Sources
---

Sources for the Apache AsyncWeb projects are currently managed through Subversion (SVN). Instructions on Subversion use can be found at <http://svnbook.red-bean.com/>. If you are on Windows, the excellent TortoiseSVN client is highly recommended.

For each project you can find a detailed description how to checkout and build the source on the project documentation. This page is just a short overview.

# Web Access to Subversion

If you just want to browse the source code, you can use the [web interface to Subversion](http://svn.apache.org/viewvc/mina/asyncweb). This is current at all times.

# Normal Subversion Access

Anyone can check code out of Subversion. You only need to specify a username and password in order to update the Subversion repository, and only MINA committers have the permissions to do that. We run Subversion over standard HTTPS, so hopefully you won't have problems with intervening firewalls.

# Check out from Subversion

Again, anyone can do this. Use a command like to checkout the current development version (the trunk):

    svn checkout http://svn.apache.org/repos/asf/mina/asyncweb/trunk

# Commit Changes to Subversion

Any __MINA__ committer should have a shell account on svn.apache.org. Before you can commit, you'll need to set a Subversion password for yourself. To do that, log in to svn.apache.org and run the command svnpasswd.

Once your password is set, you can use a command like this to commit:

    svn commit

If Subversion can't figure out your username, you can tell it explicitly:

    svn --username you commit

Subversion will prompt you for a password, and once you enter it once, it will remember it for you. Note this is the password you configured with svnpasswd, not your shell or other password.

<div class="note" markdown="1">
    For committers to be able to commit modification, they should have had checked out the project files using <strong>https</strong> instead of <strong>http</strong>.
</div>

## Access from behind a firewall

For those users who are stuck behind a corporate firewall which is blocking http access to the Subversion repository, you can try to access it via the developer connection:

    $ svn checkout https://svn.apache.org/repos/asf/mina/asyncweb/trunk asyncweb

## Access through a proxy

The Subversion client can go through a proxy, if you configure it to do so. First, edit your "servers" configuration file to indicate which proxy to use. The files location depends on your operating system. On Linux or Unix it is located in the directory "~/.subversion". On Windows it is in "%APPDATA%\Subversion". (Try "echo %APPDATA%", note this is a hidden directory.)

There are comments in the file explaining what to do. If you don't have that file, get the latest Subversion client and run any command; this will cause the configuration directory and template files to be created.

Example : Edit the 'servers' file and add something like :

    [global]
    http-proxy-host = your.proxy.name
    http-proxy-port = 3128
