---
layout: post
title: "How Many of Me Would It Take to Shoot Par in a Scramble?"
modified:
categories: golf
excerpt: Simulating a golf scramble.
tags: []
comments: true
image:
  feature:
date: 2015-10-09T11:24:52-05:00
---

I played in a golf scramble with three friends of mine recently, and together we shot about a 65.  A scramble is a format in which a team of players, usually either 2 or 4, play their collective best shot.  So for example in a 4-person scramble, all four players would hit a tee shot.  The team would agree upon the best of the four tee shots, the four players would advance to that position and each play their second shot from where the best tee shot landed.  They would proceed until the hole was complete.

So a question I had was, "how many of me would it take to shoot par in a scramble?".

## Model

To model a round of golf, I need a model for an average golf shot.  This is totally an incorrect assumption, but I assumed that the distance a golfer could hit a golf shot was a normal distribution with some mean $$\mu$$ and a standard deviation $$\alpha \mu$$.  I also assumed that there was a maxiumum mean shot distance that a golfer could aim for which I called $$\mu_d$$. So, a golfer's skill is parameterized by two numbers:

$$
\begin{align}
   \mu_d &:= \textrm{Average driver distance} \\
   \alpha &:= \textrm{Skill, or uncertainty in a shot distance}.
\end{align}
$$

So, if a golfer was attempting a shot of some distance $$d < \mu_d$$, the probability distribution of thier shot would be

$$
\begin{align}
   \textrm{distance} \sim N( d, \alpha d )
\end{align}
$$

where $$N(\mu,\sigma)$$ is a normal distribution vith mean $$\mu$$ and standard deviation $$\sigma$$.  On the other hand, if that same golfer were attempting a shot at a hole that was a distance $$d > \mu_d$$ away, then the distribution of that shot would be

$$
\begin{align}
   \textrm{distance} \sim N( \mu_d, \alpha \mu_d).
\end{align}
$$

The point is that the variability in a golf shot scales linearly with the shot distance $$\mu$$ and with slope $$\alpha$$.  Using this model I can simulate a hole, a round, a bunch of rounds, and eventually the average number of strokes a golfer takes to finish a round.

This is a bad model for a lot of reasons:

   1. **It is one-dimensional**: I assume that the only factor in play is distance to the hole; my model keeps taking strokes until this distance is reduced to the diameter of the cup.

   2. **It disregards penalty strokes**: In golf, if you hit a ball out of bounds not only do you replay the stroke, you also incur a penalty (this is because golf is an evil game and hates you).  Since I don't have any out-of-bounds in my model, I also don't have any penalties.

   3. **It assumes a symmetric PDF**: The probability distribution I assume is Gaussian.  This means that you have just as much a chance to overshoot your desired distance as undershoot it (in this model).  Clearly this is not physical; a golfer has a much better chance of undershooting a long shot simply because it is harder to hit the ball farther.

   4. **It assumes the distribution is the same for all mean values**: There is no reason to assume that the PDF of a golf shot is the same distribution for a short vs. a long shot vs. a putt.  They're just very different situations that probably don't behave the same probabilistically.


## Single golfer results

Despite all these shortcomings, I still wanted to see if this model produced at all reasonable results.  I wrote a short MATLAB script to simulate a bunch of rounds for a bunch of different values of the mean drive distance and skill (again by skill I mean $$\alpha$$).  The golf course I simulated had four par-3's, 4 par 5's, and the rest were par-4's.  All par-3's were 150 yards, par-4's were 350 yards, and par-5's were 500 yards.  The average scores (the color) over a bunch of different drive distances ($$[100,350]$$ yards) and skill ratings ($$[0.0, 0.5]$$) are shown in the figure below.

<figure>
<center>
   <a href="/images/golf_surface.png"><img width="80%" src="/images/golf_surface.png"></a>
</center>
    <figcaption> The average score as a function of driver distance (in yards) vs. skill (alpha). </figcaption>
