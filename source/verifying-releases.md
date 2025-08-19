---
title: Verifying Releases
---

# Verifying Releases

PGP signing public keys for all releases are available in the [Apache MINA KEYS file](https://downloads.apache.org/mina/KEYS).

Download the GPG keys and import them:

```bash
wget https://downloads.apache.org/mina/KEYS
gpg --import KEYS
```

(Signing keys are also available via the usual key servers.)

Download the release and verify checksums and signatures following the general guidelines given at [Verifying ASF Releases](https://www.apache.org/info/verification.html).
