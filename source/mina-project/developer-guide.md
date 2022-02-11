---
type: mina
title: Developer Guide
---

# Building MINA

<div class="note" markdown="1">
    Please read <a href="https://www.apache.org/dev/" class="external-link" rel="nofollow">the Developer Infrastructure Information</a> if you haven't yet before you proceed.
</div>

{{% toc %}}

# Checking out the code

You need Git to check out the source code from our source code repository, and [Maven(http://maven.apache.org/) 2.2.1 to build the source code (Building with Maven 3.0 will also work).  The following example shows how to build the current stable branch (2.0.9).

```bash
$ git clone http://gitbox.apache.org/repos/asf/mina.git mina
$ cd mina
$ mvn -Pserial clean install             # Build packages (JARs) for the core API and other 
                                         # extensions and install them to the local Maven repository.
$ mvn -Pserial site                      # Generate reports (JavaDoc and JXR)
$ mvn -Pserial package assembly:assembly # Generate a tarball (package goal needed to fix an assembly plugin bug)
$ mvn -Pserial eclipse:eclipse           # Generate Eclipse project files if you want
```

Eclipse users:
Don't forget to declare a classpath variable named M2_REPO, pointing to `~/.m2/repository`, otherwise many links to existing jars will be broken.
You can declare new variables in Eclipse in Windows -> Preferences... and selecting Java -> Build Path -> Classpath Variables

There are also other branches that might interest you:

* trunk: Where big changes take place everyday

If you want to check out the source code of previous releases, you have to select the branch you want to work on :

```bash
$ git clone http://gitbox.apache.org/repos/asf/mina.git mina
$ git checkout <tag>
```

For instance, to work on the on-going 2.0 version trunk, just do :

```bash
$ git clone http://gitbox.apache.org/repos/asf/mina.git mina
$ git checkout 2.0
```

# Coding Convention

We follow [Sun's standard Java coding convention](https://www.oracle.com/technetwork/java/codeconventions-150003.pdf) except that we always use spaces instead of tabs. Please download [the Eclipse Java formatter settings file](ImprovedJavaConventions.xml) before you make any changes to the code.

This file is also available in the `/resources` directory.

# Class header

As class header we use :

```java
/** 
 * Class desciption here.
 *
 * @author <a href="http://mina.apache.org">Apache MINA Project</a>
 */
```

The headers revisions tags are removed.

# Deploying Snapshots (Committers Only)

Before running Maven to deploy artifacts, *please make sure if your umask is configured correctly*.  Unless configured properly, other committers will experience annoying 'permission denied' errors.  If your default shell is `bash`, please update your umask setting in the `~/.bashrc` file (create one if it doesn't exist.) by adding the following line:

```bash
umask 002
```

Please note that you have to edit the correct `shrc` file.  If you use `csh`, then you will have to edit `~/.cshrc` file.

Now you are ready to deploy the artifacts if you configured your umask correctly.

```bash
$ git clone http://gitbox.apache.org/repos/asf/mina.git mina
$ cd mina
$ mvn -Pserial clean deploy site site:deploy    # Make sure to run 'clean' goal first to prevent side effects from your IDE.
```

Please double-check the mode (i.e. `0664` or `-rw-rw-r--`, a.k.a permission code) of the deployed artifacts, otherwise you can waste other people's time significantly.

# Releasing a Point Release (Committers Only)

## Preparing the release for the vote

Before starting be sure to have the java and mvn command in your PATH.
On linux you can check with the following commands :

```bash
$ type mvn
mvn is hashed (/opt/maven-2.2.1/bin/mvn)
$ type java
java is hashed (/usr/bin/java)
```

### Step 0: Building MINA
As weird as it sounds, for some unknown reason (most certainly a misconfiguration in the Maven poms), we can't just run the release without having previously build all the projects. This is done with the following command :

```bash
$ mvn clean install -Pserial
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
$ git clone http://gitbox.apache.org/repos/asf/mina.git mina
$ cd mina
$ mvn clean install -Pserial
```

run the following commands :

```bash
$ mvn -Pserial,apache-release -DdryRun=true release:prepare    # Dry-run first.
```

Answer to maven questions :

```text
"What is the release version for "Apache MINA"? (org.apache.mina:mina-parent) 2.0.7-<version>: :" 
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
$ mvn -Pserial,apache-release release:clean      # Clean up the temporary files created by the dry-run.
$ mvn -Pserial,apache-release release:prepare    # Copy to tags directory.
```

The first step will clean up the local sources, the second step will release for real. The same questions will be asked as those we had during the dry run step.

At some point, it will ask for your passphrase (the one you used when you created your PGP key). Type it in.

Three mails will be generated, and sent to commits@mina.apache.org :

```text
git commit: [maven-release-plugin] prepare release 2.0.9
Git Push Summary
git commit: [maven-release-plugin] prepare for next development iteration
```

The first mail tells you that the SNAPSHOT has been moved to the release version in trunk, the second mails tells you that this version has been tagged, and the last mail tells you that trunk has moved to the next version.

### Step 4 : perform the release

The last step before launching a vote is to push the potential release to Nexus so that every user can test the created packages. Perform the following actions (note that we have to run a build first for teh javadoc to be correctly generated...) :

```bash
$ mvn clean install -Pserial -DskipTests
...
$ mvn -Pserial,apache-release release:perform
...
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Reactor Summary:
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Apache MINA ........................................... SUCCESS [1:05.896s]
[INFO] [INFO] Apache MINA Legal ..................................... SUCCESS [30.708s]
[INFO] [INFO] Apache MINA Core ...................................... SUCCESS [4:44.973s]
[INFO] [INFO] Apache MINA APR Transport ............................. SUCCESS [46.082s]
[INFO] [INFO] Apache MINA Compression Filter ........................ SUCCESS [40.230s]
[INFO] [INFO] Apache MINA State Machine ............................. SUCCESS [52.718s]
[INFO] [INFO] Apache MINA JavaBeans Integration ..................... SUCCESS [46.358s]
[INFO] [INFO] Apache MINA XBean Integration ......................... SUCCESS [1:21.054s]
[INFO] [INFO] Apache MINA OGNL Integration .......................... SUCCESS [40.740s]
[INFO] [INFO] Apache MINA JMX Integration ........................... SUCCESS [40.482s]
[INFO] [INFO] Apache MINA Examples .................................. SUCCESS [1:13.837s]
[INFO] [INFO] Apache MINA Serial Communication support .............. SUCCESS [41.684s]
[INFO] [INFO] Apache MINA Distribution .............................. SUCCESS [12:39.542s]
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] BUILD SUCCESSFUL
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Total time: 26 minutes 46 seconds
[INFO] [INFO] Finished at: Mon Sep 13 16:45:14 CEST 2010
[INFO] [INFO] Final Memory: 98M/299M
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] Cleaning up after release...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESSFUL
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 27 minutes 5 seconds
[INFO] Finished at: Mon Sep 13 16:45:18 CEST 2010
[INFO] Final Memory: 28M/81M
[INFO] ------------------------------------------------------------------------
```

Done !

### Step 5 : closing the staging release on nexus

Now, you have to close the staged project on nexus. In order to do that you **must** have exported your PGP key to a PGP public server [see](https://www.apache.org/dev/openpgp.html)

Connect to the [Nexus server](https://repository.apache.org), login, and select the MINA staging repository you just created, then click on the 'close' button. You are home...

### Step 6 : Build the Site

You will need to modify the **pom.xml** file to be able to run the **mvn site** command. Actually, you have to comment the executions part of the maven JXF plugin in the **maven-site-plugin** configuration :

```xml
<plugin>
  <artifactId>maven-jxr-plugin</artifactId>
  <configuration>
    <aggregate>true</aggregate>
  </configuration>

  <!--executions>
    <execution>
      <phase>install</phase>
      <goals>
        <goal>jxr</goal>
        <goal>test-jxr</goal>
      </goals>
    </execution>
  </executions -->
</plugin>
```

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

-n Signing: ./apache-mina-2.0.9-bin.tar.bz2 ... 
  - Generated './apache-mina-2.0.9-bin.tar.bz2.sha1'
  - Generated './apache-mina-2.0.9-bin.tar.bz2.asc'
-n Signing: ./apache-mina-2.0.9-bin.tar.gz ... 
  - Generated './apache-mina-2.0.9-bin.tar.gz.sha1'
  - Generated './apache-mina-2.0.9-bin.tar.gz.asc'
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

  # SHA-256
  if [ ! -f "$FILE.sha256" ];
  then
      gpg -v --default-key "$DEFAULT_KEY" --print-md SHA256 "$FILE" > "$FILE".sha256
      echo "  - Generated '$FILE.sha256'"
  else
      echo "  - Skipped '$FILE.sha256' (file already existing)"
  fi

  # SHA-512
  if [ ! -f "$FILE.shacw512256" ];
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
$ mkdir -p ~/mina/dist/dev/mina/mina
$ svn co https://dist.apache.org/repos/dist/dev/mina/mina ~/mina/dist/dev/mina/mina
```

Now, create a sub-directory for the version you have generated (here, for version 2.0.14) :

```bash
$ mkdir ~/mina/dist/dev/mina/mina/2.0.14
```

Then copy the packages :

```bash
$ cd target/checkout/distributions/target
$ cp apache-mina-2.0.14-* ~/mina/dist/dev/mina/mina/2.0.14/
```

Last, not least, commit your changes

```bash
$ svn add ~/mina/dist/dev/mina/mina/2.0.14
$ svn ci ~/mina/dist/dev/mina/mina/2.0.14 -m "Apache MINA 2.0.14 packages"
```

### Step 9 : Test the New Version with FtpServer, Sshd and Vysper

In <em>FtpServer/pom.xml</em> change the <org.apache.directory.shared.version> property, build FtpServer. It should build with no error. Do the same thing with Sshd and Vysper.

It's time to launch a vote !

## Step 10 : Voting a release

Once the tarballs have been created, and the binaries available in Nexus, a vote can be launched. Simply send a mail on the dev@mina.apache.org mailing list describing the new release.

Here is how you  send a [VOTE] mail on the dev mailing list :

```text
Hi,

<blah blah blah>

Here is the list of fixed issues :
 

   * [DIRMINA-803 <https://issues.apache.org/jira/browse/DIRMINA-803>]
     - ProtocolCodecFilter.filterWrite() is no longer thread-safe
   * ...


Here's the Jira link for this version if you'd like to review issues in more details:

https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=10670&styleName=Html&version=12313702

A temporary tag has been created (it can be removed if the vote is not approved)

The newly approved Nexus has been used for the preparation of this release and all final artifacts are stored 
in a staging repository:
https://repository.apache.org/content/repositories/orgapachemina-002/


The distributions are available for download on :
https://repository.apache.org/content/repositories/orgapachemina-004/org/apache/mina/mina-parent/2.0.1/

Let us vote :
[ ] +1 | Release MINA 2.0.1
[ ] +/- | Abstain
[ ] -1 | Do *NOT*  release MINA 2.0.1

Thanks !
```

The vote will be open for 72 hours. Once the delay is over, collect the votes, and count the binding +1/-1. If the vote is positive, then we can release.

### Step 11 : Close the vote

You can officially close the vote now. There are some more steps to fulfill :

* Release the project on the [Nexus server](https://repository.apache.org)
* Copy the tarballs and heir signature in https://dist.apache.org/repos/dist/release/mina/mina

The sources, binaries and their signatures, have to be pushed in a place where they can be downloaded by users. We use the [distribution](https://dist.apache.org/repos/dist/release/mina/mina) space for that purpose.

Move the distribution packages (sources and binaries) to the dist SVN repository: `https://dist.apache.org/repos/dist/release/mina/mina/$(version)`

If you haven't checked out this space, do it now :

```bash
$ mkdir -p ~/mina/dist/release/mina
$ svn co https://dist.apache.org/repos/dist/release/mina/mina ~/mina/dist/release/mina
```

That will checkout the full project distributions. 

Then move the packages from 'dev' to 'release' :

```bash
$ cd ~/mina/dist/release/mina
$ cp ~/mina/dist/dev/mina/mina/<version> .
$ svn add <version>
$ svn ci <version>
...
$ exit
```

The packages should now be available on https://dist.apache.org/repos/dist/release/mina/mina/ <version>

### Step 12: Deploy Web Reports (JavaDoc and JXR)

The javadoc and xref files have been generated in step 6, it's now time to push them into the production site. They are generated in the following directory :

```text
target/checkout/target/site
```

We will copy four directories :

```text
apidocs
testapidocs
xref
xref-test
```

They are uploaded to https://nightlies.apache.org/ via WebDAV protocol.

First create the folders for the version (change the &lt;version&gt; part):

```
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/mina/<version>/'
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/mina/<version>/apidocs'
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/mina/<version>/testapidocs'
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/mina/<version>/xref'
$ curl -u <your asf id> -X MKCOL 'https://nightlies.apache.org/mina/mina/<version>/xref-test'
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

Then copy the directories (change the &lt;version&gt; part):

```
cd target/checkout/target/site
rclone copy --progress apidocs nightlies:/mina/mina/<version>/apidocs
rclone copy --progress xref nightlies:/mina/mina/<version>/testapidocs
rclone copy --progress xref nightlies:/mina/mina/<version>/xref
rclone copy --progress xref nightlies:/mina/mina/<version>/xref-test
```

Finally update the links in the static/mina-project/gen-docs/.htaccess of the mina-site repo (change the &lt;version&gt; part):

```
RewriteRule ^latest-2.1$ https://nightlies.apache.org/mina/mina/<version>/ [QSA,L]
RewriteRule ^latest-2.1/(.*)$ https://nightlies.apache.org/mina/mina/<version>/$1 [QSA,L]
```

Save and commit the file, the web site should be automatically generated and published.


### Step 13: Wait 24 hours

We have to wait at least 24 hours for all mirrors to retrieve the uploaded files before making any announcement.  I'd recommend you to wait for 48 hours because some mirrors might lag due to various issues.

### Step 14: Update the Links in Web Site

Some pages have to be updated. Assuming the MINA site has been checked out in ~/mina/site (this can be done with the command <em>$ svn co https://http://svn.apache.org/viewvc/mina/site/trunk ~/mina/site</em>), here are the pages that need to be changed :

* /config.toml: update the `version_mina_XYZ` variable with the new version.
* /source/mina-project/news.md: add the news on top of this page
* /source/mina-project/downloads-2_0.md or /source/mina-project/downloads-2_1.md: change the version all over the page
* /source/downloads-mina_2_0.md or /source/downloads-mina2_1.md: change the version all over the page
* /source/mina-project/downloads-old.md: Add a line for the latest version which has been replaced by the released one

Commit the changes, and publish the web site, you are done !

### Step 15: Wait another 24 hours

We need to wait until any changes made in the web site and metadata file(s) go live.

### Step 16: Announce the New Release

An announcement message can be sent to [mailto:announce@apache.org], [mailto:announce@apachenews.org], [mailto:users@mina.apache.org] and [mailto:dev@mina.apache.org].  Please note that announcement messages are rejected unless your from-address ends with `@apache.org`.  Plus, you shouldn't forget to post a news to the MINA site main page.

Enjoy !
