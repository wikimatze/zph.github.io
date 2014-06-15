---
layout: post
title: "Running Command When File Changes"
date: 2014-06-15 03:19
comments: true
categories: 
---

Looking for a way to run a command each time a file(s) changes that can work across multiple platforms?

Previously, I would have used `guard` but I'm trying to break my reliance on Ruby tools.

Enter [entr](https://bitbucket.org/eradman/entr/) a commandline utility written in `C`.  It does the same thing as `Guard` but without the dependency on Ruby and without needing verbose configuration files.

Installing on OSX is simple: `brew install entr` and other platforms look like:

```
./configure
make test
make install
```

Using it is even simpler. I'm using it to rebuild a presentation which means re-running a `make` task each time the source file changes. If the command were being run manually it would be:

`make reveal`

With `entr` installed we can run:

`find dir/ -name *.md | entr make reveal`

Or for convenience we can wrap it in a shell script:

```
#!/usr/bin/env bash

readonly FILENAME=surviving_large_unfamiliar_codebases

(cd ${FILENAME} && \
  echo ${FILENAME}.md | entr make reveal)
```
