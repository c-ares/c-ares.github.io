---
menu: Docs
title: c-ares documentation
layout: page
permalink: /docs/
---

c-ares provides a set of library functions, datatypes, and enumerations
which integrators will use for their implementations.  When you install c-ares,
you get man pages which describe their use and meanings.

{% assign docs_paths = site.pages | where_exp: "page", "page.path contains 'docs/'" | map: "path" | sort -%}
{%- for path in docs_paths -%}
	{%- assign my_page = site.pages | where: "path", path | first -%}
- [{{ my_page.path | replace: "docs/", "" | replace: ".html", "" }}]({{ my_page.path }})
{% endfor -%}

