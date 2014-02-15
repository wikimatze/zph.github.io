---
layout: post
title: "Finding myself in BSD"
date: 2014-02-15 02:01
comments: true
categories: 
---

Blame smartOS not reading my SATA controller.

Blame Linux for not having first class support for ZFS (where my data is held).

Blame [ @canadiancreed ]( https://twitter.com/canadiancreed ) for giving me a way out of the quandry.

The backstory is that I moved all of my backups to two ZFS pools a few years ago.  I was running ZFSonLinux and it generally worked.... except when I rebooted the server and had to force import the pools.

Fast forward to that server being replaced by a workstation (i7 Haswell, 240GB Sata3 SSD, and 24GB RAM).  I tried smartOS by Joyent and ran into issues with my SATA controller not being recognized.  It's a shame given how awesome the smartOS vm administration is.  I mean vmadm and imgadm are light years ahead of Docker.

Since smartOS refused to recognize 3 of my 8 drives I ran back to Linux.  The good new, Linux recognized the sata controller.  The bad news, Linux couldn't import the pools.  Frankly, Linux had a hell of a time with building the ZFS on Linux kernel modules.  I managed to piece together a few clues from the ZFSonLinux Issues on Github.  In fact, thanks to [ @dajhorn ]( https://github.com/dajhorn ) for supplying answers on that Github issue which allowed me to build the kernel modules.

This sounds promising doesn't it? It's not, it was a horrorshow.  Linux refused to import the one of the two zpools.  One of them imported nicely, the mission critical financial records.  The other semi-critical zpool was shot and refused to import under Linux.

I spent a whole evening banging my head against this issue. If it hadn't been for [ Chris Reed ]( https://twitter.com/canadiancreed ) I wouldn't have hit upon the solution.

His recommendation was to try FreeBSD... so I did.  And it recognized the SATA controller and also imported the zpools cleanly!  So after a dry run w/ FreeBSD, I installed PC-BSD, which is a desktop variant based on FreeBSD. Think of it as the Ubuntu of the BSD world.  And hell yeah, it's all working :).

So far, I'm really liking it.  Replace 'aptitude' with 'pkg' and it's pretty similar.  Except, PC-BSD is working where Linux & ZFS were a hassle.
