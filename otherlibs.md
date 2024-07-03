---
layout: page
title: What Other Libraries Are There?
permalink: /otherlibs/
menu: Other Libs
---

Some of these libraries existed at the time we started looking for one to use,
but several have appeared or changed a lot since.

- glibc-2.2.4: (and maybe a few earlier releases) provides a new function
  getaddrinfo_a() -- similar to getaddrinfo(), but asynchronous.  results can be
  collected by polling or notified using a signal. This is probably the right
  thing to do on linux, although the use of a signal handler within the library
  could be problematic (if a linking application also wants to use the same
  signal).
- [ADNS](http://www.chiark.greenend.org.uk/~ian/adns/): ADNS is a GPL library
  which provides async DNS lookup.
- [Mozilla netlib](http://www.mozilla.org/docs/netlib/): Provides an async DNS
  lookup abstraction, and per-platform backend implementations.  it's written on
  top of the NSPR (portable runtime), and so it's use would require a whole
  chunk of Mozilla code.
- arlib: BIND v4.9.5's contrib section had a thing called arlib, from Darren
  Reed. looks pretty simple.  its licence prohibits redistribution without
  explicit permission. It doesn't seem to be in BIND9 though, so it might not
  work anymore.
- [FireDNS](http://directory.fsf.org/project/FireDNS/): GPL. We asked the author
  about reconsidering the license. No luck.
- [djbdns](http://cr.yp.to/djbdns.html): Written by Dan Bernstein and dedicated
  to the public domain.
- [Poslib](http://www.posadis.org): GPL. A DNS client/server library written in
  C++. Available for many platforms, including Linux, FreeBSD, other Unices
  and Windows.
- [UDNS](http://www.corpit.ru/mjt/udns.html): LGPL license. A newcomer that
  seems to address claimed shortcomings in ADNS and c-ares.
- [dns.c](http://25thandclement.com/~william/projects/dns.c.html): MIT-style
  license. A recursive, reentrant, non-blocking DNS resolver library in a single
  .c file.


