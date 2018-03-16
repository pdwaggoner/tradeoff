# tradeoff
Calculating tradeoffs in decision-making based on aggregate behavior

# `mlbstats`: Major League Baseball Player Statistics Calculator

## Why should I use `mlbstats`?

This package serves as a baseball statistics calculator. Similar to using `sum(2,2)` in R to compute the output `[1] 4`, `mlbstats` allows for simple computation of a host of player-level metrics based on raw inputs. Metrics from major league baseball (MLB) include batting, pitching, fielding, baserunning, and overall player statistics. As a note, some metrics were omitted due to lack of readily available *raw* data to plug into functions (e.g., UZR or WAR, which require complex *and* conditional weighting strategies). Rather, the goal of this package is to provide an intuitive calculator for interested users to quickly and efficiently calculate player metrics based on raw, easily obtainable data. For more complex metrics such as WAR, UZR, PWA, and others, see resources such as <https://www.baseball-reference.com/> or Bill James' sabermetrics guides.

## How do I use `mlbstats`?

The idea behind this package is to allow for intuitive, simple interaction with MLB player-level metrics. As such, from the simplest calculations (e.g., batting average, which is computed by dividing the number of hits by at bats) to complicated ones (e.g., a pitcher's component earned run average, calculated as a function of hits, walks, batters hit, homeruns, intentional walks, numberof batters facing the pitcher, and innings pitched, as well as relevant weights, with the formula as, `9 * ((h + bb + hbp) * (0.89 * (1.255 * (h - hr) + 4 * hr) + 0.56 * (bb + hbp - ibb)) / (bfp * ip)) - 0.56)`), `mlbstats` allows for simply inputting raw player-level data into the relevant function, with each input separated by a comma, to yield the desired metric. To see how this works, consider a few examples.

```{r }
# first install the package from tar.gz file (this will be updated with the "install.packages()" command, once the package is in CRAN)
library(mlbstats) # then, run the library
```

###### Jose Altuve's (Houston Astros' Slugger) 2017 Regular Season OBP (on-base percentage metric)

```{r }
obp(204, 58, 9, 590, 4) # see help pages for descriptions of each input
```

[1] 0.4099849

See the official MLB statistics site for verification, that Altuve's 2017 Regular Season OBP was recorded as 0.410. Take another example from Boston Red Sox pitcher Chris Sale.
