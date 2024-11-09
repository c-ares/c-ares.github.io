---
layout: page
version:
  version: 1.34.3
  date: "9-nov-2024"
---

- [Download](#download)
- [Features](#features)
  - [Supported RFCs and Proposals](#supported-rfcs-and-proposals)
- [Communication](#communication)
- [Source code](#source-code)
- [Who is c-ares?](#who-is-c-ares)

**c-ares** is a modern DNS (stub) resolver library, written in C. It provides
interfaces for asynchronous queries while trying to abstract the intricacies of
the underlying DNS protocol.  It was originally intended for applications which
need to perform DNS queries without blocking, or need to perform multiple DNS
queries in parallel.

One of the goals of c-ares is to be a better DNS resolver than is provided by
your system, regardless of which system you use.  We recommend using
the c-ares library in all network applications even if the initial goal of
asynchronous resolution is not necessary to your application.

c-ares will build with any C89 compiler and is [MIT licensed](/license.html),
which makes it suitable for both free and commercial software. c-ares runs on
Linux, FreeBSD, OpenBSD, MacOS, Solaris, AIX, Windows, Android, iOS and many
more operating systems.

c-ares has a strong focus on security, implementing safe parsers and data
builders used throughout the code, thus avoiding many of the common pitfalls
of other C libraries.  Through automated testing with our extensive testing
framework, c-ares is constantly validated with a range of static and dynamic
analyzers, as well as being constantly fuzzed by [OSS Fuzz](https://github.com/google/oss-fuzz){:target="_blank"}.

While c-ares has been around for over 20 years, it has been actively maintained
both in regards to the latest DNS RFCs as well as updated to follow the latest
best practices in regards to C coding standards.

## Download

[c-ares {{ page.version.version }}](https://github.com/c-ares/c-ares/releases/download/v{{ page.version.version }}/c-ares-{{ page.version.version }}.tar.gz)
({{ page.version.date }})
[GPG](https://github.com/c-ares/c-ares/releases/download/v{{ page.version.version }}/c-ares-{{ page.version.version }}.tar.gz.asc)
[Changelog](/changelog.html)

You can also [download old packages](/download)

### PGP / GPG Signatures

Valid PGP / GPG signing keys for packages are:
 - Daniel Stenberg &lt;daniel@haxx.se&gt; - [27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2](https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x27edeaf22f3abceb50db9a125cc908fdb71e12c2)
 - Brad House &lt;brad@brad-house.com&gt; - [DA7D64E4C82C6294CB73A20E22E3D13B5411B7CA](https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xda7d64e4c82c6294cb73a20e22e3d13b5411b7ca)


### SLSA Provenance
This project generates SLSA provenance for its releases! This enables you to
verify the integrity of the downloaded artifacts and ensure that the release was
generated from the intended repository.

To verify the provenance of the release, please follow the instructions [here](https://github.com/slsa-framework/slsa-github-generator#verification-of-provenance).


## Features

See [Features](/features)

### Supported RFCs and Proposals
- [RFC1035](https://datatracker.ietf.org/doc/html/rfc1035).
  Initial/Base DNS RFC
- [RFC2671](https://datatracker.ietf.org/doc/html/rfc2671),
  [RFC6891](https://datatracker.ietf.org/doc/html/rfc6891).
  EDNS0 option (meta-RR)
- [RFC3596](https://datatracker.ietf.org/doc/html/rfc3596).
  IPv6 Address. `AAAA` Record.
- [RFC2782](https://datatracker.ietf.org/doc/html/rfc2782).
  Server Selection. `SRV` Record.
- [RFC3403](https://datatracker.ietf.org/doc/html/rfc3403).
  Naming Authority Pointer. `NAPTR` Record.
- [RFC6698](https://datatracker.ietf.org/doc/html/rfc6698).
  DNS-Based Authentication of Named Entities (DANE) Transport Layer Security (TLS) Protocol.
  `TLSA` Record.
- [RFC9460](https://datatracker.ietf.org/doc/html/rfc9460).
  General Purpose Service Binding, Service Binding type for use with HTTPS.
  `SVCB` and `HTTPS` Records.
- [RFC7553](https://datatracker.ietf.org/doc/html/rfc7553).
  Uniform Resource Identifier. `URI` Record.
- [RFC6844](https://datatracker.ietf.org/doc/html/rfc6844).
  Certification Authority Authorization. `CAA` Record.
- [RFC2535](https://datatracker.ietf.org/doc/html/rfc2535),
  [RFC2931](https://datatracker.ietf.org/doc/html/rfc2931).
  `SIG0` Record. Only basic parser, not full implementation.
- [RFC7873](https://datatracker.ietf.org/doc/html/rfc7873),
  [RFC9018](https://datatracker.ietf.org/doc/html/rfc9018).
  DNS Cookie off-path dns poisoning and amplification mitigation.
- [draft-vixie-dnsext-dns0x20-00](https://datatracker.ietf.org/doc/html/draft-vixie-dnsext-dns0x20-00).
  DNS 0x20 query name case randomization to prevent cache poisioning attacks.
- [RFC7686](https://datatracker.ietf.org/doc/html/rfc7686).
  Reject queries for `.onion` domain names with `NXDOMAIN`.
- [RFC2606](https://datatracker.ietf.org/doc/html/rfc2606),
  [RFC6761](https://datatracker.ietf.org/doc/html/rfc6761).
  Special case treatment for `localhost`/`.localhost`.
- [RFC2308](https://datatracker.ietf.org/doc/html/rfc2308),
  [RFC9520](https://datatracker.ietf.org/doc/html/rfc9520).
  Negative Caching of DNS Resolution Failures.
- [RFC6724](https://datatracker.ietf.org/doc/html/rfc6724).
  IPv6 address sorting as used by `ares_getaddrinfo()`.
- [RFC7413](https://datatracker.ietf.org/doc/html/rfc7413).
  TCP FastOpen (TFO) for 0-RTT TCP Connection Resumption.
- [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986).
  Uniform Resource Identifier (URI). Used for server configuration.

## Communication

**Issues** and **Feature Requests** should be reported to our
[GitHub Issues](https://github.com/c-ares/c-ares/issues){:target="_blank"} page.


**Discussions** around c-ares and its use are held on
[GitHub Discussions](https://github.com/c-ares/c-ares/discussions/categories/q-a){:target="_blank"}
or the [Mailing List](https://lists.haxx.se/mailman/listinfo/c-ares){:target="_blank"}.
Mailing list archive [here](https://lists.haxx.se/pipermail/c-ares/){:target="_blank"}.
Please, do not mail volunteers privately about c-ares.

**Security vulnerabilities** are treated according to our
[security procedure](/security.html),
please email c-ares-security at haxx.se if you suspect one.
[Previous security vulnerabilities](/vulns.html).

## Source code

Browse the git repository on [GitHub](https://github.com/c-ares/c-ares){:target="_blank"}.

Check out from git like this:
```
git clone https://github.com/c-ares/c-ares.git
```

## Who is c-ares?

Contributions have been made by [these friendly people](https://github.com/c-ares/c-ares/blob/master/AUTHORS){:target="_blank"}.

c-ares is being used by:
 - [libcurl](https://curl.haxx.se/libcurl/){:target="_blank"}
 - [Wireshark](https://www.wireshark.org/){:target="_blank"}
 - [NodeJS](https://nodejs.org/){:target="_blank"}
 - [UnrealIRCd](https://www.unrealircd.com/){:target="_blank"}
 - [BZFlag](http://www.bzflag.org/){:target="_blank"}
 - [Xymon](http://xymon.sourceforge.net/){:target="_blank"}
 - [libevnet](http://www.25thandclement.com/~william/projects/libevnet.html){:target="_blank"}
 - [gLite](http://glite.web.cern.ch/glite/){:target="_blank"}
 - [aria2](https://aria2.github.io/){:target="_blank"}
 - [sipsak](http://sipsak.org/){:target="_blank"}
 - [Second Life](http://secondlife.com/){:target="_blank"}
 - [Apache Arrow](https://arrow.apache.org/){:target="_blank"}
... and more

Please let us know if you use it!

