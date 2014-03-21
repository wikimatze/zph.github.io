---
layout: post
title: "Weather Github Downtime by Pushing to All the Places"
date: 2014-03-21 09:37
comments: true
categories:
---

### Want to not care whether Github's up or down at the moment?
###
### Have faulty servers of your own? Or tend to anger people with bot armies?
###
### Want to push to two Git Repos via a single command?
###
### Want to do it easily via a simple .git edit?

My use case is pushing code that resides on Github as well as on Bitbucket.  I want it available in both remote locations in case one is unavailable.

Here's how you do it:

Add the two remotes as normal

`git remote add origin GIT_LINK_TO_REPO`

`git remote add bitbucket GIT_LINK_TO_REPO`

In local repo, edit .git/config.
Find the entry for origin and bitbucket

```
[remote "origin"]
url = git@github.com:zph/zph.git
fetch = +refs/heads/*:refs/remotes/origin/*
```

```
[remote "bitbucket"]
url = ssh://git@bitbucket.org/zph/zph.git
fetch = +refs/heads/*:refs/remotes/bitbucket/*
```

Add a new entry using that information and urls:

```
[remote "all"]
url = git@github.com:zph/zph.git
url = ssh://git@bitbucket.org/zph/zph.git
```

Now when pushing code:
    `git push all`

Credit for this solution:
http://stackoverflow.com/questions/849308/pull-push-from-multiple-remote-locations?lq=1
