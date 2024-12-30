# Does perceived song quality depend on band members for same composers?

## Abstract

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

What is the effect that members of a
music band have on the perceived quality
on their songs, when these songs
are written by others?
Do the song writers adapt to the band members
in a noticable way?

This has been a burning for the Flemish music group
called K3, which is a famous Flemish/Dutch music group
that currently is in its fourth formation
and has produced 22 CDs, with mostly the
exact same group of writers.

This research tries to conclude if a certain formation
did better or worse.

## Hypothesis

- H1: the songs unique to each K3 formation
  have the same distribution in their ratings
- H2: the songs unique to each K3 formation
  have the same distribution in their ratings,
  if the songs compared have the same writers

## Methods

### Data set

For the information on K3, the R package `heyahmama` is used.
This package contains a list of all 22 studio CDs,
the formation for that CD and the song titles on each CD.
The table with CD title and formation can be found at [cds.md](cds.md).
The table with songs can be found at [songs.md](songs.md).

### Song selection

For hypothesis 1, all songs that are unique to a formation
are used. For hypothesis 2, only songs are used that
are written by the exact same group of text writers.

#### Ratings

We obtain ratings (which are values from
1 to 10, where 1 is worst and 10 is best)
from two websites in which fans
have rated K3 songs,
which are [https://github.com/richelbilderbeek/k3reviews](https://github.com/richelbilderbeek/k3reviews)
and [forum.popjustice.com](https://forum.popjustice.com/threads/its-the-k3-singles-rate.62219/).

The table with ratings can be found at [ratings.md](ratings.md).

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
