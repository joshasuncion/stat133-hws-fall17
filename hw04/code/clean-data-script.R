# ==========================================================================
# Title: Table of Stat 133 Scores
# Description: This script cleans the raw data of Stat 133 scores
# Inputs: "rawscores.csv"
# Outputs: "summary-rawscores.txt", "Lab-stats.txt", "Homework-stats.txt",
#          "Quiz-stats.txt", "Test1-stats.txt", "Test2-stats.txt",
#          "Overall-stats.txt", "summary-cleanscores.txt", "cleanscores.csv"
# ==========================================================================

# load required library
library("stringr")

# source in functions
source("functions.R")

# read in "rawscores.csv"
scores <- read.csv("../data/rawdata/rawscores.csv")

# sink structure and summary statistics of raw scores
sink("../output/summary-rawscores.txt")
str(scores)
for (i in 1:ncol(scores)) {
  cols <- names(scores)
  print(cols[i])
  print_stats(summary_stats(scores[ , i], na.rm = TRUE))
}
sink()

# replace all missing values NA in raw scores with zero
for (j in 1:ncol(scores)) {
  for (i in 1:nrow(scores)) {
    if (is.na(scores[i, j])) {
      scores[i, j] = 0
    }
  }
}

# rescale quizzes using rescale100()
scores$QZ1 <- rescale100(scores$QZ1, xmin = 0, xmax = 12)
scores$QZ2 <- rescale100(scores$QZ2, xmin = 0, xmax = 18)
scores$QZ3 <- rescale100(scores$QZ3, xmin = 0, xmax = 20)
scores$QZ4 <- rescale100(scores$QZ4, xmin = 0, xmax = 20)

# add variables Test1 and Test2 using rescale100()
scores$Test1 <- rescale100(scores$EX1, xmin = 0, xmax = 80)
scores$Test2 <- rescale100(scores$EX2, xmin = 0, xmax = 90)

# add variable Homework using score_homework()
scores$Homework <- numeric(length = nrow(scores))
for (i in 1:nrow(scores)) {
  HW = c(scores[i, "HW1"], scores[i, "HW2"], scores[i, "HW3"],
         scores[i, "HW4"], scores[i, "HW5"], scores[i, "HW6"],
         scores[i, "HW7"], scores[i, "HW8"], scores[i, "HW9"])
  scores[i, "Homework"] <- score_homework(HW, drop = TRUE)
}

# add variable Quiz using score_quiz()
scores$Quiz <- numeric(length = nrow(scores))
for (i in 1:nrow(scores)) {
  QZ = c(scores[i, "QZ1"], scores[i, "QZ2"],
         scores[i, "QZ3"], scores[i, "QZ4"])
  scores[i, "Quiz"] <- score_quiz(QZ, drop = TRUE)
}

# add variable Lab using score_lab()
scores$Lab <- numeric(length = nrow(scores))
for (i in 1:nrow(scores)) {
  scores[i, "Lab"] <- score_lab(scores[i, "ATT"])
}

# add variable Overall using lab, homework, quiz and test scores
scores$Overall <- numeric(length = nrow(scores))
for (i in 1:nrow(scores)) {
  scores[i, "Overall"] <- (0.10 * scores[i, "Lab"]) +
                          (0.30 * scores[i, "Homework"]) +
                          (0.15 * scores[i, "Quiz"]) +
                          (0.20 * scores[i, "Test1"]) +
                          (0.25 * scores[i, "Test2"])
}

# add variable Grade using overall score
scores$Grade <- character(length = nrow(scores))
for (i in 1:nrow(scores)) {
  score = scores[i, "Overall"]
  if (score >= 95 & score <= 100) {
    scores[i, "Grade"] <- "A+"
  } else if (score >= 90 & score < 95) {
    scores[i, "Grade"] <- "A"
  } else if (score >= 88 & score < 90) {
    scores[i, "Grade"] <- "A-"
  } else if (score >= 86 & score < 88) {
    scores[i, "Grade"] <- "B+"
  } else if (score >= 82 & score < 86) {
    scores[i, "Grade"] <- "B"
  } else if (score >= 79.5 & score < 82) {
    scores[i, "Grade"] <- "B-"
  } else if (score >= 77.5 & score < 79.5) {
    scores[i, "Grade"] <- "C+"
  } else if (score >= 70 & score < 77.5) {
    scores[i, "Grade"] <- "C"
  } else if (score >= 60 & score < 70) {
    scores[i, "Grade"] <- "C-"
  } else if (score >= 50 & score < 60) {
    scores[i, "Grade"] <- "D"
  } else {
    scores[i, "Grade"] <- "F"
  }
}

# sink summary statistics of Lab, Homework, Quiz, Test1, Test2, and Overall
for (i in 1:6) {
  cols = c("Lab", "Homework", "Quiz", "Test1", "Test2", "Overall")
  sink(paste("../output/", cols[i], "-stats.txt", sep = ""))
  print_stats(summary_stats(scores[ , cols[i]]))
  sink()
}

# sink structure of clean scores
sink("../output/summary-cleanscores.txt")
str(scores)
sink()

# export clean scores to "cleanscores.csv"
write.csv(scores, file = "../data/cleandata/cleanscores.csv")
