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

Edit: The change is already present in the master copy of `aws-s3` [here](https://github.com/marcel/aws-s3/blob/c4a99b34618ecc2990305fb52c685a9b0b7b8389/lib/aws/s3/authentication.rb#L71)
