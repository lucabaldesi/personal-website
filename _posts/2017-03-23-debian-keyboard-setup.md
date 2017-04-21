---
layout: post
title:  Debian keyboard setup
date:   2017-03-23
categories: debian ubuntu keyboard
---

I struggled a bit trying to obtain a keyboard setup for my US keyboards enabling me to use letters with accents.
So I report my configuration for future look-ups.
(Note: I use the left Window button to activate the accent feature)

This is the content of the file _/etc/default/keyboard/_:
```
XKBMODEL="pc105"
XKBLAYOUT="us"
XKBOPTIONS="compose:lwin"

BACKSPACE="guess"
XKBVARIANT=""

```

