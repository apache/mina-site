---
type: sshd
title: Apache SSHD 2.19.0 Release
version: 2.19.0
---

# Overview

## Bug Fixes

* [GH-899](https://github.com/apache/mina-sshd/issues/899) Fix `ProcessShellFactory` on Linux
* [GH-902](https://github.com/apache/mina-sshd/pull/902) Fix client-side handling of sk-* public key signatures (also in the agent interfaces)
* Limit size of decompressed SSH packets
* Improve checking SSH user certificates in public-key authentication
* Improve handling of repository paths in `sshd-git` on Windows
* Validate file names in SCP
* Escape newlines in filenames in the SCP protocol
* Restrict JGit commands accessible via `GitPgmCommandFactory` in `sshd-git`

## New Features

None.

## Potential Compatibility Issues

### Restrict JGit commands accessible via `GitPgmCommandFactory` in `sshd-git`

Bundle `sshd-git` contains a `GitPgmCommandFactory` that can be configured for an Apache MINA SSHD server.
It enables remote execution of git commands via JGit.

However, running arbitrary git commands remotely is an exotic use case, and some commands (like
`git archive --format zip --output somefile.zip` or also `git clone`  or `git checkout`) could even create
files on the server. This should be only allowed in an OS-level chrooted environment, which Apache MINA
SSHD does not and cannot provide.

We have therefore limited the available commands to a small set of whitelisted git commands that might
be useful as maintenance commands for authorized power users on a git server implemented based on `sshd-git`.
The command are: `archive`, `blame`, `branch`, `describe`, `diff`, `gc`, `log`, `reflog`, `show`, and `status`.
All these commands can be executed from an client via `git --git-dir <repo> <command> <args>`, where `<repo>`
is the server-side name of the git repository (its local path on the server relative to the configured
root), `<command>` is the command name (e.g., `archive`) and `<args>` are the command arguments. Results are
sent back via the command output streams (output or error streams) and are thus sent back to the client.
For the `archive`command, the `--output` (or `-o`) argument is ignored; the archive is always returned via
the command's output stream and this is also sent to the client.

Applications that might have relied on the ability to run other JGit command remotely may no longer work.
Either implement your own dedicated command factory to enable accesss to certain commands, or set the
property `GitModuleProperties.RESTRICT_COMMANDS` to `false` on the server-side `SshServer` (for all sessions)
or on particular `ServerSession`s (for particular individual sessions) to re-enable access to _all_ commands
supported by JGit.

## Major Code Re-factoring

None.

# Getting the Distributions

* Source distributions:
    * [Apache Mina SSHD {{< version >}} Sources (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Sources (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}-src.zip.sha512)
* Binary distributions:
    * [Apache Mina SSHD {{< version >}} Binary (.tar.gz)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.tar.gz.sha512)
    * [Apache Mina SSHD {{< version >}} Binary (.zip)](https://www.apache.org/dyn/closer.lua/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip) [PGP](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.asc) [SHA512](https://downloads.apache.org/mina/sshd/{{< version >}}/apache-sshd-{{< version >}}.zip.sha512)

PGP signing public keys for all releases are available in the [Apache MINA KEYS file](https://downloads.apache.org/mina/KEYS).

Please report any feedback to [users@mina.apache.org](mailto:users@mina.apache.org).
