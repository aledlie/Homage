---
layout: post
title: "How many routes are there to fly from Austin to Mumbai?"
modified:
categories: misc
excerpt: And why did I pick the one that took me through JFK and CDG?
tags: []
comments: true
image:
  feature:
date: 2015-12-18T03:47:46+05:30
---

<figure>
<center>
   <a href="/images/jfk_security.jpg"><img width="80%" src="/images/jfk_security.jpg"></a>
</center>
   <figcaption> I have measured out my life in security lines. </figcaption>
</figure>

## Never fly through JFK/CDG

This winter break, I flew with my wife and family to India, and made the colossal mistake of splitting up my flights into three segments.  First, from Ausin to New York JFK, JFK to Paris, and finally from Paris to Mumbai.  Each stop inexplicably required that I go through security again (even when our departure gate was in the _same terminal_!), and for this reason JFK and Charles de Gaulle may be the worst airports for international travel I've ever been through.

In general, splitting up the 30 or so hour trip into three segments is a bad idea, but we were left with basically no choice.  Scanning the excellent database of flights/airlines/airports at [Openflights](https://openflights.org/), it turns out there are not so many ways to fly from Austin to Mumbai with only one stop.  In fact, there are just two:


<figure>
<center>
   <a href="/images/austin_to_bombay_two_legs.gif"><img width="80%" src="/images/austin_to_bombay_two_legs.gif"></a>
</center>
   <figcaption> All the ways to get from Austin to Mumbai with only one stop along the way.  Graphic courtesy https://www.gcmap.com/. </figcaption>
</figure>

These two routes are

   1. Austin (AUS) -- Newark (EWR) -- Mumbai (BOM)
   2. Austin (AUS) -- London Heathrow (LHR) -- Mumbai (BOM)

Obviously either of these is better than the route my wife and I took, but knowing this the airlines priced both of these several hundred dollars more expensive than the AUS-JFK-CDG-BOM route we took ($2500 vs. just under $1800 per ticket).  Frankly I was surprised that there were only two options for flying to Mumbai from Austin with a single stop.  Bigger, nearby, cities like Houston (11 ways) or Dallas (8 ways) have many more options, but Austin's surprising lack of direct connection to many of the bigger European/Asian hubs (like Frankfurt, Amsterdam, Munich, Dubai, Tokyo, etc.) means that there aren't many ways to get to India with just a single stop.

## Austin to Mumbai with two stops

If you're willing to stop twice along the way, there are plenty more options that are shown on the map below:

<figure>
<center>
   <a href="/images/austin_to_bombay_three_legs.gif"><img width="80%" src="/images/austin_to_bombay_three_legs.gif"></a>
</center>
   <figcaption> All the ways to get from Austin to Mumbai with two stops along the way.  My favorites are the ones connecting through Cancun.  Graphic courtesy https://www.gcmap.com/. </figcaption>
</figure>

There are some crazy itineraries here.  For example, since you can fly directly from Newark/London to Mumbai, there are flights that take you through various American cities before heading to Newark/London.  Austin-Seattle-Paris-Mumbai is a particularly ludicrous one.  Some of my favorites are the four or five that fly through Cancun on their way to Frankfurt/Paris/London/Munich, or the several that connect through Johannesburg.  I think it's safe to say that of all of the available three-segment routes to get to Mumbai, Austin-JFK-Paris-Mumbai is one of the better ones.

## Inter-city connectivity graph

This led me to wonder how connected the graph of cities around the world linked by flights is.  So, I populated an adjacency matrix, $$G$$, whose entries are defined as




$$
\begin{equation}
G_{ij} = \begin{cases}
             1 & \textrm{ if cities $i$ and $j$ are connected by a direct flight} \\
             0 & \textrm{ otherwise }
          \end{cases}
\end{equation}
$$



The vertices in this graph are cities, and the edges are flights between them.  There are a total of 2,327 airports on this list (there are a few more in the OpenFlights database that are air force bases and so are not connected to anything).  The average city is connected to 14.1 other cities, with the most connected city is Amsterdam with 246 cities one direct flight away.

A natural question to ask is how many cities the average city is 2, 3, or 4-flights connected to.  This is easy to compute using powers of the adjacency matrix.  The degree of a vertex $$v_i$$ in the graph is the row sum of $$\sum_{j} G_{ij}$$, and tells you the number of cities $$v_i$$ is directly connected to.  To get the number of cities $$v_i$$ is connected to with 2 flights, just take the square of the adjacency matrix, and sum up the number of non-zeros in the $$v_i$$ row.  In general, to get the number of cities that are connected by $$k$$ flights to $$v_i$$,

$$
\begin{equation}
\textrm{Number of cities $k$-connected to $v_i$ } = \textrm{ Number of non-zeros in $\{G^k_{ij}\}_{j=1}^{n}$ }
\end{equation}
$$

As you might imagine, the graphs $$G^k$$ get more and more dense as $$k$$ increases, and this is shown in the four pictures below.  Going from left to right, these pictures depiect the sparisty patterns $$G^1,G^2,G^3,G^4$$.

<figure class="quarter">
<center>
   <a href="/images/openflights_adjacency_1.png"><img width="24%" src="/images/openflights_adjacency_1.png"></a>
   <a href="/images/openflights_adjacency_2.png"><img width="24%" src="/images/openflights_adjacency_2.png"></a>
   <a href="/images/openflights_adjacency_3.png"><img width="24%" src="/images/openflights_adjacency_3.png"></a>
   <a href="/images/openflights_adjacency_4.png"><img width="24%" src="/images/openflights_adjacency_4.png"></a>
</center>
   <figcaption> The sparsity patterns of the first four powers of G, the adjacency matrix of world air travel graph.  From left-to-right are the first, second, third, and fourth powers of this matrix, and a non-zero value in the ij entry indicates that airport i and airport j are connected by 1, 2, 3, or 4 flights.  </figcaption>
</figure>

With a direct flight, the average city is only connected to about 14 other cities, or about 0.6% of the world.  From this perspective, this is a pretty disconnected world.  But, if you allow one stop along the way, the average city is connected to 228 other world cities.  Allow two stops, and this number jumps to 1,077.  Three (1,950) and four stops (2,229), and you're just about connected to the entire network of 2,327 cities.

What sort of cities are connected by a minimum of five flights, you might ask?  It's usually obscure places on one continent and obscure places on another.  For example, it takes a minimum of five flights to get from Port Moresby, Papuaa New Guinea to Lakselv, Norway.  These are itineraries you likely cannot even purchase on Expedia or Kayak (I couldn't).  I have yet to get their routing algorithm to return any itinerary that has more than 3 stops.  

In conclusion, it is interesting to me how disconnected, on average, the world still seems to be.  The hub-and-spoke routing model's prevalence means that there are relatively few direct flights between cities, but almost all regional cities are within 2 flights of one another (source -> hub -> destination), almost all domestic cities are within 3 flights of one another (source -> hub -> hub -> destination), and finally almost all international cities are within 4 flights of one another (source -> domestic hub -> international hub -> domestic hub -> destination).  It would be really interesting if OpenFlights had historical routing data to watch the time-evolution of the graph, as its topology undoubtedly changes to react to economic booms/busts, population migration, and growth in developing countries.  In any case, the clear takeaway is that if you're going to fly three segments to Mumbai from Austin, definitely plan to fly through Cancun instead of New York Kennedy.  Lesson learned.



