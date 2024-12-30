#!/bin/env Rscript

target_filename <- paste0(getwd(), "/docs/analysis/ratings.csv")
if(!file.exists(target_filename)) setwd("..")
target_filename <- paste0(getwd(), "/docs/analysis/ratings.csv")
testthat::expect_true(file.exists(target_filename))

create_simulated_ratings <- function(n_ratings = 1000) {
  song_titles <- heyahmama::get_songs()$song_title
  tibble::tibble(
    song_title = sample(song_titles, size = n_ratings, replace = TRUE),
    rating = sample(seq(1, 10), size = n_ratings, replace = TRUE),
    rater_name = sample(c("Mister A", "Miss B", "Person C"), size = n_ratings, replace = TRUE)
  )
}

t <- create_simulated_ratings()

expected_column_names <- c("song_title", "rating", "rater_name")
testthat::expect_equal(names(t), expected_column_names)

readr::write_csv(t, target_filename)




