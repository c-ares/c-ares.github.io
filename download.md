---
title: Download c-ares
layout: page
permalink: /download/
versions:
  - version: 1.32.1
    date: "7-jul-2024"
  - version: 1.32.0
    date: "4-jul-2024"
  - version: 1.31.0
    date: "18-jun-2024"
  - version: 1.30.0
    date: "7-jun-2024"
  - version: 1.29.0
    date: "24-may-2024"
    linkdest: cares
  - version: 1.28.1
    date: "30-mar-2024"
    linkdest: cares
  - version: 1.28.0
    date: "29-mar-2024"
    linkdest: cares
  - version: 1.27.0
    date: "23-feb-2024"
    linkdest: cares
  - version: 1.26.0
    date: "26-jan-2024"
    linkdest: cares
  - version: 1.25.0
    date: "3-jan-2024"
    linkdest: cares
  - version: 1.24.0
    date: "17-dec-2023"
    linkdest: cares
  - version: 1.25.0
    date: "3-jan-2024"
    linkdest: cares
  - version: 1.24.0
    date: "17-dec-2023"
    linkdest: cares
  - version: 1.23.0
    date: "30-nov-2023"
    linkdest: cares
  - version: 1.22.1
    date: "19-nov-2023"
    linkdest: cares
  - version: 1.22.0
    date: "14-nov-2023"
    linkdest: cares
  - version: 1.21.0
    date: "27-oct-2023"
    linkdest: cares
  - version: 1.20.1
    date: "8-oct-2023"
    linkdest: cares
  - version: 1.20.0
    date: "7-oct-2023"
    linkdest: cares
  - version: 1.19.1
    date: "22-may-2023"
    linkdest: cares
  - version: 1.19.0
    date: "28-jan-2023"
    linkdest: cares
  - version: 1.18.1
    date: "27-oct-2021"
    linkdest: cares
  - version: 1.18.0
    date: "25-oct-2021"
    linkdest: cares
  - version: 1.17.2
    date: "10-aug-2021"
    linkdest: cares
  - version: 1.17.1
    date: "19-nov-2020"
    linkdest: cares
  - version: 1.17.0
    date: "16-nov-2020"
    linkdest: c-ares
  - version: 1.16.1
    date: "11-may-2020"
    linkdest: cares
  - version: 1.16.0
    date: "13-mar-2020"
    linkdest: cares
  - version: 1.15.0
    date: "23-oct-2018"
    linkdest: cares
  - version: 1.14.0
    date: "16-feb-2018"
    linkdest: cares
  - version: 1.13.0
    date: "20-jun-2017"
    linkdest: archive
  - version: 1.12.0
    date: "29-sep-2016"
    linkdest: archive
  - version: 1.11.0
    date: "19-feb-2016"
    linkdest: archive
  - version: 1.10.0
    date: "12-may-2013"
    linkdest: archive
  - version: 1.9.1
    date: "18-jun-2012"
    linkdest: archive
  - version: 1.9.0
    date: "17-jun-2012"
    linkdest: archive
  - version: 1.8.0
    date: "27-apr-2012"
    linkdest: archive
  - version: 1.7.5
    date: "16-aug-2011"
    linkdest: archive
  - version: 1.7.4
    date: "9-dec-2010"
    linkdest: archive
  - version: 1.7.3
    date: "11-jun-2010"
    linkdest: archive
  - version: 1.7.2
    date: "10-jun-2010"
    linkdest: archive
  - version: 1.7.1
    date: "23-mar-2010"
    linkdest: archive
  - version: 1.7.0
    date: "30-nov-2009"
    linkdest: archive
  - version: 1.6.0
    date: "9-dec-2008"
    linkdest: archive
  - version: 1.5.3
    date: "29-aug-2008"
    linkdest: archive
  - version: 1.5.2
    date: "29-may-2008"
    linkdest: archive
  - version: 1.5.1
    date: "21-nov-2007"
    linkdest: archive
  - version: 1.5.0
    date: "21-nov-2007"
    linkdest: archive
  - version: 1.4.0
    date: "8-jun-2007"
    linkdest: archive
  - version: 1.3.2
    date: "3-nov-2006"
    linkdest: archive
  - version: 1.3.1
    date: "23-jun-2006"
    linkdest: archive
  - version: 1.3.0
    date: "29-aug-2005"
    linkdest: archive
  - version: 1.2.1
    date: "20-oct-2004"
    linkdest: archive
  - version: 1.2.0
    date: "13-apr-2004"
    linkdest: archive
  - version: 1.1.0
    date: "11-mar-2004"
    linkdest: archive
  - version: 1.0.0
    date: "3-feb-2004"
    linkdest: archive

---

These packages are provided as a service to whoever might find these useful. Please consider always getting and using the most recent version, we have maintained API and ABI compatibility between releases since v1.7.0 in 2009. We do not create releases for bugfixes or security fixes for prior versions, however, we do maintain some prior version branches where we backport fixes for about a year from the release of that version.

Valid PGP / GPG signing keys for packages are:

 - Daniel Stenberg &lt;daniel@haxx.se&gt; - [27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2](https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x27edeaf22f3abceb50db9a125cc908fdb71e12c2)
 - Brad House &lt;brad@brad-house.com&gt; - [DA7D64E4C82C6294CB73A20E22E3D13B5411B7CA](https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xda7d64e4c82c6294cb73a20e22e3d13b5411b7ca)

### Releases

{% for version in page.versions -%}
  {%- if version.linkdest == "cares" -%}
    {% capture url %}https://github.com/c-ares/c-ares/releases/download/cares-{{ version.version | replace: ".", "_" }}/c-ares-{{ version.version }}.tar.gz{% endcapture %}
  {%- elsif version.linkdest == "c-ares" -%}
    {% capture url %}https://github.com/c-ares/c-ares/releases/download/c-ares-{{ version.version | replace: ".", "_" }}/c-ares-{{ version.version }}.tar.gz{% endcapture %}
  {%- elsif version.linkdest == "archive" -%}
    {% capture url %}/archive/c-ares-{{ version.version }}.tar.gz{% endcapture %}
  {%- else -%}
    {% capture url %}https://github.com/c-ares/c-ares/releases/download/v{{ version.version }}/c-ares-{{ version.version }}.tar.gz{% endcapture %}
  {%- endif %}
- [c-ares {{ version.version }}]({{ url }}) ({{ version.date }}) [GPG]({{ url }}.asc) [Changelog](/changelog.html#{{ version.version | replace: ".", "_" }})
{%- endfor %}


The c-ares project started off from the ares code base: <a href="/archive/ares-1.1.1.tar.gz">ares 1.1.1</a> (18-may-2001)
