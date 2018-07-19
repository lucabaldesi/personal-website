---
layout: default
title: Links
subtitle: Useful, random links
---

{% for link in site.data.links %}
#### [{{link.name}}]({{link.url}})
{{link.description}}
{% endfor %}
