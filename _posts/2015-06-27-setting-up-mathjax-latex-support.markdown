---
layout: post
title: "Setting Up MathJax LaTeX Support"
modified:
categories: meta setup
excerpt: How to enable MathJax for typsetting LaTeX.
tags: [meta, setup]
comments: true
image:
  feature:
date: 2015-06-27T17:31:33-05:00
---

This is easy, just add the following snippet into the body of the \_layout/post.html:

{% highlight html %}
<script type="text/javascript"
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
{% endhighlight %}

This will add MathJax support to all posts. To typset LaTeX, just surround any LaTeX syntax with two dollar signs, like this:

{% highlight latex %}
    $$ (u,v) = \int_\Omega u(x) v^*(x) d\Omega $$
{% endhighlight %}

to produce

$$ (u,v) = \int_\Omega u(x) v^*(x) d\Omega $$ 

If you also want MathJax support on website pages, add the same code snippet to \_layout/page.html.
