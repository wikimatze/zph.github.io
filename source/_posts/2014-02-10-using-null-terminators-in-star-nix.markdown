---
layout: post
title: Using Null Terminators in Linux
date: 2014-02-10 20:11
comments: true
categories: 
---
I ran into an issue with using `xargs` with `rm -rf`.

This could be dicey, so get your safety hats on.

The issue was that the filename included an apostrophe.  So when trying to do a simple command such as `tree -fi | grep conflicted | xargs rm -f '{}'`, I received an error about having an unterminated quote in the parameter.

Apparently, some versions of xargs allow you to specify a delimiter with a `-d` but the copy on my Mac didn't have such a flag.

Instead, I learned that `egrep --null` will use a null character as the divider between matches.  So the following solved my problem:

```sh
tree -fi | egrep --null conflicted | xargs -0 rm -f '{}'
```

Let's break that command set down:

1. `tree -fi` is a trick I recently learned from my friend @olleolleolle.  It prints out the local tree of files and the -fi prints out the whole filename (including directories).
2. `egrep --null conflicted` is where the magic starts.  The `--null` flag tell egrep to separate matches with a null character.
3. `xargs -0 rm -f '{}'` this tells xargs that the null character is divider and to remove each filename that comes through the linux pipe.

This is yet another example of why I'm impressed with the commandline.  Simple little tools that can be chained together with symbiotic behavior.
