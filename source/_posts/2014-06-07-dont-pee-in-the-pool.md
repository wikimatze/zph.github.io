---
layout: post
title: "Don't Pee in the Pool: Swimming With the Big Kids"
date: 2014-06-07 06:39
comments: true
categories: 
---

As developers, we're familiar with the basic software tools that grease the wheels of the programming world.  Version control systems, deployment tools, notification hooks, CI servers: they all make our jobs easier.

But how can we work better as an organization when our startup exceeds 2, 4, 8, 16, 32, 64, 128 engineers?

There are three essential tools/patterns that need to be implemented for a development team to be successful.

1. Project Management Software
2. Git workflows and commit message standards
3. Cultivate your Developers' creativity


## Project Management Software

If you're like me, you hate long running email threads that attempt to pin down the acceptance criteria and context of projects or stories.

Pull the email escape hatch and move into the 21st century!

A good start is having a unified interface for tasks, ie a Project Tracker.  This gives the technical and non-technical folks a single point of interface for all the knowledge of "what's happening" and "what timelines are we operating under?".  It's incredibly important that the software is convenient to use & updated in realtime.  

Though I don't get any referral bonuses, my favorite thus far is Pivotal Tracker and if you're an Emacs user check out [Pivotal-Tracker-mode](https://github.com/jxa/pivotal-tracker) or my [fork](https://github.com/zph/pivotal-tracker) of that project. I prefer using the Emacs interface rather than their web interface when working in a large organization because it's faster.

So now you have a single channel of communication and record keeping system for projects, YAY!  Rambling email threads will (mostly) fade into your company's past!


## Git workflows and commit message standards

Next, come up with a style guide for Git commits and version control practices.  Maybe you use 'git-flow'.  Maybe you come up with your own variant of an established workflow.  But discuss it among the engaged members on the team.

I strongly recommend running all code changes through other members on the team. A spare pair of eyes is invaluable as is the unique context/domain knowledge that a team-member brings to the table.  If you're using a web based interface for Git such as Github, consider using "Pull Requests".  They've become a standard practice in the Github using community.  If you have a team using an alternate git-based solution, consider submitting all code as patches through the Dev Leads.  Doing so will catch some issues before they make it into production.

As for git commit messages, educate your developers on why they're important.

Take the following commits:

```
Fixed thing that was wrong
```

or 

```
[ZPH/KM][#3489634] BUG/Updated Jquery selector for dashboard login box

Dashboard login box functionality was broken (SHA a98adf91) due to a change in `dashboard.slim`.

Changed selector to $('.login_box') to match slim file.
```

Can you imagine which is easier to reference 6 months in the future?  Say, when you're investigating why the dashboard login is broken? Or maybe you're a Dev lead looking for the commits related to a specific project story.  If you're on a team where stories are completed in pairs, it's a good idea to include the initials of both parties who worked on the commits.  Then it's simple to answer the question of: "Didn't Zander and Kerri do something with our dashboard last week?".

If you have developers writing descriptive commits, finding answers to questions is as easy as `git log -S dashboard` for a list of each commit involving the word dashboard.

## Care and Feeding of Developers 

Last and certainly not least is related to the care and feeding of software developers.  We might not all be beautiful and unique snowflakes (we in the Ruby community do largely use Apple computers after all) but we require regular care to stay sharp and engaged.

### 10% Time

Set aside dedicated time to have developers work on more creative projects.  Why bother?

- Developers are valuable and losing them is expensive.
- Happy programmers are productive programmers.
- Who else could be better situated to see inherent flaws in existing software/tools/workflows in the organization? Let them scratch their own itch.
- Doing the same tasks day in and day out is a sure-fire recipe for dulling even the brightest minds.  So knock it off!  

Build in time each two weeks that's dedicated to creative projects envisioned by the coders.

Where I'm currently working, we do this every 10th business day and it's called our 10% time.  On those days, we come up with interesting projects that advance the company's interests without the same pressure of failure.  These are great times to implement something in a new technology or setup those Git hook integrations with Pivotal Tracker. Fix things that are slowing you down or bothering you on a regular basis.  What else could you work on?

- An idempotent way to setup new developer workstations (script based please).
- A unified script for firing up the application stack on a local machine (or stopping, reloading, updating, etc).
- Team chat integrations like Campfire + Hubot, HipChat + Github Merge notification.
- Dashboard for your income generating parts of software. Track those leads in realtime!
- Build tools to simplify your Quality Assurance teams' lives. Or build tools so Product can be more efficient.

10% is the perfect time for fixing these nagging issues. The only requirement is that the developers generate most of the 10% ideas and get to vote with their feet (or digital feet) in choosing what tasks to work on.  They'll self organize into teams where they can be most efficient. Cultivate your developers and they'll flourish!  Also, you won't have to engage recruiters because your retention will go through the roof. It's a win-win situation.

Thoughts, comments or jeers are all encouraged! Come have chat w/ me on Twitter [@_ZPH](https://twitter.com/_zph).
