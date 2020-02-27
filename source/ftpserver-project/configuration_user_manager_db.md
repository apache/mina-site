---
type: ftpserver
title: FtpServer Database user manager
---

# Database user manager

You can store user user information in a database. JDBC is used to access the database. This user manager has been tested using MySQL, HSQLDB and FireBird database. All the user information is stored in FTP_USER table. An example DDL file for the database is provided in <INSTALL_DIR>/res/ftp-db.sql.

## Database JDBC libraries

You must include the required JAR files for your database in the classpath of FtpServer. Typically you would do this by placing the JAR files in <INSTALL_DIR>/common/lib.

## Example

```xml
<db-user-manager encrypt-passwords="salted">
    <data-source>
        <beans:bean class="some.datasoure.class" />
    </data-source>
    <insert-user>INSERT INTO FTP_USER (userid, userpassword,
        homedirectory, enableflag, writepermission, idletime, uploadrate,
        downloadrate) VALUES ('{userid}', '{userpassword}', '{homedirectory}',
        '{enableflag}', '{writepermission}', {idletime}, {uploadrate},
        {downloadrate})</insert-user>
    <update-user>
        UPDATE FTP_USER SET
            userpassword='{userpassword}',
            homedirectory='{homedirectory}',
            enableflag={enableflag},
            writepermission={writepermission},
            idletime={idletime},
            uploadrate={uploadrate},
            downloadrate={downloadrate}
        WHERE userid='{userid}'
    </update-user>
    <delete-user>
        DELETE FROM FTP_USER WHERE userid = '{userid}'
    </delete-user>
    <select-user>
        SELECT userid, userpassword, homedirectory,
            enableflag, writepermission, idletime, uploadrate, downloadrate 
        FROM FTP_USER 
        WHERE userid = '{userid}'
    </select-user>
    <select-all-users>
        SELECT userid FROM FTP_USER ORDER BY userid
    </select-all-users>
    <is-admin>
        SELECT userid 
        FROM FTP_USER 
        WHERE userid='{userid}' AND userid='admin'
        </is-admin>
    <authenticate>SELECT userpassword from FTP_USER WHERE userid='{userid}'</authenticate>
</db-user-manager>
```

## Configuration Parameters

### db-user-manager element

| Attribute | Description | Required | Default value |
|---|---|---|---|
| encrypt-passwords | It indicates how to stored password are encrypted. Possible values are "clear" for clear text, "md5" for hashed using MD5 or "salted" for hashed salted passwords (including multiple hash iterations). "salted" is encouraged. | No | md5 |


| Child element | Description | Required | Default value |
|---|---|---|---|
| data-source | The data source configured using the regular Spring bean element | Yes | {{< html "&nbsp;" >}} |
| insert-user | The SQL statement to insert a new user. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |
| update-user | The SQL statement to update a user. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |
| delete-user | The SQL statement to delete a user. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |
| select-user | The SQL statement to select a user. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |
| select-all-users | The SQL statement to select all users. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |
| is-admin | The SQL statement to find whether an user is admin or not. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |
| authenticate | The SQL statement to authenticate a user. All the dynamic values will be replaced during runtime. | Yes | {{< html "&nbsp;" >}} |

### Data source configuration

The data source must be configured as described by the database provider. You can also use the general purpose [BasicDataSource](http://jakarta.apache.org/commons/dbcp/apidocs/org/apache/commons/dbcp/BasicDataSource.html) provided by the [Apache Commons DBCP project](http://jakarta.apache.org/commons/dbcp/).

#### Example using the BasicDataSource to connect to MySQL

```xml
<data-source>
    <beans:bean class="org.apache.commons.dbcp.BasicDataSource">
        <beans:property name="driverClassName" value="com.mysql.jdbc.Driver" />
        <beans:property name="url" value="jdbc:mysql://localhost/ftpd" />
        <beans:property name="username" value="myuser" />
              <beans:property name="password" value="secret" />
    </beans:bean>
</data-source>
```

#### FTP_USER Table Structure

| Column | Type | Default value |
|---|---|---|
| userid | VARCHAR(64), Primary key | {{< html "&nbsp;" >}} |
| userpassword | VARCHAR(64) | {{< html "&nbsp;" >}} |
| homedirectory | VARCHAR(128) | {{< html "&nbsp;" >}} |
| enableflag | BOOLEAN | TRUE |
| writepermission | BOOLEAN | FALSE |
| idletime | INT | 0 |
| uploadrate | INT | 0 |
| downloadrate | INT | 0 |
| maxloginnumber | INT | 0 |
| maxloginperip | INT | 0 |
