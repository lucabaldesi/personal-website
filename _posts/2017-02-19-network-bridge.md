---
layout: post
title:  GNU anyware as middlebox
date:   2017-02-19
categories: bash networking
---

Sometimes it happens one needs to set a device as a nat/router middlebox.
Here is the (self-explanatory) commands needed on a GNU OS to set up a NAT/router functionalities.

```
#!/bin/bash
OUTER_IF="wlan0"
INNER_IF="eth0"
sysctl net.ipv4.ip_forward=1
sysctl -p
iptables -t nat -A POSTROUTING --out-interface $OUTER_IF -j MASQUERADE  
iptables -A FORWARD --in-interface $INNER_IF -j ACCEPT
```

Obviously, you also need to assign IP address. You can choose between setting up a DHCP or some good ol' fashioned static address, e.g.:

``
sudo ip add add 192.168.0.1/24 dev $INNER_IF
``
