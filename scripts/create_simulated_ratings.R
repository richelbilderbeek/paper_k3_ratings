#!/bin/env Rscript

target_filename <- paste0(getwd(), "/docs/analysis/ratings.csv")
if(!file.exists(target_filename)) setwd("..")
target_filename <- paste0(getwd(), "/docs/analysis/ratings.csv")
testthat::expect_true(file.exists(target_filename))



average_rating_per_formation <- tibble::tribble(
  ~formation, ~average_rating,
  1, 8.0,
  2, 7.5,
  3, 7.0,
  4, 6.5
)
testthat::expect_true(
  all(
    average_rating_per_formation$formation %in% 
      heyahmama::get_formations_wide()$formation
  )
)

heyahmama::get_writers_groups()

average_rating_difference_per_writers_group <- tibble::tribble(
  ~group_id, ~average_rating_difference,
  0        , 0.5
)


create_simulated_ratings <- function(n_ratings = 1000) {
  
  songs <- dplyr::select(heyahmama::get_songs(), cd_title, song_title)
  cds <- dplyr::select(heyahmama::get_cds(), cd_title, formation)
  songs_per_formation <- merge(songs, cds)
  
  rated_songs <- tibble::tibble(
    song_title = sample(songs_per_formation$song_title, size = n_ratings, replace = TRUE),
  )
  ratings_with_formations <- merge(rated_songs, songs_per_formation)
  ratings_with_formations$rating <- sample(seq(1, 10), size = n_ratings, replace = TRUE)
  ratings_with_formations$rating <- ratings_with_formations$rating - ((ratings_with_formations$formation - 1) / 2)
  ratings_with_formations[ratings_with_formations$rating < 1, ]$rating <- 1
  
  ratings_with_formations$rater_name = sample(c("Mister A", "Miss B", "Person C"), size = n_ratings, replace = TRUE)
  ratings_with_formations$url <- "simulated"
  dplyr::select(ratings_with_formations, song_title, rating, rater_name, url)
  
}

t <- create_simulated_ratings()

expected_column_names <- c("song_title", "rating", "rater_name", "url")
testthat::expect_equal(names(t), expected_column_names)

readr::write_csv(t, target_filename)




