---
layout: post
title: "Solving Issues with RVM on BSD"
date: 2014-02-15 03:00
comments: true
categories: 
---
RVM installation went poorly on FreeBSD.  

The ca-certificates weren't up to date according to the install script.

Really, the ca-certificates weren't in the right location for RVM's curl install script.

These commands as root fixed it:

```
mkdir -p /usr/local/opt/curl-ca-bundle
ln -s /usr/local/share/certs/ca-root-nss.crt /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
```
