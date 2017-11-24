# script containing unit tests
# library("testthat")
# source("functions.R")

context("remove_missing function")

test_that("remove_missing works", {
  a <- c(1, 2, 3)
  b <- c(NA, 1, 2, 3)
  c <- c(NA, NA, NA, NA, 100)
  d <- c('1', '2', '3', NA)
  expect_equal(remove_missing(a), c(1, 2, 3))
  expect_equal(remove_missing(b), c(1, 2, 3))
  expect_equal(remove_missing(c), 100)
  expect_equal(remove_missing(d), c('1', '2', '3'))
})

context("check_missing function")

test_that("check_missing works", {
  a <- c(1, 2, 3)
  b <- c(NA, 1, 2, 3)
  c <- c(NA, NA, NA, NA, 100)
  d <- c('1', '2', '3', NA)
  expect_equal(check_missing(a), c(1, 2, 3))
  expect_equal(check_missing(b, na.rm = TRUE), c(1, 2, 3))
  expect_equal(check_missing(c, na.rm = TRUE), 100)
  expect_equal(check_missing(d, na.rm = TRUE), c('1', '2', '3'))
})

context("check_numeric function")

test_that("check_numeric works", {
  a <- c(1, 2, 3)
  b <- NA
  c <- c('1', '2', '3')
  d <- c(1, '1', NA)
  expect_null(check_numeric(a))
  expect_error(check_numeric(b))
  expect_error(check_numeric(c))
  expect_error(check_numeric(d))
})

context("get_minimum function")

test_that("get_minimum works", {
  a <- c(1, 2, 3)
  b <- c(100, 100, 100, 100)
  c <- c(-123, -321, NA)
  d <- NA
  expect_equal(get_minimum(a), 1)
  expect_equal(get_minimum(b), 100)
  expect_equal(get_minimum(c, na.rm = TRUE), -321)
  expect_error(get_minimum(d))
})

context("get_maximum function")

test_that("get_maximum works", {
  a <- c(1, 2, 3)
  b <- c(100, 100, 100, 100)
  c <- c(-123, -321, NA)
  d <- NA
  expect_equal(get_maximum(a), 3)
  expect_equal(get_maximum(b), 100)
  expect_equal(get_maximum(c, na.rm = TRUE), -123)
  expect_error(get_maximum(d))
})

context("get_range function")

test_that("get_range works", {
  a <- c(1, 2, 3)
  b <- c(100, 100, 100, 100)
  c <- c(-123, -321, NA)
  d <- NA
  expect_equal(get_range(a), 2)
  expect_equal(get_range(b), 0)
  expect_equal(get_range(c, na.rm = TRUE), 198)
  expect_error(get_range(d))
})

context("get_median function")

test_that("get_median works", {
  a <- c(1, 2, 3)
  b <- c(10, 20, 30, 40)
  c <- c(0, 100, 200, NA)
  d <- NA
  expect_equal(get_median(a), 2)
  expect_equal(get_median(b), 25)
  expect_equal(get_median(c, na.rm = TRUE), 100)
  expect_error(get_median(d))
})

context("get_average function")

test_that("get_average works", {
  a <- c(1, 2, 3)
  b <- c(1, 1, 1, 1, 10)
  c <- c(0, 0, 4, 300, NA)
  d <- c(1, 1, 1, 1, '10')
  expect_equal(get_average(a), 2)
  expect_equal(get_average(b), 2.8)
  expect_equal(get_average(c, na.rm = TRUE), 76)
  expect_error(get_average(d))
})

context("get_stdev function")

test_that("get_stdev works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 1, 5)
  c <- c(1, 1, 1, 8, NA)
  d <- c(1, 1, 1, 1, '10')
  expect_equal(get_stdev(a), 2)
  expect_equal(get_stdev(b), 2)
  expect_equal(get_stdev(c, na.rm = TRUE), 3.5)
  expect_error(get_stdev(d))
})

context("get_quartile1 function")

test_that("get_quartile1 works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(0, 0, 4, 4, 6, 100, 300, NA)
  d <- c(2, 4, '6')
  expect_equal(get_quartile1(a), 3)
  expect_equal(get_quartile1(b), 1.75)
  expect_equal(get_quartile1(c, na.rm = TRUE), 2)
  expect_error(get_quartile1(d))
})

context("get_quartile3 function")

