---
type: ftpserver
title: FtpServer Releasing
---

# Deploying Snapshots (Committers Only)

Before running Maven to deploy artifacts, *please make sure if your umask is configured correctly*.  Unless configured properly, other committers will experience annoying 'permission denied' errors.  If your default shell is `bash`, please update your umask setting in the `~/.bashrc` file (create one if it doesn't exist.) by adding the following line:

```bash
umask 002
```

Please note that you have to edit the correct `shrc` file.  If you use `csh`, then you will have to edit `~/.cshrc` file.

Now you are ready to deploy the artifacts if you configured your umask correctly.

```bash
$ git clone http://gitbox.apache.org/repos/asf/mina-ftpserver.git ftpserver
$ cd ftpserver
$ mvn clean deploy    # Make sure to run 'clean' goal first to prevent side effects from your IDE.
```

Please double-check the mode (i.e. `0664` or `-rw-rw-r--`, a.k.a permission code) of the deployed artifacts, otherwise you can waste other people's time significantly.

# Releasing

## Preparing the release for the vote

* Update the distribution/README.txt file


Before starting be sure to have the java and mvn command in your PATH.
On linux you can check with the following commands :

```bash
$ type mvn
mvn is hashed (/opt/apache-maven-3.8.1/bin/mvn)
$ type java
java is hashed (/usr/bin/java)
```

### Step 0: Building FTPServer
This is done with the following command :

```bash
$ mvn clean install
```

### Step 1: Tagging and Deploying

First you need to configure maven for using the good username for scp and operation.

In the `~/.m2/settings.xml` you need the following lines :

```xml
<settings xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <!-- SERVER SETTINGS -->
  <servers>
    <!-- To publish a snapshot of some part of Maven -->
    <server>
      <id>apache.snapshots.https</id>
      <username>elecharny</username>
      <password>-----Your password here-----</password>
    </server>
    <!-- To publish a website of some part of Maven -->
    <server>
      <id>apache.websites</id>
      <username>elecharny</username>
      <filePermissions>664</filePermissions>
      <directoryPermissions>775</directoryPermissions>
    </server>
    <!-- To stage a release of some part of Maven -->
    <server>
      <id>apache.releases.https</id>
      <username>elecharny</username>
      <password>-----Your password here-----</password>
    </server>
    <!-- To stage a website of some part of Maven -->
    <server>
      <id>stagingSite</id> <!-- must match hard-coded repository identifier in site:stage-deploy -->
      <username>elecharny</username>
      <filePermissions>664</filePermissions>
      <directoryPermissions>775</directoryPermissions>
    </server>
  </servers>

  <!-- PROFILE SETTINGS -->
  <profiles>
    <profile>
      <id>apache-release</id>
      <properties>
        <!-- Configuration for artifacts signature -->
        <gpg.passphrase>-----Your passphrase here-----</gpg.passphrase>
      </properties>
    </profile>
  </profiles>

</settings>
```

### step 2 : Processing with a dry run

After having checked out the trunk, and built it (see step 0), 

```bash
$ git clone http://gitbox.apache.org/repos/asf/mina-ftpserver.git ftpserver
$ cd ftpserver
$ mvn clean install
```

run the following commands :

```bash
$ mvn -Papache-release -DdryRun=true release:prepare    # Dry-run first.
```

Answer to maven questions :

```text
"What is the release version for "Apache FtpServer parent"? (org.apache.ftpserver:ftpserver-parent) <version>: :" 
<either use the default version as suggested, or type in the version you@qot;d like to be used>
[..]
```

Then some other questions will be asked, about the next version to use. The default values should be fine.

<div class="info" markdown="1">
    <strong>Be Careful</strong><br>
    
    Make sure the change made by the release plugin is correct! (pom.xml, tags created)
</div>

### Step 3 : Processing with the real release

When the dry run is successful, then you can do in real with the following commands:

```bash
$ mvn -Papache-release release:clean      # Clean up the temporary files created by the dry-run.
$ mvn -Papache-release release:prepare    # Copy to tags directory.
```

The first step will clean up the local sources, the second step will release for real. The same questions will be asked as those we had during the dry run step.

At some point, it will ask for your passphrase (the one you used when you created your PGP key). Type it in.

Three mails will be generated, and sent to commits@mina.apache.org :

```text
git commit: [maven-release-plugin] prepare release <X.Y.Z>
Git Push Summary
git commit: [maven-release-plugin] prepare for next development iteration
```

The first mail tells you that the SNAPSHOT has been moved to the release version in trunk, the second mails tells you that this version has been tagged, and the last mail tells you that trunk has moved to the next version.

### Step 4 : perform the release

The last step before launching a vote is to push the potential release to Nexus so that every user can test the created packages. Perform the following actions (note that we have to run a build first for the javadoc to be correctly generated...) :

```bash
$ mvn clean install -DskipTests
...
$ mvn -Papache-release release:perform
...
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Reactor Summary for Apache FtpServer Parent 1.1.3:
[INFO] [INFO] 
[INFO] [INFO] Apache FtpServer Parent ............................ SUCCESS [ 14.712 s]
[INFO] [INFO] Apache Ftplet API .................................. SUCCESS [  7.984 s]
[INFO] [INFO] Apache FtpServer Core .............................. SUCCESS [ 25.573 s]
[INFO] [INFO] FtpServer Spring web project example ............... SUCCESS [  4.680 s]
[INFO] [INFO] FtpServer OSGi Ftplet service example .............. SUCCESS [  4.233 s]
[INFO] [INFO] FtpServer OSGi Spring-DM example ................... SUCCESS [  4.159 s]
[INFO] [INFO] Apache FtpServer Examples .......................... SUCCESS [  1.700 s]
[INFO] [INFO] Apache FtpServer ................................... SUCCESS [  7.438 s]
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] BUILD SUCCESS
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Total time:  01:11 min
[INFO] [INFO] Finished at: 2022-02-19T14:23:13+01:00
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] phase cleanup
[INFO] Cleaning up after release...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary for Apache FtpServer Parent 1.1.4-SNAPSHOT:
[INFO] 
[INFO] Apache FtpServer Parent ............................ SUCCESS [01:15 min]
[INFO] Apache Ftplet API .................................. SKIPPED
[INFO] Apache FtpServer Core .............................. SKIPPED
[INFO] FtpServer Spring web project example ............... SKIPPED
[INFO] FtpServer OSGi Ftplet service example .............. SKIPPED
[INFO] FtpServer OSGi Spring-DM example ................... SKIPPED
[INFO] Apache FtpServer Examples .......................... SKIPPED
[INFO] Apache FtpServer ................................... SKIPPED
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:15 min
[INFO] Finished at: 2022-02-19T14:23:13+01:00
[INFO] ------------------------------------------------------------------------
```

Done !

### Step 5 : closing the staging release on nexus

Now, you have to close the staged project on nexus. In order to do that you **must** have exported your PGP key to a PGP public server [see](https://www.apache.org/dev/openpgp.html)

Connect to the [Nexus server](https://repository.apache.org), login, and select the FtpServer release in the staging repository you just created, then click on the 'close' button. You are home...

### Step 6 : Build the Site

```bash
$ cd target/checkout
$ mvn -Pserial site
```

This creates the site.

### Step 7 : Sign the packages 

Now, you have to sign the binary packages which are in target/checkout/distribution/target.

<div class="note" markdown="1">
Use your PGP key ID (the pub key, 4096R/[XXXXXXX] where [XXXXXXX] is the key ID)
</div>

You can get the keys by typing :

```bash
gpg --list-keys
```

You'll get something like :

```text
localhost:target elecharny$ gpg --list-keys
/Users/elecharny/.gnupg/pubring.gpg
-----------------------------------
pub   dsa2048 2009-12-03 [SCA]
  C62BFD988278310B5B7A43D16FC4BEA60A8A0BBA
uid           [ultimate] Emmanuel Lecharny <elecharny@nextury.com>
sub   elg2048 2009-12-03 [E]

pub   rsa4096 2010-09-13 [SC]
  4D2DB2916149BAA9D0C92F3731474E5E7C6B7034
uid           [ultimate] Emmanuel Lecharny (CODE SIGNING KEY) <elecharny@apache.org>
sub   rsa4096 2010-09-13 [E]

...
```

Take the long hexadecimal tart following the 'pub' part (ie "4D2DB2916149BAA9D0C92F3731474E5E7C6B7034" for the 4096 bits key)

Use a shell script to sign the packages which are stored in target/checkout/distribution/target. You will first have to delete the created .asc files :

```text
localhost:target elecharny$ rm *.asc
localhost:target elecharny$ ~/sign.sh 
PGP Key ID: 
<your PGP key>
PGP Key Password: 
<Your PGP passphrase>

-n Signing: ./apache-ftpserver-<version>-bin.tar.bz2 ... 
  - Generated './apache-ftpserver-<version>-bin.tar.bz2.sha512'
  - Generated './apache-ftpserver-<version>-bin.tar.bz2.asc'
-n Signing: ./apache-ftpserver-<version>-bin.tar.gz ... 
  - Generated './apache-ftpserver-<version>-bin.tar.gz.sha512'
  - Generated './apache-ftpserver-<version>-bin.tar.gz.asc'
...
```

Here is the `sign.sh` script you can use :

```bash
#!/bin/sh

echo "PGP Key ID: "
read DEFAULT_KEY

echo "PGP Key Password: "
stty -echo
read PASSWORD
stty echo
echo ""

for FILE in $(find . -maxdepth 1 -not '(' -name "sign.sh" -or -name ".*" -or -name "*.sha256" -or -name "*.sha512" -or -name "*.asc" ')' -and -type f) ; do
  if [ -f "$FILE.asc" ]; then
      echo "Skipping: $FILE"
      continue
  fi

  echo -n "Signing: $FILE ... "

  # SHA-512
  if [ ! -f "$FILE.sha512" ];
  then
      gpg -v --default-key "$DEFAULT_KEY" --print-md SHA512 "$FILE" > "$FILE".sha512
      echo "  - Generated '$FILE.sha512'"
  else
      echo "  - Skipped '$FILE.sha512' (file already existing)"
  fi

  # ASC
  if [ ! -f "$FILE.asc" ];
  then
      echo "$PASSWORD" | gpg --default-key "$DEFAULT_KEY" --detach-sign --armor --no-tty --yes --passphrase-fd 0 "$FILE"
      echo "  - Generated '$FILE.asc'"
  else
      echo "  - Skipped '$FILE.asc' (file already existing)"
  fi
done
```

### Step 8 : Publish Source and Binary Distribution Packages

The sources, binaries and their signatures, have to be pushed in a place where they can be downloaded by the other committers, in order to be checked while validating the release. As the ~/people.apache.org server is not anymore available for that purpose, we use the distribution space for that purpose.

If you haven't checked out this space, do it now :

```bash
$ mkdir -p ~/mina/dist/dev/mina
$ svn co https://dist.apache.org/repos/dist/dev/mina ~/mina/dist/dev/mina
```

That will checkout the full project distributions.

You may want to checkout only the part that you are going to generate, to avoid getting Gb of data :

```bash
$ mkdir -p ~/mina/dist/dev/mina/ftpserver
$ svn co https://dist.apache.org/repos/dist/dev/mina/ftpserver ~/mina/dist/dev/mina/mina/ftpserver
```

Now, create a sub-directory for the version you have generated (here, replace &lt;version&gt; by the specific version number) :

```bash
$ mkdir ~/mina/dist/dev/mina/ftpserver/1.1.3
```

Then copy the packages :

```bash
$ cd target/checkout/distributions/target
$ cp apache-ftpserver-<version>-* ~/mina/dist/dev/mina/ftpserver/<version>/
```

Last, not least, commit your changes

```bash
$ svn add ~/mina/dist/dev/mina/ftpserver/<version>/
$ svn ci ~/mina/dist/dev/mina/ftpserver/<version>/ -m "Apache FtpServer <version> packages"
```
## Step 10 : Voting a release

Once the tarballs have been created, and the binaries available in Nexus, a vote can be launched. Simply send a mail on the dev@mina.apache.org mailing list describing the new release.

Here is how you  send a [VOTE] mail on the dev mailing list :

```text
Hi,

<blah blah blah>

Here is the list of fixed issues :
 
  * [FTPSERVER-502](https://issues.apache.org/jira/browse/FTPSERVER-502) - Cannot upload files due to invalid absolutePath result
  * ...


Here's the Jira link for this version if you'd like to review issues in more details:

https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=10670&styleName=Html&version=12313702

A temporary tag has been created (it can be removed if the vote is not approved)

The newly approved Nexus has been used for the preparation of this release and all final artifacts are stored 
in a staging repository:
https://repository.apache.org/content/repositories/orgapachemina-002/


The distributions are available for download on :
https://repository.apache.org/content/repositories/orgapachemina-004/org/apache/mina/ftpserver/1.1.3/

Let us vote :
[ ] +1 | Release Apache FtpServer 1.1.3
[ ] +/- | Abstain
[ ] -1 | Do *NOT* release Apache FtpServer 1.1.3

Thanks !
```

The vote will be open for 72 hours. Once the delay is over, collect the votes, and count the binding +1/-1. If the vote is positive, then we can release.

### Step 11 : Close the vote

You can officially close the vote now. There are some more steps to fulfill :

* Release the project on the [Nexus server](https://repository.apache.org)
* Copy the tarballs and heir signature in https://dist.apache.org/repos/dist/release/mina/ftpserver

The sources, binaries and their signatures, have to be pushed in a place where they can be downloaded by users. We use the [distribution](https://dist.apache.org/repos/dist/release/mina/ftpserver) space for that purpose.

Move the distribution packages (sources and binaries) to the dist SVN repository: `https://dist.apache.org/repos/dist/release/mina/ftpserver/$(version)`

If you haven't checked out this space, do it now :

```bash
$ mkdir -p ~/mina/dist/release/ftpserver
$ svn co https://dist.apache.org/repos/dist/release/mina/ftpserver ~/mina/dist/release/ftpserver
```

That will checkout the full project distributions. 

Then move the packages from 'dev' to 'release' :

```bash
$ cd ~/mina/dist/release/ftpserver
$ cp ~/mina/dist/dev/mina/ftpserver/<version> .
$ svn add <version>
$ svn ci <version>
...
$ exit
```

The packages should now be available on https://dist.apache.org/repos/dist/release/mina/ftpserver/<version>

### Step 12: Deploy Web Reports (JavaDoc and JXR)

The javadoc has been generated in step 6, it's now time to push them into the production site. It has been generated in the following directory :

```text
target/checkout/target/reports
```

We will copy the ```apidocs``` directory.

It will be uploaded to https://nightlies.apache.org/ via WebDAV protocol.

First create the folder for the version (change the &lt;version&gt; part):

```
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/ftpserver/<version>/'
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/ftpserver/<version>/apidocs'
```

Each of those commands will ask for your ASF password.

I used **rclone** to copy folders via WebDAV.

After intallation run rclone config and configure the nightlies connection:

```
$ rclone config
name: nightlies
type: webdav
url: https://nightlies.apache.org
vendor: other
user: <your asf id>
pass: <your asf password> (will be stored encrypted)
```

Then copy the directory (change the &lt;version&gt; part):

```
cd target/checkout/target/reports
rclone copy --progress apidocs nightlies:/mina/ftpserver/<version>/apidocs
```

Finally update the links in the static/ftpserver-project/gen-docs/.htaccess of the mina-site repo (change the &lt;version&gt; part):

```
RewriteRule ^latest$ https://nightlies.apache.org/mina/ftpserver/<version>/ [QSA,L]
RewriteRule ^latest/(.*)$ https://nightlies.apache.org/mina/ftpserver/<version>/$1 [QSA,L]
```

Save and commit the file, the web site should be automatically generated and published.

### Step 13: Update the Links in Web Site

Some pages have to be updated. Assuming the MINA site has been checked out in ~/mina/site (this can be done with the command <em>$ git clone http://gitbox.apache.org/repos/asf/mina-site.git ~/mina/mina-site</em>), here are the pages that need to be changed :

* /config.toml: update the `version_ftpserver` variable with the new version.
* /source/ftpserver-project/downloads.md: Refer to the previous page
* /source/ftpserver-project/downloads_1_2.md: Refer to the previous page
* /source/ftpserver-project/old_downloads.md: Refer to the previous page
* /source/donwloads-ftpserver_1_2.md: Update the version

Commit the changes, and publish the web site, you are done !

### Step 14: Wait 24 hours

We need to wait until any changes made in the web site and metadata file(s) go live.

### Step 15: Announce the New Release

An announcement message can be sent to [mailto:announce@apache.org], [mailto:announce@apachenews.org], [mailto:users@mina.apache.org] and [mailto:dev@mina.apache.org].  Please note that announcement messages are rejected unless your from-address ends with `@apache.org`.  Plus, you shouldn't forget to post a news to the MINA site main page.

Enjoy !
