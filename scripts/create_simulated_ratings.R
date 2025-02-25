#!/bin/env Rscript

target_filename <- paste0(getwd(), "/docs/analysis/ratings.csv")
if(!file.exists(target_filename)) setwd("..")
target_filename <- paste0(getwd(), "/docs/analysis/ratings.csv")
testthat::expect_true(file.exists(target_filename))

# These values are chosen to give an interesting data set,
# are more extreme than would be expected from measurements
# and are unrelated to any real data
average_rating_per_formation <- tibble::tribble(
  ~formation, ~average_rating,
  1, 8.0,
  2, 7.5,
  3, 7.0,
  4, 6.5
)

testthat::expect_equal(
  sort(unique(average_rating_per_formation$formation)),
  sort(unique(heyahmama::get_formations_wide()$formation))
)
# These values are chosen to give an interesting data set,
# are more extreme than would be expected from measurements
# and are unrelated to any real data
average_rating_per_writer <- tibble::tribble(
  ~writer_name, ~average_rating,
  "Alain Vande Putte", 8.0,
  "Danny Verbiest", 6.0,
  "Dennis Peirs", 1.0,
  "Gert Verhulst", 9.0,
  "Hans Bourlon", 2.0,
  "Johan Vanden Eede", 3.0,
  "Marc Paelinck", 4.0,
  "Miguel Wiels", 7.0,
  "Peter Gillis", 6.0,
  "Ronald Buersens", 6.0,
  "Tracy Atkins", 6.0
)
testthat::expect_equal(
  sort(unique(heyahmama::get_writer_names())),
  sort(unique(average_rating_per_writer$writer_name))
)

heyahmama::get_writers_groups()



average_rating_difference_per_writers_group <- tibble::tribble(
  ~group_id, ~average_rating_difference,
  0        , 0.5
)

# These values are chosen to give an interesting data set,
# are more extreme than would be expected from measurements
# and are unrelated to any real data
average_rating_per_year <- tibble::tibble(
  year = seq(
    from = min(heyahmama::get_cds()$year), 
    to = max(heyahmama::get_cds()$year)
  )
)
average_rating_per_year$average_rating <- 10.0 - (0.1 * (average_rating_per_year$year - 1999))


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




