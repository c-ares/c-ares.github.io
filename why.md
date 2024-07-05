---
layout: page
title: Why does c-ares exist?
menu: Why
---

A couple of decades ago [Daniel Stenberg](https://daniel.haxx.se/)
started looking for an asynchronous DNS resolver library to use in
[libcurl](https://curl.se/libcurl/). Through this process, someone pointed out
the ares library ([archived here](https://github.com/mit-athena/libares/))
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
- Should not rely on hardware or compiler specifics, e.g. endianess and size/alignment of primitive types.
- Should be no worse, and optimally better than the system's native resolver.

### 5. Multi-threading
- Must not require multi-threading.
- Must work correctly in multi-threaded environments.

### 6. Licensing
- Must allow use in Open Source and proprietary projects.