</figure>

Remember that a golfer with a skill rating of $$\alpha = 0$$ hits a golf shot exactly the distance she wants it to go every single time.  She is obnoxiously good and likely resents playing with me.  Because of her skill rating of 0, even if she drove the ball only 100 yards, she should still shoot just about par (e.g. the bottom left corner of the above image).  A golfer that could drive the ball 250 yards with a skill rating of 0 would shoot about 50, because he would eagle all par 4's, ace all par 3's, and double-eagle about half of the par 5's.  Screw that guy.

Based on my average round score of about 115, and my average longest drive distance of about 250 yards (this is _not_ the same as my average drive), my skill rating is about $$\alpha = 0.42$$.  This means, roughly, that I'm liable to hit a golf shot anywhere +/-40% of my intended distance.  If you've played golf with me, you'll know this is about correct.

Finally notice that distance matters a lot less than $$\alpha$$; if you want to move down the surface above (and you do), the best way to do it is to reduce $$\alpha$$.  To put it another way, the gradient of score is far steeper in the $$\alpha$$ direction everywhere except at very, very small drive distances (bottom left).

## Scramble

The point of this was to see how much better I would get playing a scramble.  This is effectively like taking the same model above but for every stroke taking multiple realizations of the random variable that represents the stroke and taking the minimum resulting distance from the pin.  Pretty straightforward to program.  I wanted to consider 1, 2, 3, and 4 person scrambles over all the different values of drive distance and $$\alpha$$.  Like the simulation above, I ran many simulations to obtain an average score, and I used the same golf course as before.  All the caveats in the model continue to apply here, of course.

The results are shown in the four figures below, one each for each of the 4 types of scrambles.  In my fictitious scramble, it is one, two, three, or four of the same golfer playing together; identically you can think of yourself playing golf but playing multiple shots each time and taking the best one.

<figure>
<center>
   <a href="/images/golf_scramble_surface.png"><img width="80%" src="/images/golf_scramble_surface.png"></a>
</center>
    <figcaption> The average score as a function of driver distance (in yards) vs. skill (alpha) for 1, 2, 3, and 4 person scrambles. </figcaption>
</figure>

The top left plot is a single golfer, and so is identical to the first picture.  The top right is a two-person scramble, bottom-left a three-person scramble, and bottom-right a four-person scramble.  In all of the plots the magenta line is par (72 strokes).  Anything above the magenta line is below par ($$< 72$$ strokes), and anything below it is above par ($$ >72$$ strokes).  As more and more golfers are added to the scramble, the magenta line moves downward (shorter drive distance required) and to the right (less skill required) -- this makes sense, as you get more oppurtunities to hit the ball, the less long and less accurate you have to be.  The drop is most dramatic from 3 to 4 players.  I'd have to dig into the data to be certain, but I'm pretty sure this is due to the inaccuracies in my model (summarized above), but it may also be real... I'm not sure.

What does the above chart say about me, a $$(250.0, 0.42)$$ golfer?  Well I would certainly not shoot par as a two-person scramble, and only just graze par as a three-person scramble.   But, as a four-person scramble, I would be shooting in the high-60's!  That's great, right? Well.. not quite, since I have a data point that says that me playing with three other, better, golfers, could only muster a 65, I doubt that four of me playing together would shoot just a few strokes over that.  Something's wrong.  In this case, I'm going to say that my model is incorrect, and likely because it has me occasionally driving the ball 350.0 yards (which it does, I checked).  I can say with great certainty that this has never happened before.

## Conclusion

I think the thing to fix here is that my probability distribution of a golf shot is incorrect; I should model it as a non-symmetric distribution skewed towards short vs. long.  Secondly, while I don't know of a good way to do this, I should incorporate penalty strokes into my model; these would disproportionally hurt bad golfers like me and correctly inflate my score.  Finally, I should probably have different distributions for putts, iron shots, and driver/woods, as most people (especially bad golfers) play these differently.

