# Comet

GET your latest github commit. Check out [comet.rshah.org/2016rshah](http://comet.rshah.org/2016rshah) to see my latest commit message, and [comet.rshah.org/json/2016rshah](http://comet.rshah.org/json/2016rshah) for the json of my latest commit. 

# How to use

There are two main endpoints:

`/:username` - returns your latest commit message (with no meta information) as plain text

`/json/:username` - returns your latest commit with all relevant information as JSON. 

Let's say you store the response of `/json/:username` into a variable `x`. You will probably be interested in `x.commit.message` (for the commit message), `x.commit.committer.date` (for the date the commit was made), and `x.html_url` (for a link to the commit on github). 

[This](https://github.com/2016rshah/comet/blob/master/index.html) is a very simple example that will generate [this page](http://rshah.org/comet).

You can also get your minimally styled page @ `[http://rshah.org/comet/index.html#<YOUR_USERNAME_HERE>](http://rshah.org/comet/index.html#2016rshah)`

#Colophon
 - [This blog post](http://www.jarredtrost.com/2015/05/30/getting-started-with-elixir-plug-routes/) which helped with JSON encoding/decoding in the server
 - [This blog post](http://blog.simonstrom.xyz/elixir-a-simple-server-with-plug/) for an intro into using the Plug Router
 - [This buildpack](https://github.com/HashNuke/heroku-buildpack-elixir-test) for making deploying an elixir app to heroku painless even though it wasn't a Phoenix app
 - [This blog post](http://vertstudios.com/blog/github-api-latest-commit-details-php/) which vastly simplified the method I used to search for the commit by revealing the sort by parameter for github repos
 
