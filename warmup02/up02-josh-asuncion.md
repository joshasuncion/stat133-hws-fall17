Warm-Up 02 - Stat 133, Fall 2017
================
Josh Asuncion
September 16, 2017

Quantitative Variable: `points3`
--------------------------------

``` r
load("nba2017-salary-points.RData")
```

``` r
mean <- mean(points3)
sd <- sd(points3)
min <- min(points3)
max <- max(points3)
median <- median(points3)
quantile <- quantile(points3)
```

| Mean      | SD         | Min | Max | Median | Quantile          |
|-----------|------------|-----|-----|--------|-------------------|
| 49.707483 | 55.9720966 | 0   | 324 | 32     | 0, 3, 32, 78, 324 |

The `points3` variable in `nba2017-salary-points.RData` has interesting characteristics.

The first thing that stuck out to me was the large difference between `min` and `mean`, and `max` and `mean`. To understand this, I decided to plot the data using `hist(points3)`, and the following chart was produced:

``` r
hist(points3)
```

![](up02-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

Some observations I had from this chart were:

-   The data forms a right-skewed distribution.
-   More than 250 NBA players only made between 0 and 50 3-pointers in the 2017 season.
-   Less than 50 players in total made between 150 and 350 3-pointers.
-   The `max` is an outlier compared to the rest of the data.

Plotting `boxplot(points3)` produces similar results:

``` r
boxplot(points3)
```

![](up02-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

Looking at this chart, I observed that:

-   The `min` and the first quartile are right next to each other.
-   The third quartile doesn't even reach halfway between the `min` and the `max`.
-   The `max` is very far from the next highest value.

This led me to multiple conclusions:

1.  NBA players that make upwards of 200 3-pointers are uncommon.
2.  There is a clear best 3-point shooter: the player with the max of 324 made shots. The next player doesn't break 300.
3.  Being a prolific 3-point shooter is difficult, as the vast majority of NBA players are not.
4.  It is a commodity for a team to have a player that can make 3-pointers at a high rate, since not many have that ability.

------------------------------------------------------------------------

Qualitative Variable: `position`
--------------------------------

``` r
count <- table(position)
count
```

    ## position
    ##  C PF PG SF SG 
    ## 89 89 85 83 95

To determine the proportion of each position among all players, we can take `count` and divide by the sum of `count`, which will return a table of the percentage of total players under each position.

``` r
proportion <- count / sum(count)
proportion
```

    ## position
    ##         C        PF        PG        SF        SG 
    ## 0.2018141 0.2018141 0.1927438 0.1882086 0.2154195

The distribution of positions among NBA players in the 2017 season is about even. Shooting Guard is the most popular position with 95 players, while Small Forward is the least with 83. However, each position has almost the same proportion of players.

``` r
barplot(count)
```

![](up02-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

``` r
barplot(proportion)
```

![](up02-josh-asuncion_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-2.png)

As shown by the bar chart, each position has around 20% of the total players.

------------------------------------------------------------------------

Report
------

I found making the table to be especially hard. It took a long time to figure out how to create inline code, so that I would not have to manually input the values for each column.

Plotting the various graphs and figuring out patterns was somewhat easy. I found that it was easier to understand `mean`, `sd`, `quantile`, etc., when I first plotted the data, as the values go hand in hand with the graph.

An error that frustrated me was being unable to get lists to display properly after knitting. It took me awhile to realize that I needed to leave a line blank in between the first entry on the list and the preceding sentence.

The most time consuming part of this assignment was probably just formatting it correctly, making sure everything displayed correctly and neatly when knitted.