test_that("get_quartile3 works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(0, 0, 4, 4, 6, 100, 300, NA)
  d <- c(2, 4, '6')
  expect_equal(get_quartile3(a), 5)
  expect_equal(get_quartile3(b), 8.25)
  expect_equal(get_quartile3(c, na.rm = TRUE), 53)
  expect_error(get_quartile3(d))
})

context("get_percentile10 function")

test_that("get_percentile10 works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(0, 0, 4, 4, 6, 100, 300, NA)
  d <- c(2, 4, '6')
  expect_equal(get_percentile10(a), 2.4)
  expect_equal(get_percentile10(b), 1)
  expect_equal(get_percentile10(c, na.rm = TRUE), 0)
  expect_error(get_percentile10(d))
})

context("get_percentile90 function")

test_that("get_percentile90 works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(0, 0, 4, 4, 6, 100, 300, NA)
  d <- c(2, 4, '6')
  expect_equal(get_percentile90(a), 5.6)
  expect_equal(get_percentile90(b), 9.3)
  expect_equal(get_percentile90(c, na.rm = TRUE), 180)
  expect_error(get_percentile90(d))
})

context("count_missing function")

test_that("count_missing works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(NA, NA, NA, NA, 100, 200, 300)
  d <- c(2, 4, '6', '8', NA)
  expect_equal(count_missing(a), 0)
  expect_equal(count_missing(b), 0)
  expect_equal(count_missing(c), 4)
  expect_equal(count_missing(d), 1)
})

context("summary_stats function")

test_that("summary_stats works", {
  a <- c(2, 4, 6)
  b <- c(5, 10, 15)
  c <- c(1, 1, 1, 8, NA)
  d <- c(2, 4, 6, NA)
  expect_equivalent(summary_stats(a),
    list(2, 2.4, 3, 4, 4, 5, 5.6, 6, 4, 2, 0))
  expect_equivalent(summary_stats(b),
    list(5, 6, 7.5, 10, 10, 12.5, 14, 15, 10, 5, 0))
  expect_equivalent(summary_stats(c, na.rm = TRUE),
    list(1, 1, 1, 1, 2.75, 2.75, 5.9, 8, 7, 3.5, 1))
  expect_error(summary_stats(d))
})

context("rescale100 function")

test_that("rescale100 works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(1, 5, 55, 70, 100, 200)
  d <- c('2', '4', '6', '8', '10')
  expect_equal(rescale100(a, 0, 10),
    c(20, 40, 60))
  expect_equal(rescale100(b, 0, 20),
    c(5, 5, 10, 25, 25, 40, 45, 50))
  expect_equal(rescale100(c, 0, 200),
    c(0.5, 2.5, 27.5, 35.0, 50.0, 100.0))
  expect_error(rescale100(d, 0, 10))
})

context("drop_lowest function")

test_that("drop_lowest works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(1, 5, 55, 70, 100, 200)
  d <- c('2', '4', '6', '8', '10')
  expect_equal(drop_lowest(a), c(4, 6))
  expect_equal(drop_lowest(b), c(1, 2, 5, 5, 8, 9, 10))
  expect_equal(drop_lowest(c), c(5, 55, 70, 100, 200))
  expect_error(drop_lowest(d))
})

context("score_homework function")

test_that("score_homework works", {
  a <- c(2, 4, 6)
  b <- c(1, 1, 2, 5, 5, 8, 9, 10)
  c <- c(1, 5, 55, 70, 100, 200)
  d <- c('2', '4', '6', '8', '10')
  expect_equal(score_homework(a), 4)
  expect_equal(score_homework(b), 5.125)
  expect_equal(score_homework(c, drop = TRUE), 86)
  expect_error(score_homework(d))
})


context("score_quiz function")

test_that("score_quiz works", {
  a <- c(2, 4, 6)
  b <- c(5, 5, 8, 9, 10)
  c <- c(55, 70, 100, 200)
  d <- c('2', '4', '6', '8', '10')
  expect_equal(score_quiz(a, drop = TRUE), 5)
  expect_equal(score_quiz(b, drop = TRUE), 8)
  expect_equal(score_quiz(c), 106.25)
  expect_error(score_quiz(d))
})

context("score_lab function")

test_that("score_lab works", {
  a <- 12
  b <- 11
  c <- 8
  d <- 4
  expect_equal(score_lab(a), 100)
  expect_equal(score_lab(b), 100)
  expect_equal(score_lab(c), 40)
  expect_equal(score_lab(d), 0)
})
