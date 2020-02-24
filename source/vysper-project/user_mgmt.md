---
type: vysper
title: Vysper User Management
---

# User Management

Apache Vysper comes with very basic user management support out of the box. But, frequently you would rather want to integrate Vysper with your already existing authentication solution. To enable this, Vysper comes with a simple API to implement your own authentication and user management.

## Authentication

UserAuthentication is the interface which will get called when a client authenticates itself using SASL. Vysper currently ships with two implementations, one in-memory and one based on JCR. To write your own, simple create a class which implements UserAuthentication. In the example below, we implement an authentication provider backed by an LDAP directory.

```java
public class MyLdapAuthentication implements UserAuthentication {
    @Override
    public boolean verifyCredentials(Entity jid, String passwordCleartext, Object credentials) {
        Hashtable<String, String> env = new Hashtable<String, String>();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, "ldap://localhost:389/");

        env.put(Context.SECURITY_AUTHENTICATION, "simple");
    
        // extract the user name from the entity, e.g. from foo@example.com, foo will be used
            env.put(Context.SECURITY_PRINCIPAL, String.format("cn=%s, ou=Users, o=Acme", jid.getNode()));
        env.put(Context.SECURITY_CREDENTIALS, passwordCleartext);

        try {
            // connect and authenticate with the directory
            new InitialDirContext(env);
            return true;
        } catch (NamingException e) {
            return false;
        }
    }
}
```

Next, you need to hook the authentication provider into the Vysper XMPP server:

```java
public static void main(String[] args) throws Exception {
    OpenStorageProviderRegistry providerRegistry = new OpenStorageProviderRegistry();
    
    // add your custom authentication provider
    providerRegistry.add(new MyLdapAuthentication());
    
    // a roster manager is also required
    providerRegistry.add(new MemoryRosterManager());

    XMPPServer server = new XMPPServer("acme.com");

    // other initialization
    // ...

    server.setStorageProviderRegistry(providerRegistry);

    server.start();
}
```

In this example, we use the OpenStorageProviderRegistry to provide the different storage providers. Only two are required, UserAuthentication and RosterManager.

That's all that's needed to implement a custom authentication provider.

## User management

Some Vysper modules, in particular in-band registration and service administration, requires the ability to add users and change users password. For that, Vysper uses the interface AccountManagement. This interface has three methods:

* addUser(username, password): to add a new user
* changePassword(username, newPassword): to change the password of a user
* verifyAccountExists(username): checks if a user exists

If you need to make use of any of these modules, provide an AccountManagement implementation in OpenStorageProviderRegistry as in the example above.
