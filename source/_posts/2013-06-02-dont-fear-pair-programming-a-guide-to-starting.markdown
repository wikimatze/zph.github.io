---
layout: post
title: Don't fear pair programming - A Guide to Starting
tags: []
status: publish
type: post
published: true
alias: /2013/06/dont-fear-pair-programming-a-guide-to-starting/
meta:
  mkd_text: |-
    Pair Programming is becoming a big deal in the Ruby programming world: this guide will help you get started.

    ## Pre-Reqs:
    General familiarity with Ruby tools (Bundler, Gems, RVM/Rbenv)
    Basic commandline comfort

    ## What is Pairing?
    In its simplest form, pair programming is where a pair of programmers work on a problem using the same computer.

    Since I live don't live in a technology hub in America, programming in the same physical location is challenging.  Instead, it's possible to replicate that experience with both parties in separate locations.

    ## How Does it Work?
    Setup a video call using Skype, Google Plus, Twelephone.
    Both partners connect into a shared machine such as a Virtual Private Server (VPS).
    Each partner connects into a shared Tmux session.
    Both of the individuals can jointly edit the same files, as if they were present at the same keyboard.

    ## Setting It Up From Scratch
    Signup with a VPS provider (I'm currently very happy with [DigitalOcean](www.digitalocean.com))
    Boot up a basic 512MB RAM instance in the Linux flavor of your choice. I'll use Ubuntu 12.04 x32 for this example.
    Once the instance is booted up, let's connect and setup basic sane defaults.
    Install tmux and vim-nox using the package manager.
    Install Ruby using RVM, Rbenv, or Chruby.
    Install Tweemux Gem - `gem install tweemux`
    Now that we've laid the groundwork for it, let's work on making it available for a partner.

    ## Inviting a Pair
    When ready to invite a pairing partner, we start by adding a unique user for them.  For convenience, it's best to add their username from Github.

    `adduser --disabled-password $PAIRNAME`

    Next we'll use the Tweemux Gem from RKing to pull down the partner's public key from Github, and add it to their `~/.ssh/authorized_keys`.

    `tweemux hubkey $PAIRNAME`

    At this point in the process, that user can login to your server using the IP address, their Github username, and their matching private key.

    ie - `ssh $PAIRNAME@IP_ADDRESS_OF_SERVER`

    At this point, the host should fire up a shared Tmux session:

    `tmux -S /tmp/pair`

    And enable that socket to be world readable:

    `chmod 777 /tmp/pair`

    NOTE: Doing this on anything other than a bare server, or with someone you don't trust, isn't a secure or a good idea.  Don't do this on a production server or with sketchy folks!

    Next, it's time for the guest to join the shared Tmux session:

    `tmux -S /tmp/pair attach`

    And you're both in the same Tmux session!  The view, keyboard and such is all shared =).
  _pingme: '1'
  _encloseme: '1'
  _clicky_goal: a:2:{s:2:"id";N;s:5:"value";N;}
:alias: /2013/06/dont-fear-pair-programming-a-guide-to-starting.markdown/
---
<p>Pair Programming is becoming a big deal in the Ruby programming world: this guide will help you get started.</p>

<h2>Pre-Reqs:</h2>

<p>General familiarity with Ruby tools (Bundler, Gems, RVM/Rbenv)
Basic commandline comfort</p>

<h2>What is Pairing?</h2>

<p>In its simplest form, pair programming is where a pair of programmers work on a problem using the same computer.</p>

<p>Since I live don't live in a technology hub in America, programming in the same physical location is challenging.  Instead, it's possible to replicate that experience with both parties in separate locations.</p>

<h2>How Does it Work?</h2>

<p>Setup a video call using Skype, Google Plus, Twelephone.
Both partners connect into a shared machine such as a Virtual Private Server (VPS).
Each partner connects into a shared Tmux session.
Both of the individuals can jointly edit the same files, as if they were present at the same keyboard.</p>

<h2>Setting It Up From Scratch</h2>

<p>Signup with a VPS provider (I'm currently very happy with <a href="www.digitalocean.com">DigitalOcean</a>)
Boot up a basic 512MB RAM instance in the Linux flavor of your choice. I'll use Ubuntu 12.04 x32 for this example.
Once the instance is booted up, let's connect and setup basic sane defaults.
Install tmux and vim-nox using the package manager.
Install Ruby using RVM, Rbenv, or Chruby.
Install Tweemux Gem - <code>gem install tweemux</code>
Now that we've laid the groundwork for it, let's work on making it available for a partner.</p>

<h2>Inviting a Pair</h2>

<p>When ready to invite a pairing partner, we start by adding a unique user for them.  For convenience, it's best to add their username from Github.</p>

<p><code>adduser --disabled-password $PAIRNAME</code></p>

<p>Next we'll use the Tweemux Gem from RKing to pull down the partner's public key from Github, and add it to their <code>~/.ssh/authorized_keys</code>.</p>

<p><code>tweemux hubkey $PAIRNAME</code></p>

<p>At this point in the process, that user can login to your server using the IP address, their Github username, and their matching private key.</p>

<p>ie - <code>ssh $PAIRNAME@IP_ADDRESS_OF_SERVER</code></p>

<p>At this point, the host should fire up a shared Tmux session:</p>

<p><code>tmux -S /tmp/pair</code></p>

<p>And enable that socket to be world readable:</p>

<p><code>chmod 777 /tmp/pair</code></p>

<p>NOTE: Doing this on anything other than a bare server, or with someone you don't trust, isn't a secure or a good idea.  Don't do this on a production server or with sketchy folks!</p>

<p>Next, it's time for the guest to join the shared Tmux session:</p>

<p><code>tmux -S /tmp/pair attach</code></p>

<p>And you're both in the same Tmux session!  The view, keyboard and such is all shared =).</p>
