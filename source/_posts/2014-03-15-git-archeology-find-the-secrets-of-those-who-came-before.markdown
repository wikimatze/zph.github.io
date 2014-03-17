---
layout: post
title: "Git Archaeology - Find the Secrets of those Who Came Before"
date: 2014-03-15 11:21
comments: true
categories: 
---

### "Those who don't know their Git history are doomed to repeat its mistakes" - Yammy the Programming Kitten

## Setup

You're working for Cato Consulting.

And, you've been lent out to a new client on an unfamiliar project. It's a codebase that you haven't touched before.  In the sense that you've never worked on it, you could kind of call it "Greenfield"... but from where you sit, the project looks like "Brownfield with withered vestiges of healthy code."  This isn't going to be an easy upcoming two weeks.

So it's a new day and you have a new story from the client about a text input box that's no longer working.  It should behave as a search field, but instead it does nothing.  You realize you also do nothing useful before coffee while sitting there, pondering the solution and decide to increase your caffeine level. 

Much better, there can be coding once the caffeine hits.

## How Do You Approach the Problem

First, you need the text field. Perhaps it will have a unique id or class.

Bingo, you learn that the field has an id of "#super_search_box".

Your other big clue in the story is that this feature was working well up until a few weeks ago.  The client doesn't have a schedule of exactly when it went bad, but that gives you a starting point.  You can reasonably estimate that the code from 4 weeks ago was working.

Let's dig into this Git Archaeology!  We'll dirty our hands but our spirits will be clean and we'll sleep well at night knowing that our problem domains were well understood when implementing a fix.

## Git Bisect

Our first useful incantation is `git bisect`.  Git bisect helps in a situation where something stops working.

The basic workflow looks like this:

(Starting on git branch = master at newest commit, which happens to be broken)
`git bisect start`
(Then identify a good and a bad commit.)
`git checkout SHA_from_4_weeks_ago`
(manually check that search box worked, or run associated automatic tests)
If it's good, mark it via `git bisect good`, otherwise `git bisect bad`
Then find an opposite example (ie if you found a bad one, find a good working commit).
Tag that one via a `git commit [good || bad]`
Then git bisect's magical excavation will begin.

Git will do a binary search, and each step of the way, you will enter `git bisect [bad || good]` until `git bisect` identifies the earliest commit that broke that feature.

After that process is over, you'll have the `bad` commit where a breaking change was introduced to that feature.

Next, it's time to understand why the code author would do such a dastardly thing!

Run a `git show bisect~bad` to see the full content of that commit, both the message and the code differences.

## Project Tracker

If there are more than 2 people on the project, hopefully there's a central project management tool like Pivotal Tracker or Jira.  Ever hopeful, you expect to see a story number or issue number listed in the git commit.  Let's see what it looks like:

```
[CTL] [#3443450] Switched JQuery selector for search box

Changes selector from '#super_search_box' to '.snazzy_search'.

diff monolithic_everything.coffee
- '#super_search_box'
+ '.snazzy_search'

```

Not a very helpful message but at least it contains a story id.  Looking that up in the Project Tracker show that this was a chore to refactor some code & apparently it wasn't done with sufficient care or any automated behavioral tests.  Bummer :(.

## Advanced Git Searching

Since we're left underwhelmed but the currently available info, it would be nice to know when the markdown was modified that relates to '.snazzy_search'

`git log -S 'snazzy_search'`

This will search each git log entry for any mentions of `snazzy_search`.

With knowing when the markdown was changed, along with knowing the exact commit that introduced the regression, you're set to implement a fix.  By doing a bit of digging, the underlying domain becomes clear & the possibility of introducing your own regression will decrease.

## Go Forth And Dig

Check out my `.gitconfig` and my `.zsh.d/git.zsh` files [here](http://github.com/zph/zph) for some helpful shortcuts for everyday git behaviors.

Also, look into `git blame` via Fugitive.vim or Magit (on Emacs).  Git blame's a great way to find out if the developer who introduced the changes is still around and can give you a bit of context on the changes.

If you're just getting started as a Git Archeologist and want some help with getting started, or if you're an experienced Git Excavator and want to bounce ideas off me, ping me on Twitter at [@_ZPH](https://twitter.com/_ZPH).
