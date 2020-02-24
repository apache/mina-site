---
type: ftpserver
title: FtpServer and port 21 on Linux
---

# FtpServer and port 21 on Linux

Under Linux only programs running as root is allowed to bind and listen to ports with port numbers below 1024. However, running a server which communicates with untrusted clients as root is not recommended for security reasons. The standard way to solve this problem in servers such as Apache HTTPD is to start the server as root and bind to the privileged port and then use the setuid C function to change the user ID of the current process. In Java there is no equivalent to the setuid C function in the standard API which means that one would have to use a native library to achieve the same, something which FtpServer doesn't support at the moment.

So, to have FtpServer listen on port 21 but still run it as a normal user one will have to look at other solutions such as using the firewall built into Linux. It turns out that this is really simple. Using the iptables command we can add a rule to the firewall that rewrites all TCP packets coming in on port 21 so that they are effectively forwarded to port 60021:

```bash
sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport 21 -j REDIRECT --to-ports 60021
```

We can now configure FtpServer to listen on port 60021 and it will be available on port 21 as well.

