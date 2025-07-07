---
layout: post
title: "How I Set Up This Site"
modified:
categories: programming meta notes
excerpt: Notes for myself on how I installed/configured the things I needed to build this page.
tags: []
image:
  feature:
date: 2015-06-27T01:47:07-05:00
---

0. Upgraded Ruby to version 2.1.1 to be compatible with clang.

1. Downloaded and installed Jekyll from https://jekyllrb.com/.

2. Downloaded and installed the [Minimial Mistakes](https://github.com/mmistakes/minimal-mistakes/blob/master/theme-setup/index.md) theme.

3. Modified the images in the /images folder to be smaller in height to save vertical real estate (first installed imagemagick):

        $ mogrify -crop 100%x40%+0+0 sample-image-?.jpg

3. Installed the octopress gem:

        $ gem install octopress

4. Made this post with octopress:

        $ octopress new post "How I Set Up This Site"
