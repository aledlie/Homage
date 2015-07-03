---
layout: post
title: "Google PageRank, NCAA Football, and Luck"
modified:
categories: football
excerpt: How sensitive is Google's PageRank to luck in ranking CFB teams?
tags: []
comments: true
published: true
image:
  feature:
date: 2015-06-27T03:00:45-05:00
---

## Graph of sports leagues

If you think of sports teams as nodes (vertices) and games between teams as edges between the nodes, professional sports leagues have very different characters as graphs.  Most leagues are divided into divisions, or conferences, and so the graphs tend to have clusters within a division, and fewer edges between divisions.  All the graphs are connected, and some, like the one of the NBA, are even complete.  Usually, the sports leagues are divided into subgraphs that are themselves complete; for example Major League Baseball is divided into the American League and National League.  Within each League, all teams play each other, and teams have a limited set of games against teams in the other league (so-called interleague play).

The graphs of the major American sports leagues are characterized in the table below.  _Nodes_ means teams, _degree_ means games, and _complete sub-graphs_ means the number of divisions/conferences/etc.

| League          | # of Nodes | Degree of each node | # of Complete Sub-Graphs |
| :-------------  |:-----------| :------------------ |:------------------------ |
| NBA             | 30         | 82                  | 2                        |
| MLB             | 32         | 162                 | 2                        |
| NFL             | 32         | 16                  | 6                  |

