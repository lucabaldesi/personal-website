---
layout: post
title:  Simple Upstart service for monitor auto-configuration
date:   2017-06-25
categories: ubuntu service upstart monitor user
---

I like to experiment with my laptop testing different combinations of operating systems and desktop managers but it has been a while my systems are quite stable running Xubuntu + [i3](https://i3wm.org/).
Despite I like the minimalistic simplicity of i3, sometimes it requires some kind of hacks to do stuff usually straightforward in other more user-friendly systems.
This post is about a background utility auto-configuring monitor devices connected to my Xubuntu platform.

To configure the monitors I wrote a simple [bash script](https://github.com/lucabaldesi/XWizard/blob/master/xwizard) but I took the chance to integrate it in the _new_ Upstart Ubuntu service manager.

In Upstart there exists two different kind of services, system services and user services; the formers are installed system-wide while the latters may or may not be installed by users.
I chose the second option and I bundled my script using an on-the-fly [buildeb script](/ubuntu/bash/deb/2017/02/10/hello-deb.html).

To install it on a *buntu system, just type:

```
$> git clone https://github.com/lucabaldesi/XWizard
$> ./xwizard.buildeb
#> dpkg -i XWizard.deb
$> systemctl --user enable xwizard.service

```

