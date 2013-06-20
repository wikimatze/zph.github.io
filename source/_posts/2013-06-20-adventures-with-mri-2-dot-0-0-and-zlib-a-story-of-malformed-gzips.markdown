---
layout: post
title: "Adventures with MRI 2.0.0 and Zlib: A Story of Malformed Gzips"
date: 2013-06-20 00:42
comments: true
categories: 
---
It started off as a casual inquiry on Twitter:

<blockquote class="twitter-tweet"><p><a href="https://twitter.com/geopet">@geopet</a> Sounds strange that 193 would work for external API and not 2.0.. can you share what you’re working on? Or TDD test via webmock?</p>&mdash; Zander (@_ZPH) <a href="https://twitter.com/_ZPH/statuses/345536278604963841">June 14, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

And led to my friend @geopet posting the Minimum Viable Demo as a Gist:

<blockquote class="twitter-tweet"><p><a href="https://twitter.com/Strabd">@Strabd</a> <a href="https://twitter.com/_ZPH">@_ZPH</a> But here’s the gist with the code and the results: <a href="https://t.co/ajiAh8lQTN">https://t.co/ajiAh8lQTN</a></p>&mdash; Geoff Petrie (@geopet) <a href="https://twitter.com/geopet/statuses/345567430841597952">June 14, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## And it was interesting
What we found out was that the Ruby open-uri library would make calls to an external API (Wunderground) and throw a Zlib::DataError when run in MRI Ruby 2.0.0.  The strange thing was that MRI 1.9.3 works perfectly fine.  Same exact story when the GET Request comes from Net/HTTP instead of open-uri.  But it succeeds on 2.0.0 when using the RestClient Gem, as documented by @injekt.

## The Gloves Come Off
We dove into the source of the error and determined that it was thrown from `net/http/response.rb:357`.  In order to better understand the error, I sequentially placed `binding.pry` statements to determine where the error percolated to the surface.  It was the call to `@inflate.finish` which was where the Zlib::DataError surfaced.

I left the code at this point and posted my initial findings back to Geoff and left the project alone.

## Today
Then I saw this message and it was time for more digging :).

<blockquote class="twitter-tweet"><p>Big thanks to <a href="https://twitter.com/_ZPH">@_ZPH</a> &amp; <a href="https://twitter.com/lee_jarvis">@lee_jarvis</a> for helping out with my 1.9.3/2.0 question. The discussion has led to more questions, but it’s a start!</p>&mdash; Geoff Petrie (@geopet) <a href="https://twitter.com/geopet/statuses/347460923130269696">June 19, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I started by forking his Gist and pulling it down to my local computer. My first phase of troubleshooting was to try alternate tools, in order to see how they dump the HTTP response.  Good ol' `curl` came to the rescue and provided me with the results that I placed in [curl_response.txt](https://github.com/zph/mri_2_0_0_zlib_troubleshooting/blob/master/curl_response.txt) and [curl_raw.txt](https://github.com/zph/mri_2_0_0_zlib_troubleshooting/blob/master/curl_raw.txt).  Notice the rather interesting artifact around line 12 on the RAW version that isn't present in the alternate curl response.

## Pulling in Net/HTTP
It felt like progress and I wanted a better way to tweak the net/http library.  I prepended the local directory to Ruby's LOAD_PATH and copies the net folder out from MRI's lib directory.  Having the `Dir.pwd` prepended to the path enabled me to make very convenient testing tweaks to the Ruby Standard Library without needing to alter my standard RVM install :).

## Tapping the Sockets
With net/http libs loaded from the local file, I was off to the races. I tapped into the internal workings by using the 'sack' utility [sack](https://github.com/zph/sack) for jumping directly into and editing `ack` results.  With the addition of a strategically placed `binding.pry`, I was able to tap into the live socket info via a `socket.read_all` and write that out as a binary dump to `socket_content.bin`.

## Reducing it to Elements
The last step in my troubleshooting was to create `zlib_targeted.rb` for isolating the zlib load issues from net/http.  Since the underlying issue appears to be a malformed gzip returned from Wunderground's API, I created zlib_targeted.rb to remove net/http from the equation.  Check out the demo content of the file below:

<script src="https://gist.github.com/a7bfc0acbc0876363ede.js"></script>

## Conclusion
Now we have a very narrowly tailored set of examples that dig into the exact errors, thanks to @geopet, myself, and @injekt.

For more info, see the comments in this Gist repo from @geopet:
[Initial Gist]( https://gist.github.com/geopet/5782836 )

Or my repo that includes the files described in this post:
[Full repo]( https://github.com/zph/mri_2_0_0_zlib_troubleshooting )

I'm happy with how the toubleshooting has progressed and would like to see this issue resolved, whether it is a malformed response from Wunderground, intolerant behavior from MRI 2.0.0, or anything else.
