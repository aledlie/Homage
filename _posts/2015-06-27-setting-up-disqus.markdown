---
layout: post
title: "Setting Up Disqus"
modified:
categories: meta setup
excerpt: Notes on setting up the Disqus commenting system.
tags: [meta setup]
comments: true
image:
  feature:
date: 2015-06-27T14:45:07-05:00
---

I basically followed the very clear instructions set up on [this](http://joshualande.com/jekyll-github-pages-poole/) blog post.
There are instructions there for setting up a GitHub hosting account (which is free, for some reason, if you're using Jekyll), setting up a domain name to point to the GitHub host, setting up Google Analytics, and setting up the Disqus commenting system.

## Disqus

1. Make a [Disqus](www.disqus.com) account.

2. Create a short-name by registering [here](https://disqus.com/admin/create/).

3. Enable Disqus by setting the disqus-shortname variable in the Jekyll config file.

4. Set "comments: true" in the YAML front matter of any post that you want commenting enabled on!
