# HW04 - Grades Visualizer

The purpose of this assignment is threefold. First, to practice low level coding such as writing and testing functions. Second, to gain more experience with the Data Analysis Cycle and prepare data, perform data analysis and visualization, and report via interactive tools. Third, to learn R packages such as "testthat", "shiny", "ggvis", etc.

The following code can be invoked inside RStudio to run the shiny app.

```{r}
library(shiny)

# Run an app from a subdirectory in the repo
runGitHub("stat133-hws-fall17", "joshasuncion", subdir = "hw04/app")
```

# Comments and Reflections

This was my first time writing unit tests. However, after looking at the ggvis demo on the course github, I found the logic of testthat tests to be easy to understand. On a scale of 0 to 10, I would rate it a 2, for not that confusing.

This was also my first time working with ggvis. I had issues with the shiny app, but ggvis itself was not too bad to understand. The syntax is somewhat similar to ggplot. I would rate it a 4. There was a learning curve but it wasn't too bad.

This was my first time working with conditional panels in shiny. Again, I had issues with the shiny app, but I found that it was not that hard to work with the conditional panels themselves. I did have to rely on the conditional panels demo on the course github, but I was able to understand somewhat quickly how the first panel could be used for the first tab, and so forth. I would rate working with them at a 5. There was definitely a learning curve, but the examples really helped in my understanding.

Out of the three graphing paradigms (base plots, ggplot, and ggvis), I prefer ggplot so far. Although ggplot and ggvis are pretty similar, I have only seen ggvis in the context of shiny apps, and I prefer ggplot out of familiarity. However, I did find ggvis to be convenient and easy to use in the shiny app, so I may change my mind as I use ggvis more and become more familiar with it.

In total, I spent numerous hours working on this homework (maybe around a day's worth of work per section). This was by far the hardest and most time consuming homework assigned in the class. Each section provided its own challenges. For example, writing functions.R was very time consuming out of the sheer number of functions to write, in addition to some of the functions being very tricky to figure out. Writing tests.R was time consuming again out of the sheer number of tests to write.

Writing gradevis.R was the most challenging and time consuming of all because of my unfamiliarity with making shiny apps and because of the complexity of the required app. I had to depend entirely on examples of other shiny apps, such as the examples on the course github, examples from RStudio, or examples from other online sources. However, these examples were very helpful in making the shiny app, and I learned a lot.

# Resources

- https://github.com/ucb-stat133/stat133-fall-2017/tree/master/apps/ggvis-demo
- https://github.com/ucb-stat133/stat133-fall-2017/tree/master/apps/conditional-panels
- https://shiny.rstudio.com/images/shiny-cheatsheet.pdf
- https://shiny.rstudio.com/gallery/widgets.html
- https://shiny.rstudio.com/reference/shiny/1.0.5/
- https://ggvis.rstudio.com/ggvis-basics.html
- https://ggvis.rstudio.com/interactivity.html
- https://www.rdocumentation.org/packages/base/versions/3.4.1/topics/print
- https://www.rdocumentation.org/packages/base/versions/3.4.1/topics/format
- https://www.rdocumentation.org/packages/base/versions/3.4.1/topics/cat
- https://rdrr.io/cran/stringr/man/str_pad.html
- https://rdrr.io/cran/ggvis/man/layer_model_predictions.html
- https://stackoverflow.com/questions/3145312/r-removing-nas-in-numerical-vectors
- https://stackoverflow.com/questions/12614953/how-to-create-a-numeric-vector-of-zero-length-in-r
- https://stackoverflow.com/questions/15659528/how-to-get-nth-percentile-using-r-summary
- https://stackoverflow.com/questions/16566799/change-variable-name-in-for-loop-using-r
- https://stackoverflow.com/questions/26828902/for-loop-in-r-not-working
- https://stackoverflow.com/questions/15736719/how-do-i-extract-just-the-number-from-a-named-number-without-the-name
- https://stackoverflow.com/questions/37957419/r-how-to-list-column-names-vertically-instead-of-horizontally
- http://uc-r.github.io/string_manipulation_stringR/
- http://www.dummies.com/programming/r/how-to-format-numbers-in-r/
- http://rprogramming.net/write-csv-in-r/
- https://rstudio-pubs-static.s3.amazonaws.com/223060_d633f90a8363413b94789e68e6653179.html
- http://www.cookbook-r.com/Strings/Creating_strings_from_variables/
- https://www.statmethods.net/stats/frequencies.html
