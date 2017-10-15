# Title: Table of NBA Teams and Statistics
# Description: This script prepares data from roster statistics and game statistics in order to create a new data file that has statistics by team.
# Input(s): "nba2017-roster.csv", "nba2017-stats.csv"
# Output(s): "efficiency-summary.txt", "teams-summary.txt", "nba2017-teams.csv", "teams_star_plot.pdf", "experience_salary.pdf"


library(dplyr)
library(ggplot2)

roster <- read.csv("data/nba2017-roster.csv")
stats <- read.csv("data/nba2017-stats.csv")

stats <- mutate(stats,
                missed_fg = field_goals_atts - field_goals_made,
                missed_ft = points1_atts - points1_made,
                points = points3_made * 3 + points2_made * 2 + points1_made,
                rebounds = off_rebounds + def_rebounds,
                efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers) / games_played
                )

sink(file = "output/efficiency-summary.txt")
summary(stats$efficiency)
sink()

roster_stats = merge(roster, stats)

teams <- summarize(group_by(roster_stats, team),
                   experience = round(sum(experience), 2),
                   salary = round(sum(salary) / 1000000, 2),
                   points3 = sum(points3_made),
                   points2 = sum(points2_made),
                   free_throws = sum(points1_made),
                   points = sum(points),
                   off_rebounds = sum(off_rebounds),
                   def_rebounds = sum(def_rebounds),
                   assists = sum(assists),
                   steals = sum(steals),
                   blocks = sum(blocks),
                   turnovers = sum(turnovers),
                   fouls = sum(fouls),
                   efficiency = sum(efficiency)
                   )
teams$team <- as.character(teams$team)

sink(file = "output/teams-summary.txt")
summary(teams)
sink()

write.csv(teams, file = "data/nba2017-teams.csv")

pdf(file = "images/teams_star_plot.pdf")
stars(teams[ , -1], labels = teams$team)
dev.off()

pdf(file = "images/experience_salary.pdf")
ggplot(teams, aes(x=experience, y=salary)) + geom_text(aes(label=team)) + ggtitle("Scatterplot of Experience and Salary")
dev.off()
