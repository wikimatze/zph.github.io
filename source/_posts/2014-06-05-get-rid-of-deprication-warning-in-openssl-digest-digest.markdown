---
layout: post
title: "Get rid of deprication warning in OpenSSL::Digest::Digest"
date: 2014-06-05 11:30
comments: true
categories: 
---

AWS-S3 complaining at you in Ruby 2.1.1?

Looks like they're getting rid of `OpenSSL::Digest::Digest` and that behavior should be in `OpenSSL::Digest` instead.

Nix it here: `aws-s3-0.6.3/lib/aws/s3/authentication.rb:71`.

If I have a chance I'll submit a PR on that (or maybe it's fixed in a newer version).
