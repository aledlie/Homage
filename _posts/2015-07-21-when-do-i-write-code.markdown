---
layout: post
title: "When Do I Write Code?"
modified:
categories: programming
excerpt: The poor work habits of a graduate student.
tags: []
image:
  feature:
  thumbnail: default-thumb.png
comments: true
date: 2015-07-21T12:12:22-05:00
---

I use [Mercurial](https://mercurial.selenic.com/) as a version control system for part of my dissertation work, the development of a finite element code.  Besides being easy to use, [hosted online](https://www.bitbucket.org), and useful, it also lets me evaluate how/when I make changes to my code.  By looking at the number of changes I make per day/month/whatever, I can get a rough estimate of when I'm working, when I'm not, and what my work habits are in general.  In Mercurial, this is really easy to do since all change logs can be accessed via command line with 

{% highlight bash %}
$ hg log -v > logs.txt
{% endhighlight %}

Then just use your favorite text parser to sort the straightforward logs.txt file which contains records of each change in a standardized format, e.g.

      changeset:   59:783a1a00679c0i
      user:        Sumedh Joshi <smj96@cornell.edu>
      date:        Tue Jan 07 08:35:49 2014 -0500
      files:       apply_laplacian.f90
      description:
      Topic: Fixed minor error in Laplacian.
      Description:
      * Factor of two error incorrect in the Laplacian.

I've made about 600 changes to my repository over the last 1.5 years, and they tell me something about how I work.

## Changes by day and month.

First, I just sorted all of my changes by month and day (shown in the two pie charts below).  I work, predictably, little on the weekends, and least of all on Saturdays, which are reserved for college football.  Tuesday is my most productive day, slightly edging out Mondays.  Wednesdays are my least productive weekday.


<figure class="half">
<center>
   <a href="/images/sumedh_commits_by_day.png"><img width="50%" src="/images/sumedh_commits_by_day.png"></a>
   <a href="/images/sumedh_commits_by_month.png"><img width="50%" src="/images/sumedh_commits_by_month.png"></a>
</center>
   <figcaption> Left: The number of changes per day over the last year.  Right: The number of changes per month over the last year. </figcaption>
</figure>

Month-wise, I am at my most productive in the winter months: January, December, and February in that order.  Probably this is just because over the last 1.5 years these months have occured twice, but so have several other months which are not as productive.  My best explanation is that these months have bad weather so I probably spend more time inside, and also there isn't any major team I am a fan of that is in season.

By far my least productive months are August (football), September (football), and May (NBA playoffs).


## Changes by hour of day.

One of the perks of being a graduate student is that you don't have to work in the middle of the day.  These are great times to run errands, work out at an empty gym, go play golf, whatever.  Looking at my changes logs over a 24-hour day (below bar graph) it's clear that 1. I am not a morning person and 2. I take full advantage of my schedule's flexibility by working evenings.


<figure>
<center>
   <a href="/images/sumedh_commits_by_hour.png"><img width="80%" src="/images/sumedh_commits_by_hour.png"></a>
</center>
   <figcaption> The number of changes per hour of the day. </figcaption>
</figure>

Most of my changes (like, the vast majority of them), occur between noon and midnight, with a slight peak at 7pm.  I've only had a handful of changes between 7-9am, and if I was working before then, it's probably just because I was up from the night before.  My schedule has gotten more regular since my fiancee started working so I expect this to change over the next year.  It'll be fun to look back on this.

## How many changes on an average day of work?

Over the 450 or so days I've had this repository I've made 600 or so changes, which averages to a little over 1 per day.  But, if I had to guess, the vast majority of days I make no changes at all, and on days that I _do_ make changes I make way more than 1.  To see if my guess was correct, I made a histogram of number of changes I make on days that I actually worked (shown below).

<figure>
<center>
   <a href="/images/sumedh_commits_per_day_of_work.png"><img width="80%" src="/images/sumedh_commits_per_day_of_work.png"></a>
</center>
   <figcaption> The number of changes I make on a day in which I actually work.  April 2nd, 2014: 28 changes.  Never forget.</figcaption>
</figure>


So, I'm only sort of right.  On the average day I worked, I made about 5 code changes.  The distribution is very non-symmetric (naturally since you can't have _negative_ changes) and looks basically like a [Rayleigh distribution](https://en.wikipedia.org/wiki/Rayleigh_distribution).  There is still a large chunk of days in which I made just 1 or 2 changes which is surprising since I don't remember those days, but perhaps also unsurprising since... why would I?

Lastly, I don't know what got into me on April 2nd of last year, but I checked in 28 changes in a single 24-hour period.  This is over 30 times my daily average over the last year.  Probably some combination of my impending dissertation proposal and the lack of any sort of football motivated me to work.

To conclude: today is Tuesday, it is July, and it is about 2:30pm.  By historical measures, I should be working diligently instead of writing this post, which is the only commit I'm making to any repository today.


