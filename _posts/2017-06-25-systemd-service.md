---
layout: post
title:  Simple Systemd service for monitor auto-configuration
date:   2017-06-25
categories: ubuntu service systemd monitor user
---

I like to experiment with my laptop testing different combinations of operating systems and desktop managers but it has been a while my systems are quite stable running Xubuntu + [i3](https://i3wm.org/).
Despite I like the minimalistic simplicity of i3, sometimes it requires some kind of hacks to do stuff usually straightforward in other more user-friendly systems.
This post is about a background utility auto-configuring monitor devices connected to my Xubuntu platform.

To configure the monitors I wrote a simple [bash script](https://github.com/lucabaldesi/XWizard/blob/master/xwizard) but I took the chance to integrate it in the _new_ Systemd Ubuntu service manager.

### Systemd

Systemd (and its main command _systemctl_) works with units. A unit any of the system object of interest:
 * a service
 * a device
 * a mount
 * a target
 * ...

All the units share some common properties and methods and each of them can have specific methods.
Each unit is described by a text file named: 

```
<unit_name>.<unit_type>
```
Targets are special unit files which represent system checkpoints, something similar to the old-fashioned _run_levels_.
Target units are used to group the other units.
Given a speicific target unit, a generic unit can specify that:
 * it is part of a it (_WantedBy_)
 * it needs it as a pre-condition (_Wants_)

On start-up the computer will go through all the pre-requisite cascade and reach the default target (which is generally called _multi_user.target_ on a server and _graphical.target_ on a desktop).
In any case, Systemd developers are smart enough to expose a _default.target_ which is a symlink to the current default target unit.

### System or user services
Systemd differentiates between system services and user services; the latters have less privilegies (hence are safer) and can be enabled by a subset of the entire system users.
Technically, the only difference between the two kind of services is the installation folder.

On *buntu, system services are located in _/etc/systemd/system_ while the user services in _/etc/systemd/user_.

I chose the user option and I bundled my script using an on-the-fly [buildeb script]({% post_url 2017-02-10-hello-deb %}).

Note that user services must be enabled manually by the users with:

```
$> systemctl --user enable <service_name>.service

```

### XWizard
Our little service should start with the reaching of the default target and we can add a dependency on the multi-user target as it is a user service so it is run only by user sessions.
Here it is the service unit file:
```
[Unit]
Description=XWizard automatically configure available monitors using xrandr
Wants=multi-user.target

[Service]
TimeoutStartSec=1
ExecStart=/usr/bin/xwizard

[Install]
WantedBy=default.target
```

To install it on a *buntu system, just type:

```
$> git clone https://github.com/lucabaldesi/XWizard
$> ./xwizard.buildeb
#> dpkg -i XWizard.deb
$> systemctl --user enable xwizard.service

```

