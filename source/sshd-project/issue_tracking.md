---
type: sshd
title: SSHD Issue Tracking
---

# Issue Tracking

We are using two issue tracking systems to track all SSHD issues including bugs. Use either one, but please don't file the same issue at both.

* Issues can be filed on [GitHub issues](https://github.com/apache/mina-sshd/issues).
* The [JIRA issue tracker](https://issues.apache.org/jira/browse/SSHD) is the traditional issue tracker of the project.

If neither option is suitable for you, issues can also be reported via [e-mail](./mailing_lists.html) as a last resort.

## How to report a bug

Writing a bug report with detailed information will help us to fix your problem sooner.

* Make sure if the bug you are going to report doesn't exist yet.
* Attaching JUnit test case which reproduces the problem will put your report in our highest priority.
* Attach full thread stack dump if you suspect a dead lock.
* Attach full heap dump if you suspect a memory leak.
* Specify the environment in detail as much as possible.
    * Operating system version, distribution, architecture, ...
    * JVM vendor, version, build number, command line arguments, ...
    * Network settings
