---
type: ftpserver
title: FtpServer Releasing
---

# Releasing

## Before calling a vote

* Update the README.txt file
* Copy trunk revision to branch

        svn copy -m "Branching for release" -r <revision> 
            https://svn.apache.org/repos/asf/mina/ftpserver/trunk/
            https://svn.apache.org/repos/asf/mina/ftpserver/branches/<release version>
        svn co https://svn.apache.org/repos/asf/mina/ftpserver/branches/<release version>

* Up version in trunk

        mvn versions:set -DnewVersion=<next version>-SNAPSHOT -DgenerateBackupPoms=false
        svn -m "Increasing version for new development in trunk" commit

* Update version in branch

        mvn versions:set -DnewVersion=<release version> -DgenerateBackupPoms=false
        svn -m "Setting version for release of <release version>" commit

* mvn -Papache-release clean deploy
* Close staging repository on http://repository.apache.org
* Gather distribution files and upload to people.apache.org
* Start vote

## After a successful vote

* Update site,
* Run the auto-export plugin (else the news on the first page won't be updated correctly)
* Wait until replication to /www/confluence-exports/FTPSERVER has run

        /home/ngn/ftpserver-zip.sh

* Upload XML schema

        scp core/src/main/resources/org/apache/ftpserver/config/spring/ftpserver-1.0.xsd
            @people.apache.org:/www/mina.apache.org/ftpserver
    
* Build and tag

        mvn -Papache-release clean deploy
        svn move -m "Tagging <release version>" 
            https://svn.apache.org/repos/asf/mina/ftpserver/branches/<release version> 
            https://svn.apache.org/repos/asf/mina/ftpserver/tags/<release version>

* Upload to people.apache.org /www/www.apache.org/dist/mina/ftpserver
* Release in JIRA
* Update MINA site (add news and update latest downloads in navigation)
* Wait for mirrors to sync
* Send out announcement

Run script to create documentation ZIP file, on people.apache.org
