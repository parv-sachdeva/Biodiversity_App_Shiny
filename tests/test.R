library(glue)
library(testthat)
source("../R/utils.R")

data_path="../data/split_by_country"

test_that("Load all countries", {
    countries <- get_all_countries(data_path = data_path)
    expect_length(countries, 226)
})

test_that("Load countries from wrong path", {
    countries <- get_all_countries(data_path = ".")
    expect_null(countries)
})

test_that("Load and test Poland entries", {
    data <- read_country_data(data_path = data_path, country = "Poland")
    expect_equal(nrow(data), 48457)
})