---
layout: page
version:
  version: 1.32.1
  date: "7-jul-2024"
---

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
analyzers, as well as being constantly fuzzed by [OSS Fuzz](https://github.com/google/oss-fuzz).

While c-ares has been around for over 20 years, it has been actively maintained
both in regards to the latest DNS RFCs as well as updated to follow the latest
best practices in regards to C coding standards.

## Download

[c-ares {{ page.version.version }}](https://github.com/c-ares/c-ares/releases/download/v{{ page.version.version }}/c-ares-{{ page.version.version }}.tar.gz)
({{ page.version.date }})
[GPG](https://github.com/c-ares/c-ares/releases/download/v{{ page.version.version }}/c-ares-{{ page.version.version }}.tar.gz.asc)
[Changelog](/changelog.html)

Valid PGP / GPG signing keys for packages are:
 - Daniel Stenberg &lt;daniel@haxx.se&gt; - [27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2](https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x27edeaf22f3abceb50db9a125cc908fdb71e12c2)
 - Brad House &lt;brad@brad-house.com&gt; - [DA7D64E4C82C6294CB73A20E22E3D13B5411B7CA](https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xda7d64e4c82c6294cb73a20e22e3d13b5411b7ca)

You can also [download old packages](/download)

## Communication

**Issues** and **Feature Requests** should be reported to our
[GitHub Issues](https://github.com/c-ares/c-ares/issues) page.


**Discussions** around c-ares and its use are held on
[GitHub Discussions](https://github.com/c-ares/c-ares/discussions/categories/q-a)
or the [Mailing List](https://lists.haxx.se/mailman/listinfo/c-ares).
Mailing list archive [here](https://lists.haxx.se/pipermail/c-ares/).
Please, do not mail volunteers privately about c-ares.

**Security vulnerabilities** are treated according to our
[security procedure](/security.html),
please email c-ares-security at haxx.se if you suspect one.
[Previous security vulnerabilities](/vulns.html).

## Source code

Browse the git repository on [GitHub](https://github.com/c-ares/c-ares).

Check out from git like this:
```
git clone https://github.com/c-ares/c-ares.git
```


## Who is c-ares?

Contributions have been made by [these friendly people](https://github.com/c-ares/c-ares/blob/master/AUTHORS).

c-ares is being used by:
 - [libcurl](https://curl.haxx.se/libcurl/)
 - [Wireshark](https://www.wireshark.org/)
 - [NodeJS](https://nodejs.org/)
 - [UnrealIRCd](https://www.unrealircd.com/)
 - [BZFlag](http://www.bzflag.org/)
 - [Xymon](http://xymon.sourceforge.net/)
 - [libevnet](http://www.25thandclement.com/~william/projects/libevnet.html)
 - [gLite](http://glite.web.cern.ch/glite/)
 - [aria2](https://aria2.github.io/)
 - [sipsak](http://sipsak.org/)
 - [Second Life](http://secondlife.com/)
 - [Apache Arrow](https://arrow.apache.org/)
... and more

Please let us know if you use it!

