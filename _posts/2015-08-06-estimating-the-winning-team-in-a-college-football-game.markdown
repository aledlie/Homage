---
layout: post
title: "Guessing the Winning Team in a College Football Game"
modified:
categories: football
excerpt: Using logistic regression to gamble, err, guess the winning team during a game.
tags: []
image:
  feature:"/images/Wisconsin_LSU_Win_Probability.png"
comments: true
date: 2015-08-06T13:51:11-05:00
---

If, during a college football game, you wanted to guess which team was going to win, how would you do it?  There are lots of ways, but one might be to look at historical data for situations similar to the current game situation and figure out how frequently each team was likely to win.  For example, if Texas were playing USC (hypothetically), and were down by 2 touchdowns with about 6 minutes left in the game, you could look at all similar situations and try to guess based on that data how often the team that was leading (USC) would beat the team that was down (Texas).

You'd run into problems, of course, if there weren't _that_ many situations similar to current game situation you are interested in.  If there isn't much data, you can't be very confident in your estimation of the winner.  To help with this data sparsity (and it is definitely problem in a game as rich with possibilities as college football), you could do what I did when I was working on this problem for [Burnt Orange Nation](https://www.burntorangenation.com), which is to employ a regression to a previous data set, effectively extending its reach by smoothly interpolating between otherwise sparse data points.


## Logistic regression

Since the outcome I wanted to estimate was a binary (win or lose), I used a [logistic regression](https://en.wikipedia.org/wiki/Logistic_regression), which attempts to use a set of predictor variables to model the probability of an event occuring or not.  The scenario I was faced with was that we were at a certain point in time in a college football game between team A and team B, and I wanted to know likelihood that team A would win.  To do this, I needed:

   1. A bunch of historical data of lots of in-game situations between lots of teams.
   2. A set a predictor variables that I thought would accurately encode information about how the teams were doing in the game until that point.

The historical data I had gathered by doing a bunch of tedious data scraping that amounts to almost a million college football plays over the last 5-ish seasons.  The second one took some thought, but I settled on the following 4 variables that I thought mattered in determining the likelihood of the team with the ball winning the game:

   1. $$x_1$$: yards from the endzone
   2. $$x_2$$: offensive team's score - defensive team's score
   3. $$x_3$$: ( distance left for a first down ) / ( number of downs remaining )
   4. $$x_4$$: ( offensive team's score - defensive team's score ) / ( time left in the game )

Using these four variables (which we can determine for every play in a game), I denote as $$P$$ the probability of the offense winning given the current game state ( $$x_1, x_2, x_3, x_4$$ ), and calculate it with the form

$$
      \begin{align}
         P(x_1, x_2, x_3, x_4) = \frac{1}{e^{-(\beta_0 + \beta_1x_1 + \beta_2x_2 + \beta_3 x_3 + \beta_4 x_4)}}.
      \end{align}
$$

Using the historical data set I've compiled, I used the python package [Pandas](https://pandas.pydata.org/) to find the set of weights $$\beta_0, \beta_1, \beta_2, \beta_3, \beta_4$$ that best fit the data; these weights are then used to calculate $$P(x_1,x_2,x_3,x_4)$$ for any given game state as described by the four predictive variables_.

Let's examine the meaning of the four predictor variables $$x_1, x_2, x_3, x_4$$.  The first two are relatively straightforward.  The first measures how far the team with the ball has to go to score, and the second measures how the team with the ball is doing (e.g. are they winning or losing, and if so by how much?).  The third is a measure of how many yards per play the offense has to average to get another first down.  This is important because football is a discrete game in a sense, resetting itself every first down.  Finally, the last predictor variable measures the difficulty of overcoming a defecit or sustaining a lead based on the amount of time left in the game.  If there is very little time left, any defecit/lead is amplified by dividing by the time left in the game.   Admittedly, choosing these four involves a lot of guesswork.

## Results

As an exampl, below is the win probability graph of the LSU-Wisconsin game from the 2014 season that [ended with LSU overcoming a 24-7 deficit](https://scores.espn.go.com/ncf/recap?gameId=400548000) in the fouth quarter on their way to an improbable win.  The win probability graph reflects this result, showing Wisconsin's odds of winning plunging from North of 90% to under 10% in about ten minutes of game play.  Over this period of time, Wisconsin surrendered an LSU passing TD, promptly turned the ball over, allowed another long LSU rushing TD, and then once again surrendered the ball on an interception.  What was a 24-13 lead quickly evaporated in a 28-24 loss.

<figure>
<center>
   <a href="/images/Wisconsin_LSU_Win_Probability.png"><img width="80%" src="/images/Wisconsin_LSU_Win_Probability.png"></a>
</center>
   <figcaption> The win probability graph of the tumultuous LSU-Wisconsin game from last season, in which LSU (yellow) stole a victory from Wisconsin (red) late in the game. Each dot represents a play, with an LSU posession in yellow and a Wisconsin posession in red. </figcaption>
</figure>

## Ramblings

Some things to note about this regression model.  First, it's not very sophisticated.  It ignores things like in-game performance of both teams, historical team strengths/weaknesses, and is cobbled together based on my own intuition.  That said, the results are usually intuitive and the win probabilities even decently smooth (which is perhaps not so surprisingly since the predictor variables all are decently smooth in time themselves).  Second, while I don't have the data in front me, I recall it correlating pretty well with Las Vegas-based in-game odds predictions last football season (e.g. [Pivit](https://www.pivit.io/)).  Finally, since this approach is so straightforward, I wonder how well this would work with other binary games (basketball, political elections, etc.).


_For more examples, see some of my Burnt Orange Nation blog posts with more plots like these [here](https://www.burntorangenation.com/2014/9/2/6095989/postgame-statistical-summary-texas-vs-unt?_ga=1.81211159.1400728072.1434051539), [here](https://www.burntorangenation.com/2014/10/14/6973381/postgame-statistical-summary-texas-vs-oklahoma?_ga=1.81211159.1400728072.1434051539), and [here](https://www.burntorangenation.com/2014/9/9/6121005/postgame-statistical-summary-texas-vs-byu)_.
