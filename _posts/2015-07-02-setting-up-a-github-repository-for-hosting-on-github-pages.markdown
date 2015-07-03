---
layout: post
title: "Setting Up a Github Repository for Hosting on Github Pages"
modified:
categories: meta
excerpt: How I set up a Github repository for hosting this site on Github Pages.
tags: [meta, setup]
comments: true
image:
  feature:
date: 2015-07-02T20:21:01-05:00
---

Most of this was taken from the helpful guide on Github's [own webpage](https://pages.github.com/).  It is incredibly easy to host
pages on Github so long as you have a basic working knowledge of version control (I had never used Git before, but I know Mercurial
and that was enough).  Here are the steps I took.

### Steps

+ Create a Github account with username _sumedhjoshi_

+ Create a repository called _sumedhjoshi.github.io_

+ On your local machine, clone the git repository you just made:

{% highlight bash %}
$ git clone sumedhjoshi.github.io
{% endhighlight %}

+ Copy the Jekyll directory tree that contains your Jekyll webpage into this folder.

{% highlight bash %}
$ cd sumedhjoshi.github.io
$ cp -R /path/to/jekyll/folder .
{% endhighlight %}

+ Add all the Jekyll files to your repository, and commit and push the changes.

{% highlight bash %}
$ git add --all
$ git commit
$ git push
{% endhighlight %}

+ Navigate to _sumedhjoshi.github.io_, Github Pages will automatically generate your webpage and serve it.

+ All future updates can be made locally and pushed with git to _sumedhjoshi.github.io_ and they will take effect immediately!


