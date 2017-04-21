---
layout: default
title: Notebook
subtitle: Tips &amp; Tricks
---

{% for post in site.posts %}
### [{{post.title}}]({{post.url}}) -  *{{ post.date | date: '%B %d, %Y' }}* 
{{ post.excerpt }} 
{% endfor %}
