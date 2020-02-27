---
type: ftpserver
title: FtpServer File based user manager
---

# File based user manager

This is the default user manager. It uses a properties file to store all the user information.

## Example

```xml
<file-user-manager file="users.properties" encrypt-passwords="true">
```

## file-user-manager element

| Attribute | Description | Required | Default value |
|---|---|---|---|
| file | Path to the properties file for storing users | Yes | {{< html "&nbsp;" >}} |
| encrypt-passwords | It indicates how to stored password are encrypted. Possible values are "clear" for clear text, "md5" for hashed using MD5 or "salted" for hashed salted passwords (including multiple hash iterations). "salted" is encouraged. | No | md5 |
