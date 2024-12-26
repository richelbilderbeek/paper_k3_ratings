# Does perceived song quality depend on band members for same composers?

# Abstract

Some bands have had multiple formations,
while using the same composers.
What is the effect of the singers
on the perceived song quality?
This paper answers this question
for the famous Flemish music group
called K3, using song ratings as given by fans.
It was found that band members do/don't
influence the perceived quality of the song.




## Introduction

K3 is a famous Flemish music group.
Recently they have changed their formation.
Rumors claim that the new formation is worse
than the old one.
Here, we investigate if that claim is true,
based on reviews of their music before
and after the new formation.
We find that the new formation is 
[worse/equal/better].

K3 is a famous Flemish music group
starting in around ?1990.
The band consists out of three girls
and has had four formations, where some
members are part of multiple formations.
See Table 1 for the K3 formations.

Formation||Members
---------|-----------------------
1        |Karen, Kristel,Kathleen
2        |Josje, Karen, Kathleen
3        |Hanne, Klaasje, Marthe
4        |Hanne, Julia, Marthe

> Table 1: K3 formations

Rumors on internet fora claim that the new
formation is worse. Their music would be
worse. It is unknown if these rumor are true.

In this research, we will test if the new
formation produces music that is as enjoyable
as the old formation.

## Hypothesis

- H0: the songs unique to each K3 formation
  have the same distribution in their ratings

## Methods


### Data set

We obtain ratings (which are values from
1 to 10, where 1 is worst and 10 is best) 
from two websites in which fans
have rated K3 songs,
which are [https://github.com/richelbilderbeek/k3reviews](https://github.com/richelbilderbeek/k3reviews)
and [forum.popjustice.com](https://forum.popjustice.com/threads/its-the-k3-singles-rate.62219/).

Rating|Name|Song
------|----|----
.     |.   |.
.     |.   |.

> Table 2: Table of ratings

Formation|Song
---------|---------------------
3        |10000 Luchtballonnen

> Table 3: Table of songs that are unique for a formation

The collected datasets can be downloaded from
[https://github.com/richelbilderbeek/paper_k3_ratings](https://github.com/richelbilderbeek/paper_k3_ratings).

### Statistical test

We do not assume that the 
ratings follows a normal distribution,
as we think it is likelier that fans
rate a song with the more extreme ratings.
Due to this,
we use a Kolmorov-Smirnoff test to test if
the distributions are the same.
As the Kolmorov-Smirnoff test makes no assumptions on the underlying
distributions, it will be rather conservative in determining if
two distributions are different.
This, on the other hand, does mean that if a difference is found,
it is undeniable that different formations have an effect on perceived
song quality.

We compare the distributions between all combinations of ratings,
as shown in table 4.

Formation 1|Formation 2|Average rating 1|Average rating 2|p value|Different ratings?
-----------|-----------|----------------|----------------|-------|------------------
1          |2          |.               |.               |.      |.
1          |3          |.               |.               |.      |.
1          |4          |.               |.               |.      |.
2          |3          |.               |.               |.      |.
2          |4          |.               |.               |.      |.
3          |4          |.               |.               |.      |.

> Table 4: overview of statistical tests

A base value of alpha of 0.05 is used,
as there has not been done any previous research on this.
A Bonferroni correction is used to take multiple tests into consideration,
resulting in an alpha value of (0.05 / 6 =) 0.0083.
If the p value if below that alpha value,
the formations have a significantly different ratings distributions,
meaning that the different group members have had an effect
on the perceived quality of the songs.
Else, we will conclude that the two formations
have produced songs of equal perceived quality.

## Results

...

## Conclusion

From our p-value we conclude that
the groups are [equally/differently] enjoyable.

[If there is a difference, then:]
We observe in figure 1 that the [first/second]
group is more enjoyable.

## Discussion

One confounding factor is that the composers age.

The dataset used has multiple factors that weaken
it. First, users will not rate all songs.
Second, users will rate different songs.
Thirdly, users will have different distributions
on their ratings. As the dataset is quite big,
we expect these factors to average out any biases.
However, it will make it harder to observe any significant
effects.
