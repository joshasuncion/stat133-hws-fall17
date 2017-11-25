# load required library
library("stringr")

# title: remove_missing
# description: remove missing values from numeric vector
# arguments: numeric vector
# output: numeric vector
remove_missing <- function(x) {
  x[is.na(x) == FALSE]
}

# title: check_missing
# description: check if numeric vector has missing values and remove them
# arguments: numeric vector, na.rm
# output: numeric vector
check_missing <- function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    remove_missing(x)
  } else {
    x
  }
}

# title: check_numeric
# description: return error if input is not numeric vector
# arguments: object
# output: none or error
check_numeric <- function(x) {
  if (is.numeric(x) == FALSE) {
    stop("non-numeric argument")
  }
}

# title: get_minimum
# description: find minimum value in numeric vector
# arguments: numeric vector, na.rm
# output: minimum value
get_minimum <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  x = sort(x)
  x[1]
}

# title: get_maximum
# description: find maximum value in numeric vector
# arguments: numeric vector, na.rm
# output: maximum value
get_maximum <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  x = sort(x, decreasing = TRUE)
  x[1]
}

# title: get_range
# description: find range of numeric vector
# arguments: numeric vector, na.rm
# output: range value
get_range <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  get_maximum(x) - get_minimum(x)
}

# title: get_median
# description: find median of numeric vector
# arguments: numeric vector, na.rm
# output: median value
get_median <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  x = sort(x)
  len = length(x)
  if (len %% 2 == 0) {
    (x[len / 2] + x[(len / 2) + 1]) / 2
  } else {
    x[(len + 1) / 2]
  }
}

# title: get_average
# description: find average of numeric vector
# arguments: numeric vector, na.rm
# output: average value
get_average <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  total = 0
  for (i in 1:length(x)) {
    total = total + x[i]
  }
  total / length(x)
}

# title: get_stdev
# description: find standard deviation of numeric vector
# arguments: numeric vector, na.rm
# output: standard deviation value
get_stdev <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  average = get_average(x)
  total = 0
  for (i in 1:length(x)) {
    total = total + ((x[i] - average) ^ 2)
  }
  sqrt(total / (length(x) - 1))
}

# title: get_quartile1
# description: find first quartile of numeric vector
# arguments: numeric vector, na.rm
# output: first quartile value
get_quartile1 <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  quantile(x, names = FALSE)[2]
}

# title: get_quartile3
# description: find third quartile of numeric vector
# arguments: numeric vector, na.rm
# output: third quartile value
get_quartile3 <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  quantile(x, names = FALSE)[4]
}

# title: get_percentile10
# description: find tenth percentile of numeric vector
# arguments: numeric vector, na.rm
# output: tenth percentile value
get_percentile10 <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  quantile(x, 0.10, names = FALSE)
}

# title: get_percentile90
# description: find ninetieth percentile of numeric vector
# arguments: numeric vector, na.rm
# output: ninetieth percentile value
get_percentile90 <- function(x, na.rm = FALSE) {
  check_numeric(x)
  x = check_missing(x, na.rm)
  quantile(x, 0.90, names = FALSE)
}

# title: count_missing
# description: find number of missing values in numeric vector
# arguments: numeric vector
# output: number of missing values
count_missing <- function(x) {
  length(x[is.na(x) == TRUE])
}

# title: summary_stats
# description: return list of summary statistics of numeric vector
# arguments: numeric vector, na.rm
# output: list of summary statistics
summary_stats <- function(x, na.rm = FALSE) {
  check_numeric(x)
  missing = count_missing(x)
  x = check_missing(x, na.rm)
  list(minimum = get_minimum(x),
       percent10 = get_percentile10(x),
       quartile1 = get_quartile1(x),
       median = get_median(x),
       mean = get_average(x),
       quartile3 = get_quartile3(x),
       percent90 = get_percentile90(x),
       maximum = get_maximum(x),
       range = get_range(x),
       stdev = get_stdev(x),
       missing = missing
       )
}

# title: print_stats
# description: print list of summary statistics in nice format
# arguments: list of summary statistics
# output: formatted lists
print_stats <- function(x) {
  cat(str_c(str_pad(names(x), 9, "right"),
            ":",
            " ",
            format(round(as.numeric(x), digits = 4), nsmall = 4)),
      sep = "\n")
}

# title: rescale100
# description: rescale numeric vector from 0 to 100
# arugments: numeric vector, minimum value, maximum value
# output: rescaled numeric vector
rescale100 <- function(x, xmin, xmax) {
  100 * (x - xmin) / (xmax - xmin)
}

# title: drop_lowest
# description: remove lowest value in numeric vector
# arguments: numeric vector
# output: numeric vector
drop_lowest <- function(x) {
  len = length(x)
  lowest = get_minimum(x)
  for (i in 1:len) {
    if (x[i] == lowest) {
      x[i] = NA
      x = remove_missing(x)
      break
    }
  }
  x
}

# title: score_homework
# description: optionally drop lowest score in vector of homework scores
#              and find the average score
# arguments: numeric vector, drop
# output: average value
score_homework <- function(x, drop = FALSE) {
  if (drop == TRUE) {
    x = drop_lowest(x)
  }
  get_average(x)
}

# title: score_quiz
# description: optionally drop lowest score in vector of quiz scores
#              and find the average score
# arguments: numeric vector, drop
# output: average value
score_quiz <- function(x, drop = FALSE) {
  if (drop == TRUE) {
    x = drop_lowest(x)
  }
  get_average(x)
}

# title: score_lab
# description: find lab score based on numeric value of lab attendance
# arguments: numeric value
# output: lab score
score_lab <- function(x) {
  if (x == 11 | x == 12) {
    100
  } else if (x == 10) {
    80
  } else if (x == 9) {
    60
  } else if (x == 8) {
    40
  } else if (x == 7) {
    20
  } else {
    0
  }
}
