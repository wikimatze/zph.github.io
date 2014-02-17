---
layout: post
title: "Pathogen.vim without the Submodules: Use Infect"
date: 2014-02-17 14:06
comments: true
categories: 
---

Over the weekend I finally admitted to myself that I hate submodules.

But they're a keystone to one of my primary development tools: Vim.  In order to use Vim, I use the Pathogen.vim plugin by @tpope.  In order to use Pathogen, you normally use submodules in the `.vim/bundle/` folder.

But submodules are the work of the devil.

I tried out the Vundle plugin and was seeing much longer loadtime for vim:

<script src="https://gist.github.com/zph/db5aa2dc128693ba9583.js"></script>

So I asked around on Twitter and [ @jwieringa ](https://twitter.com/jwieringa ) advised me to checkout [ 'infect' ](https://github.com/csexton/infect) by [ @crsexton ](https://twitter.com/crsexton ).

And `infect` is awesome! It works with Pathogen to give it a declarative style for plugins.  An example is:
```
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-sensible
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#incubate()

"=bundle mileszs/ack.vim
"=bundle vim-scripts/AutoTag
"=bundle kien/ctrlp.vim
"=bundle Raimondi/delimitMate
"=bundle sethbc/fuzzyfinder_textmate
"=bundle tpope/gem-ctags
"=bundle gregsexton/gitv
"=bundle sjl/gundo.vim
"=bundle tpope/vim-vinegar
"=bundle jnwhiteh/vim-golang
"=bundle wting/rust.vim

call pathogen#helptags()
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
```

Use it. Love it. Don't look back!

If you want faster downloads with 'infect' try this unofficial fork of the standalone: https://github.com/zph/zph/blob/master/home/bin/infect.  When I have time, I'll work w/ @crsexton to get this added to 'infect'.
