---
type: mina
title: Setting SVN Properties in Tortoise SVN
---

# Setting SVN Properties in Tortoise SVN

This article is for configuring SVN properties for TortoiseSVN Client

To maintain header's with revision tags like, we need to set SVN properties.

```text
/**
 * @version $Rev: 529576 $, $Date: 2007-04-17 14:25:07 +0200 (mar., 17 avr. 2007) $
*/
```

Lets see how to set these properties in Tortoise SVN Client

Open Tortoise SVN Client setting, (Right Click-> Tortoise SVN -> Settings)

![TortoiseSVN](/assets/img/mina/tortoisesvn_setting.png)

Click Edit button (as shown in figure)

![TortoiseSVN setting](/assets/img/mina/tortoisesvn_settingdialog.png)

The svn properties config file shall open up.

Search for enable-auto-props = yes and uncomment, if not already done. The attribute is under miscellany

Configure the properties auto-props section

Please note that I have taken these properties from <http://wiki.apache.org/incubator-yoko/SetUpAutoProps>. Feel free to
update as per your needs.

```text
*.java = svn:eol-style=native;svn:keywords=Rev Date
*.xml = svn:mime-type=text/xml;svn:eol-style=native;svn:keywords=Rev Date
*.xsl = svn:mime-type=text/xml;svn:eol-style=native;svn:keywords=Rev Date
*.xsd = svn:mime-type=text/xml;svn:eol-style=native;svn:keywords=Rev Date
*.wsdl = svn:mime-type=text/xml;svn:eol-style=native;svn:keywords=Rev Date
*.properties = svn:mime-type=text/plain;svn:eol-style=native;svn:keywords=Rev Date
*.c = svn:eol-style=native
*.cpp = svn:eol-style=native
*.h = svn:eol-style=native
*.dsp = svn:eol-style=CRLF
*.dsw = svn:eol-style=CRLF
*.sh = svn:eol-style=native;svn:executable
*.bat = svn:eol-style=native
*.pl = svn:eol-style=native
*.py = svn:eol-style=native
*.cmd = svn:eol-style=native
*.txt = svn:eol-style=native;svn:mime-type=text/plain
*.htm* = svn:eol-style=native;svn:mime-type=text/html;svn:keywords=Rev Date
ChangeLog = svn:eol-style=native;svn:mime-type=text/plain
README* = svn:eol-style=native;svn:mime-type=text/plain
LICENSE* = svn:eol-style=native;svn:mime-type=text/plain
NOTICE* = svn:eol-style=native;svn:mime-type=text/plain
TODO* = svn:eol-style=native;svn:mime-type=text/plain
KEYS* = svn:eol-style=native;svn:mime-type=text/plain
INSTALL* = svn:eol-style=native;svn:mime-type=text/plain
WHATSNEW* = svn:eol-style=native;svn:mime-type=text/plain
*.png = svn:mime-type=image/png
*.jpg = svn:mime-type=image/jpeg
*.gif = svn:mime-type=image/gif
Makefile = svn:eol-style=native
*.css = svn:eol-style=native
*.js = svn:eol-style=native
```
