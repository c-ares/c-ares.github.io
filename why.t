#include "doctype.t"
<head>
<title>c-ares: Reasons for Existance</title>
#include "css.t"
</head>
#include "body.t"
#include "setup.t"
#include "menu.t"

TITLE(Why does c-ares exist?)
BOXTOP

<p>
A couple of decades ago <a href="https://daniel.haxx.se/">Daniel Stenberg</a>
started looking for an asynchronous DNS resolver library to use in
<a href="http://curl.haxx.se/libcurl/">libcurl</a>. Through this process,
someone pointed out the
<a href="ftp://athena-dist.mit.edu/pub/ATHENA/ares">ares</a>
library and eureka! This was almost exactly what he was looking for, for use in
libcurl. We started expanding it and soon discovered that the ares author wasn't
prepared to accept the changes we deemed necessary, and so c-ares was born.

<p>
Over the course of the last couple of decades, the code may no longer resemble
the original ares code, but the public API is still heavily influenced by it
as we strive to maintain API and ABI compatibility across versions.

<h2>Resolver Library Requirements</h2>

SUBTITLE(1. Interface)
<ul>
  <li>Asynchronous interface should be based on non-blocking sockets.</li>
  <li>Must not use signals as a mean of communication.</li>
</ul>

SUBTITLE(2. Queries)
<ul>
 <li>Must support both IPv4 and IPv6 addresses.</li>
 <li>Must support hostname and address lookup (A and PTR types)</li>
 <li>Must support other types of lookup (e.g. CNAME and MX types)</li>
</ul>

SUBTITLE(3. Integration)
<ul>
 <li>Should integrate easily with applications.</li>
</ul>

SUBTITLE(4. Portability)
<ul>
 <li>Must be portable to most commonly used platforms (Linux, Solaris, Win32, etc).</li>
 <li>Should be portable to as many platforms as possible.</li>
 <li>Should not rely on hardware or compiler specifics, e.g. endianess and size/alignment of primitive types.</li>
 <li>Should be no worse, and optimally better than the system's native resolver.</li>
</ul>

SUBTITLE(5. Multi-threading)
<ul>
 <li>Must not require multi-threading.</li>
 <li>Must work correctly in multi-threaded environments.</li>
</ul>

SUBTITLE(6. Licensing)
<ul>
 <li>Must allow use in Open Source and proprietary projects.</li>
</ul>

BOXBOT

#include "footer.t"