(_Complete sub-graph_ is a term I'm using sort of heuristically here; every graph has lots of complete subgraphs of small size; I mean complete sub-graph of conference/division size.)

## The graph of college football

The graph of college football is very different from the ones described above.  This is because a college football team will only play about 12 games in a season, and there is something like 130 college football teams.  There is little hope of there being just 1 or 2 of complete graphs.  This is a characteristic in the NFL too, in which teams play only 16 games per season, but unlike college football, there are only 32 NFL teams.  Take a look at the graph of college football from the 2012 season:

<figure>
<center>
   <a href="/images/cfb_network_cluster.png"><img width="60%" src="/images/cfb_network_cluster.png"></a>
</center>
   <figcaption> The network of college football.  Teams are nodes, and edges are games between teams.  The six power conferences are clustered together, and the gray circle of teams in the middle are the non-power conference teams. </figcaption>
</figure>

There are six so-called _power_ conferences which are well-connected within themselves, and are represented by the six clustered groups of teams around the perimeter of the above picture.  Outside of these six conferences, there are the remaining 50% of college football teams that are either independent or in lesser conferences; these teams are represented in gray in the inner circle.  There are few games between power conferences, but lots of games between power and non-power conference teams (these are the edges connecting vertices in the inner circle to one of the outer circle teams).

## Ranking teams with PageRank

Because there no large, complete sub-graphs in the college football network, ranking college football teams is a non-trivial task.  Until recently, there was a selection procedure that used computer models to determine rankings.

Google's PageRank is an algorithm developed by Google co-founder Larry Page for ranking webpages for importance.  In Page's original formulation, the internet was modeled as a directed graph with pages as nodes and edges being links from one page to another.  This graph was represented with an adjacency matrix $$A$$, whose entries $$a_{ij}$$ are givn by


$$ a_{ij} = \textrm{edge weight from node } i \textrm{ to node } j $$

The PageRank algorithm works (roughly) by using power iteration to obtain the dominant eigenvector $$v$$ of $$A$$.  The value of entry $$v_i$$ in the eigenvector represents the PageRank of node $$i$$.  PageRank includes some extra steps to treat edge cases in which the graph is disconnected or there are closed loops, but this is the basic idea.

We can apply PageRank to rank college football teams too.  Again, the teams are the nodes $$v_i$$, the edges are the games between them, and the edge weights are the score differential; the edges point from the winning team to the losing team.  Like anything else reasonably famous, these is a Python package to compute pageranks of directed, weighted graphs called networkx.  I used Python/networkx along with data from the 2014 college football season.

First, let's just see how PageRank does with the 2015 season.  Here is the ranking of the top-10 teams of the 2015 college football season according to PageRank.

| :-------------
| 1. Ohio St.
| 2. Oregon
| 3. Baylor
| 4. Mississippi
| 5. Georgia
| 6. Georgia Tech
| 7. Virginia Tech
| 8. Alabama
| 9. Texas Christian
| 10. Missouri

These are somewhat reasonable results; the national champion and runner-up are correctly ranked at #1 and #2.  The rest of the teams are at least all pretty good.  Florida St. is not ranked in the top ten even though they were ranked as the #3 team before the playoffs, but that was a questionable ranking and Florida St. was beaten soundly in their first playoff game.  All-in-all, this seems to produce reasonable results.


## Adding noise to the network

The question I want to ask is, _How sensitive is PageRank to noise_?  In this context, noise can be interpreted as luck, and can be modeled as adding to the score differential a zero-mean Gaussian random variable with some variance.  In math, this means that I'll modify the non-zero entries of the adjacency matrix $$A$$ and create a new matrix $$\tilde{A}$$ whose entries are defined as

$$ \tilde{a}_{ij} =a_{ij} + N(0,\sigma) $$

where-ever $$A$$ is non-zero.  $$N(0,\sigma)$$ is a zero-mean Gaussian random variable with standard deviation $$\sigma$$.  In my interpretation, $$\sigma$$ represents how much we think luck matters.  Some possible choices of $$\sigma$$ are:

1. $$\sigma = 0$$: this means we think the scores represent perfectly who the better team was and by how much.

2. $$\sigma = 3$$: this means we think that luck matters about a field goal's worth of points.

3. $$\sigma = 6$$: this means we think that luck matters about a touchdown's worth of points.

Naturally many other choices are possible, but I wanted to try these three since they have clear interpretations in the context of college football.

Lastly, and most importantly, I wanted to  make sure I wasn't monkeying around too much with the data by adding noise everywhere in the college football network.  So, I only added the $$N(0,\sigma)$$ noise term to games between bad teams.  Any games that included teams ranked roughly in the top-25 of PageRank scores were not modified at all.  My goal was to see if adding noise to _unimportant_ games (those between bad teams) would affect the rankings of good teams.  Basically what I'm saying is that no one really cares about the outcome of Idaho St. vs. Bowling Green (sorry Vandals and Falcons), and so adding noise to those games should, in principle, not affect the top-10 teams at all.  This turns out to not be true.

Most of the time, as you would expect, when you add noise to teams outside of the top 25, you see no difference in the top-10 rankings; they're the same ones I posted above.  But every once in a while, the top-10 will change, and even less frequenctly, the _number_ _one_ ranked team will change!  In the following table I've summarized the results of simulating 1000 trials of random noise with $$\sigma = 0,3$$ and $$6$$.  I picked out the resulting subset of trials in which Oregon was ranked higher than Ohio St., and have listed the the results for the top-10 teams.

|  $$ \sigma = 0$$ (1000/1000 times)   | $$\sigma = 3$$ (1/1000 times)      | $$\sigma = 6 $$ (12/1000 times)
| :-------------------|:----------------------|:----------------
| 1. Ohio St.         | 1. Oregon             | 1. Oregon
| 2. Oregon           | 2. Ohio St.           | 2. Ohio St.
| 3. Baylor           | 3. Baylor             | 3. Baylor
| 4. Mississippi      | 4. Mississippi        | 4. Georgia
| 5. Georgia          | 5. Georgia            | 5. Mississippi
| 6. Georgia Tech     | 6. Georgia Tech       | 6. Georgia Tech
| 7. Virginia Tech    | 7. Virginia Tech      | 7. Virginia Tech
| 8. Alabama          | 8. Alabama            | 8. Alabama
| 9. Texas Christian  | 9. Texas Christian    | 9. Texas Christian
| 10. Missouri        | 10. Missouri          | 10. Missouri

This is a weird thing that is happening, and sort of shows the limitation of PageRank as it pertains to the college football network.  First, we (as college football fans) care a _lot_ about who is #1 and who is #2.  PageRank doesn't care about this as much; it just wants to make sure that good teams are given good scores.

Second, the college football network has a very peculiar characteristic in that most paths from high-ranked nodes to other high-ranked nodes travel through the set of low-ranked nodes.  This means that information flows from good teams to good teams through bad teams and the unimportant games between them.  When I add noise to those unimportant games, it can alter the way the paths connect good teams to good teams.  This manifests as changing the PageRank of teams whose games I did not touch.

I would be curious to see what would happen if I did a similar PageRank + noise experiment with other sports leagues, especially those, like the NBA, whose graphs are complete.  Would the PageRank then be more resilient to noise?
