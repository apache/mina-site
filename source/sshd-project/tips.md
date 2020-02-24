---
type: sshd
title: SSHD Tips
---

# How to execute commands as processes on the server side?

If you want the SSH server to support direct command execution, you need to configure it with a Factory<Command> which will allow that.
    
It can be done using the following code:

```java
sshd.setCommandFactory(new ScpCommandFactory(new CommandFactory() {
    public Command createCommand(String command) {
        return new ProcessShellFactory(command.split(<SPAN class="code-quote">" ")).create();
    }
}));
```

This way, you can use the following:

```bash
ssh -p 8202 localhost ls -l
```
