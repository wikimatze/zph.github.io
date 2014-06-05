---
layout: post
title: "No db:migrate? No problem"
date: 2014-06-05 11:17
comments: true
categories: 
---

Missing your `db:migrate` tasks in Rails?

Might have been disabled during initial app work.  Check `config/application.rb` and see if `require "active_record/railtie"` is commented out.

Version: Rails 4.x.
