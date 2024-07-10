---
layout: page
title: Why does c-ares exist?
menu: Why
---

A couple of decades ago [Daniel Stenberg](https://daniel.haxx.se/){:target="_blank"}
started looking for an asynchronous DNS resolver library to use in
[libcurl](https://curl.se/libcurl/){:target="_blank"}. Through this process,
someone pointed out the ares library
([archived here](https://github.com/mit-athena/libares/){:target="_blank"})
and eureka! This was almost exactly what he was looking for, for use in
libcurl. We started expanding it and soon discovered that the ares author wasn't
prepared to accept the changes we deemed necessary, and so c-ares was born.

Over the course of the last couple of decades, the code may no longer resemble
the original ares code, but the public API is still heavily influenced by it
as we strive to maintain API and ABI compatibility across versions.

## Resolver Library Requirements

### 1. Interface
 - Asynchronous interface should be based on non-blocking sockets.
 - Must not use signals as a mean of communication.

### 2. Queries
- Must support both IPv4 and IPv6 addresses.
- Must support hostname and address lookup (A and PTR types)
- Must support other types of lookup (e.g. CNAME and MX types)

### 3. Integration
- Should integrate easily with applications.

### 4. Portability
- Must be portable to most commonly used platforms (Linux, Solaris, Win32, etc).
- Should be portable to as many platforms as possible.
- Should not rely on hardware or compiler specifics, e.g. endianess and
  size/alignment of primitive types.
- Should be no worse, and optimally better than the system's native resolver.

### 5. Multi-threading
- Must not require multi-threading.
- Must work correctly in multi-threaded environments.

### 6. Licensing
- Must allow use in Open Source and proprietary projects.

## What Other Libraries Are There?

Some of these libraries existed at the time we started looking for one to use,
but several have appeared or changed a lot since.

- glibc-2.2.4: (and maybe a few earlier releases) provides a new function
  getaddrinfo_a() -- similar to getaddrinfo(), but asynchronous.  results can be
  collected by polling or notified using a signal. This is probably the right
  thing to do on linux, although the use of a signal handler within the library
  could be problematic (if a linking application also wants to use the same
  signal).
- [ADNS](http://www.chiark.greenend.org.uk/~ian/adns/){:target="_blank"}:
  ADNS is a GPL library which provides async DNS lookup.
- [Mozilla netlib](http://www.mozilla.org/docs/netlib/){:target="_blank"}:
  Provides an async DNS lookup abstraction, and per-platform backend
  implementations.  it's written on top of the NSPR (portable runtime), and so
  it's use would require a whole chunk of Mozilla code.
- arlib: BIND v4.9.5's contrib section had a thing called arlib, from Darren
  Reed. looks pretty simple.  its licence prohibits redistribution without
  explicit permission. It doesn't seem to be in BIND9 though, so it might not
  work anymore.
- [FireDNS](http://directory.fsf.org/project/FireDNS/){:target="_blank"}:
  GPL. We asked the author about reconsidering the license. No luck.
- [djbdns](http://cr.yp.to/djbdns.html){:target="_blank"}:
  Written by Dan Bernstein and dedicated to the public domain.
- [Poslib](http://www.posadis.org){:target="_blank"}:
  GPL. A DNS client/server library written in C++. Available for many platforms,
  including Linux, FreeBSD, other Unices and Windows.
- [UDNS](http://www.corpit.ru/mjt/udns.html){:target="_blank"}:
  LGPL license. A newcomer that seems to address claimed shortcomings in ADNS
  and c-ares.
- [dns.c](http://25thandclement.com/~william/projects/dns.c.html){:target="_blank"}:
  MIT-style license. A recursive, reentrant, non-blocking DNS resolver library
  in a single .c file.

