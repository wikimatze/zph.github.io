---
layout: post
title: "Golang or Go Home: Getting Started with Go"
date: 2014-06-07 22:35
comments: true
categories: 
---

I've recently gotten a little hooked on Golang.  Strangely enough, I think it finally started to click for me as a result of one [Haskeller](https://twitter.com/bitemyapp) and one friend Christopher Stingl.

Christopher was kind enough to link me to this wonderful [introduction to Golang](viget.com/extend/diving-into-go-a-five-week-intro).  And as a result of the Haskell reading that I've done lately, Golang started to make sense.

For a little background, I'm coming from a Ruby development standpoint with no prior formal training in compiled statically typed languages.

## First Impressions

``` go
package sack

import (
  "fmt"
  "github.com/codegangsta/cli"
)

func shellInit(c *cli.Context) {
  sh := `
    sack=$(which sack)

    alias S="${sack} -s"
    alias F="${sack} -e"
    `

  fmt.Println(sh)
}

func shellEval(c *cli.Context) {
  sh := "eval \"$(sack init)\""
  fmt.Println(sh)
}
```

I'll come clean, first impressions weren't good.  I picked up the language a couple months ago and tried to implement a simple line parser.  Didn't go so well because I got caught up on the various statically typed bits of the language.  Essentially, 'what do you mean I have to know what's going into my function and returning from it? I don't even know what types are available'.

But after reading through that 5 Week Intro to Golang and doing some Haskell homework, it clicked.  And I liked it.

So let me back up and explain the static typing for those readers that don't have any background in such languages.  In Go, you define functions (the rough equivalent of a method in ruby) as having specific stypes of inputs and outputs.  So you might define something as follows:

``` go
func Version() string {
  return "0.3.0"
}
```

This function will take 0 arguments and return one argument of type `string`.

Or this function:

``` go
func executeCmd(term string, path string, flags string) []string {

  var lines []string
  _, err := exec.LookPath(agCmd)
  if err == nil {
    lines = agSearch(term, path, flags)
  } else {
    lines = grepSearch(term, path, flags)
  }

  return lines
}
```

Which will take three strings as arguments and return an array of strings.

Initially cumbersome during the learning phase, but incredibly helpful.  I've found myself wishing for a similar safety measure in the language I use for my dayjob, which is Ruby.

And the best part is that the compiler won't build the program unless all your type ducks are in a row!  Which prevents the need to write about 30% of the tests that I see on a daily basis.  In fact, many of the bugs that I've seen in production would be avoided in a strongly typed static language.

## Advantages

- Static typing safety
- Cross compiled binaries
- Super easy deployment (b/c the whole go world is wrapped up into that binary)
- Fast runtimes
- Encourages less usage of mutable variables vs. Ruby (though not as good as pure FP language)

## Outcome

After playing around with that tutorial, I couldn't resist reimplementing a commandline tool in Golang.  It's a tool that started as a shell script, which I reimplemented in Ruby, and now have reimplemented in Golang.  It's called sack and you should use it as the glue that connects your silver-searcher or grep results with your `$EDITOR`.  [Project link](https://github.com/zph/go-sack).

The other outcome was that I worked on a project during our 10% time to build a golang web application that serves up a JSON feed of Whois information.  It was amazing to me that 2 weeks into learning Golang I was able to put up something useful over the course of two days.

I'm looking forward to experimenting more with Golang, possibly by setting up a [Goship](https://github.com/gengo/goship) server at work. It also affirms for me that I'm missing out on some wonderful programming paradigms in the Ruby world.  I expect to see more Functional Programming in my future, whether that's in the form of Erlang/Elixir/Clojure or a more mathematically pure language like Haskell.



