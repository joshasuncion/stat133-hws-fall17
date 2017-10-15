HW03 - Ranking NBA Teams
================
Josh Asuncion
October 14, 2017

Ranking of Teams
----------------

``` r
library(ggplot2)
teams <- read.csv("../data/nba2017-teams.csv")
```

``` r
ggplot(teams, aes(x=reorder(team, salary), y=salary)) + geom_bar(stat="identity") + geom_hline(yintercept=mean(teams$salary), col="red", size=2) + xlab("Team") + ylab("Salary (in millions)") + ggtitle("NBA Teams ranked by Total Salary") + coord_flip()
```

![](hw03-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
ggplot(teams, aes(x=reorder(team, points), y=points)) + geom_bar(stat="identity") + geom_hline(yintercept=mean(teams$points), col="red", size=2) + xlab("Team") + ylab("Total Points") + ggtitle("NBA Teams ranked by Total Points") + coord_flip()
```

![](hw03-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

``` r
ggplot(teams, aes(x=reorder(team, efficiency), y=efficiency)) + geom_bar(stat="identity") + geom_hline(yintercept=mean(teams$efficiency), col="red", size=2) + xlab("Team") + ylab("Total Efficiency") + ggtitle("NBA Teams ranked by Total Efficiency") + coord_flip()
```

![](hw03-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)
