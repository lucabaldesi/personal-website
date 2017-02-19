---
layout: default
title: Notebook
subtitle: Tips &amp; Tricks
---

{% for post in site.posts %}
## <a id="{{post.title | url_encode }}" href="#{{post.title | url_encode}}"> {{ post.title }} -  *{{ post.date | date: '%B %d, %Y' }}* </a>
{{ post }}
{% endfor %}
