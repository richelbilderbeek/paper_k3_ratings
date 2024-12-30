#!/bin/env Rscript
#
# Create a PDF from the R markdown file containing the dialogue
#
# Usage:
#
#   ./scripts/create_rendered_versions_of_rmd_analysis.R

path_from <- "docs/analysis/analysis.Rmd"

if (!file.exists(path_from)) {
  setwd("..")
}
testthat::expect_true(file.exists(path_from))
path_from <- paste0(getwd(), "/docs/analysis/analysis.Rmd")
path_to <- paste0(getwd(), "/docs/analysis/analysis.pdf")
testthat::expect_true(file.exists(path_from))

rmarkdown::render(
  path_from, 
  "md_document"
)

rmarkdown::render(
  path_from, 
  "pdf_document"
)

testthat::expect_true(file.exists(path_to))
