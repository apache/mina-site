---
type: ftpserver
title: FtpServer User Manager
---

# User Manager

## Built in user managers

FtpServer comes with two different user managers:

* [File based user manager](configuration_user_manager_file.html)
* [Database user manager](configuration_user_manager_db.html)

## Custom User Manager

You can write your own user manager to integrate it with your existing applications. Your custom user manager should implement org.apache.ftpserver.ftplet.UserManager interface. In your configuration file, you will have to use the Spring bean element to configure your custom user manager. This gives you all the power of Spring, for example integrating with your other beans. You can also provide a custom XML format by using the Spring XML extension mechanisms.


