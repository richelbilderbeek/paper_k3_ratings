In this document, we do the analysis presented in the paper.

Currently, the analysis uses fake data.

## Setup

    library(testthat)

## Reading the data

    ratings <- readr::read_csv("ratings.csv", show_col_types = FALSE)
    n_ratings <- nrow(ratings)

There are 1000 ratings.

## Analysis

Connecting the ratings to the formations:

    songs <- dplyr::select(heyahmama::get_songs(), cd_title, song_title)
    n_songs <- nrow(songs)

There are 270 songs.

    cds <- dplyr::select(heyahmama::get_cds(), cd_title, formation)
    n_cds <-nrow(cds)

There are 22 CDs.

    songs_per_formation <- dplyr::select(merge(songs, cds), song_title, formation)

    # Not yet
    # testthat::expect_equal(n_songs, nrow(songs_per_formation))
    if (n_songs != nrow(songs_per_formation)) {
      warning("Not all songs are found to be on a CD")
    }
    #> Warning: Not all songs are found to be on a CD

    knitr::kable(head(songs_per_formation))

<table>
<thead>
<tr class="header">
<th style="text-align: left;">song_title</th>
<th style="text-align: right;">formation</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1, 2, Doe met me mee</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: left;">Miljoen</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Laat de wind maar waaien</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: left;">Oma’s aan de top</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Alle kleuren</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="even">
<td style="text-align: left;">Hippie shake</td>
<td style="text-align: right;">1</td>
</tr>
</tbody>
</table>

Add the formations to the ratings:

    ratings_per_formation <- dplyr::select(merge(ratings, songs_per_formation), formation, rating)
    ratings_per_formation$formation <- as.factor(ratings_per_formation$formation)
    knitr::kable(head(ratings_per_formation))

<table>
<thead>
<tr class="header">
<th style="text-align: left;">formation</th>
<th style="text-align: right;">rating</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: right;">9</td>
</tr>
<tr class="even">
<td style="text-align: left;">1</td>
<td style="text-align: right;">6</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: right;">10</td>
</tr>
<tr class="even">
<td style="text-align: left;">1</td>
<td style="text-align: right;">10</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: right;">5</td>
</tr>
<tr class="even">
<td style="text-align: left;">1</td>
<td style="text-align: right;">4</td>
</tr>
</tbody>
</table>

Plot:

    ggplot2::ggplot(
      ratings_per_formation,
      ggplot2::aes(x = formation, y = rating)
    ) + ggplot2::geom_violin()

![](analysis_files/figure-markdown_strict/unnamed-chunk-8-1.png)

Order formations by ratings:

    average_rating_per_formation <-
      ratings_per_formation |> dplyr::group_by(formation) |> dplyr::summarise(average_rating = mean(rating))

    ordered_average_rating_per_formation <-  average_rating_per_formation |> dplyr::arrange(dplyr::desc(average_rating))

    knitr::kable(ordered_average_rating_per_formation)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">formation</th>
<th style="text-align: right;">average_rating</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: right;">5.555249</td>
</tr>
<tr class="even">
<td style="text-align: left;">4</td>
<td style="text-align: right;">5.543750</td>
</tr>
<tr class="odd">
<td style="text-align: left;">2</td>
<td style="text-align: right;">5.485876</td>
</tr>
<tr class="even">
<td style="text-align: left;">3</td>
<td style="text-align: right;">5.248485</td>
</tr>
</tbody>
</table>

## Statistics

Do the formations have different ratings?

    ratings_1 <- ratings_per_formation[ratings_per_formation$formation == 1, ]$rating
    ratings_2 <- ratings_per_formation[ratings_per_formation$formation == 2, ]$rating
    ratings_3 <- ratings_per_formation[ratings_per_formation$formation == 3, ]$rating
    ratings_4 <- ratings_per_formation[ratings_per_formation$formation == 4, ]$rating
    p_12 <- ks.test(ratings_1, ratings_2, alternative = "two.sided")$p.value
    #> Warning in ks.test.default(ratings_1, ratings_2, alternative = "two.sided"):
    #> p-value will be approximate in the presence of ties
    p_13 <- ks.test(ratings_1, ratings_3, alternative = "two.sided")$p.value
    #> Warning in ks.test.default(ratings_1, ratings_3, alternative = "two.sided"):
    #> p-value will be approximate in the presence of ties
    p_14 <- ks.test(ratings_1, ratings_4, alternative = "two.sided")$p.value
    #> Warning in ks.test.default(ratings_1, ratings_4, alternative = "two.sided"):
    #> p-value will be approximate in the presence of ties
    p_23 <- ks.test(ratings_2, ratings_3, alternative = "two.sided")$p.value
    #> Warning in ks.test.default(ratings_2, ratings_3, alternative = "two.sided"):
    #> p-value will be approximate in the presence of ties
    p_24 <- ks.test(ratings_2, ratings_4, alternative = "two.sided")$p.value
    #> Warning in ks.test.default(ratings_2, ratings_4, alternative = "two.sided"):
    #> p-value will be approximate in the presence of ties
    p_34 <- ks.test(ratings_3, ratings_4, alternative = "two.sided")$p.value
    #> Warning in ks.test.default(ratings_3, ratings_4, alternative = "two.sided"):
    #> p-value will be approximate in the presence of ties
    p_values_table <- tibble::tribble(
      ~comparison, ~p_value,
      "12", p_12,
      "13", p_13,
      "14", p_14,
      "23", p_23,
      "24", p_24,
      "34", p_34
    )
    alpha <- 0.05
    p_values_table$is_the_same <- p_values_table$p_value > alpha
    knitr::kable(p_values_table)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">comparison</th>
<th style="text-align: right;">p_value</th>
<th style="text-align: left;">is_the_same</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">12</td>
<td style="text-align: right;">0.9711847</td>
<td style="text-align: left;">TRUE</td>
</tr>
<tr class="even">
<td style="text-align: left;">13</td>
<td style="text-align: right;">0.6301308</td>
<td style="text-align: left;">TRUE</td>
</tr>
<tr class="odd">
<td style="text-align: left;">14</td>
<td style="text-align: right;">0.9999999</td>
<td style="text-align: left;">TRUE</td>
</tr>
<tr class="even">
<td style="text-align: left;">23</td>
<td style="text-align: right;">0.8778946</td>
<td style="text-align: left;">TRUE</td>
</tr>
<tr class="odd">
<td style="text-align: left;">24</td>
<td style="text-align: right;">0.9998167</td>
<td style="text-align: left;">TRUE</td>
</tr>
<tr class="even">
<td style="text-align: left;">34</td>
<td style="text-align: right;">0.7312569</td>
<td style="text-align: left;">TRUE</td>
</tr>
</tbody>
</table>
