Load required packages and set chunk options
--------------------------------------------

``` r
# Load packages
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidyr)
library(lubridate)
library(ggplot2)
library(scales) # required for ggplot
library(exactRankTests)
```

    ##  Package 'exactRankTests' is no longer under development.
    ##  Please consider using package 'coin' instead.

``` r
library(knitr)

# knitr chunk options
opts_chunk$set(echo = FALSE,
               warning = FALSE,
               message = FALSE,
               fig.path = './figures/',
               dev = c('png', 'pdf'),
               tidy = TRUE, 
               tidy.opts = list(width.cutoff = 65))
```

Import data
-----------

Convert "data" to dplyr object and get an overview of the data before cleaning
------------------------------------------------------------------------------

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    682561 obs. of  8 variables:
    ##  $ Pt.ID       : int  9 9 9 9 9 9 9 9 9 9 ...
    ##  $ Pain        : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Employed    : Factor w/ 2 levels "E","U": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ Time        : Factor w/ 109 levels "01-Dec-14","01-Feb-15",..: 12 12 12 12 12 12 12 12 12 12 ...
    ##  $ Day         : Factor w/ 1440 levels "00:00:00","00:01:00",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Count       : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ X..count    : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ pcount.ptmax: int  0 0 0 0 0 0 0 0 0 0 ...

Basic data cleaning
-------------------

### Set column names

***(Units and definitions remain as described in the README.md file)***

### Change $id and $pain to factors

### Add a new column ($date-time)

### Check the dataframe for duplicates

    ## [1] 682561      7

    ## [1] 682560

### Create repeating data/time factor to assist data sorting

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    682560 obs. of  1 variable:
    ##  $ marker: Factor w/ 136512 levels "1","2","3","4",..: 1 1 1 1 1 2 2 2 2 2 ...

Strip out inactive periods
--------------------------

### Find the average pmax.count for each 5-minute period

### Identify and sort active and inactive periods

***(mean pmax.count in a 5-minute period \> 2.5% = \> active)***

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    682560 obs. of  11 variables:
    ##  $ days        : Factor w/ 7 levels "d1","d2","d3",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ marker.3    : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ marker      : Factor w/ 136512 levels "1","2","3","4",..: 1 1 1 1 1 2 2 2 2 2 ...
    ##  $ id          : Factor w/ 68 levels "9","10","11",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ pain        : Factor w/ 2 levels "no.pain","pain": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ employed    : Factor w/ 2 levels "E","U": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ date        : POSIXct, format: "2014-10-03 00:00:00" "2014-10-03 00:01:00" ...
    ##  $ count       : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ pmax.count  : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ pptmax.count: int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ marker.4    : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    682560 obs. of  9 variables:
    ##  $ id          : Factor w/ 68 levels "9","10","11",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ date        : POSIXct, format: "2014-10-03 00:00:00" "2014-10-03 00:01:00" ...
    ##  $ days        : Factor w/ 7 levels "d1","d2","d3",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ pain        : Factor w/ 2 levels "no.pain","pain": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ employed    : Factor w/ 2 levels "E","U": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ count       : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ pmax.count  : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ pptmax.count: int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ active      : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...

Summary of pmax.count data
--------------------------

### 24-hour data (active and inactive periods)

#### Median and mean activity per day

    ## Source: local data frame [474 x 6]
    ## Groups: id, day, pain [?]
    ## 
    ##        id        day    pain employed Median  Mean
    ##    (fctr)      (chr)  (fctr)   (fctr)  (dbl) (dbl)
    ## 1       9 2014-10-03    pain        U      0   2.7
    ## 2       9 2014-10-04    pain        U      0   2.0
    ## 3       9 2014-10-05    pain        U      0   0.1
    ## 4       9 2014-10-06    pain        U      0   2.0
    ## 5       9 2014-10-07    pain        U      0   2.2
    ## 6       9 2014-10-09    pain        U      0   1.4
    ## 7       9 2014-10-10    pain        U      0   0.5
    ## 8      10 2014-09-16 no.pain        E      0   0.2
    ## 9      10 2014-09-17 no.pain        E      0   1.3
    ## 10     10 2014-09-18 no.pain        E      0   1.3
    ## ..    ...        ...     ...      ...    ...   ...

#### Median and mean activity per week

### Active periods only

#### Median and mean activity per day

#### Median and mean activity per week

Univariate analysis of the active period
----------------------------------------

### Mean time (in minutes) active per day over the week

#### Process the data

#### Pain vs no-pain

![](./figures/time_active_pain-1.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  data by pain
    ## W = 585, p-value = 0.8906
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max |
|:--------|:----|:-------|:----|:----|:----|
| no.pain | 31  | 134    | 91  | 18  | 266 |
| pain    | 37  | 122    | 114 | 23  | 261 |

#### Employed vs unemployed

![](./figures/time_active_employment-1.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  data by employed
    ## W = 647.5, p-value = 0.2418
    ## alternative hypothesis: true mu is not equal to 0

| Group | N   | Median | IQR | Min | Max |
|:------|:----|:-------|:----|:----|:----|
| E     | 41  | 141    | 99  | 18  | 266 |
| U     | 27  | 106    | 110 | 23  | 253 |

#### Conditional plot of employment and pain status

![](./figures/time_active_pain.employment-1.png)

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max |
|:-----------|:---------------|:----|:-------|:----|:----|:----|
| no.pain    | E              | 24  | 138    | 83  | 18  | 266 |
| no.pain    | U              | 7   | 95     | 93  | 52  | 196 |
| pain       | E              | 17  | 143    | 108 | 38  | 261 |
| pain       | U              | 20  | 111    | 130 | 23  | 253 |

### Percentage of actical maximum (pmax.count, %) active per day over the week

#### Process the data

#### Pain vs no-pain

![](./figures/pmax_pain-1.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  data by pain
    ## W = 599, p-value = 0.7573
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max |
|:--------|:----|:-------|:----|:----|:----|
| no.pain | 31  | 44     | 19  | 13  | 98  |
| pain    | 37  | 42     | 26  | 7   | 94  |

#### Employed vs unemployed

![](./figures/pmax_employment-1.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  data by employed
    ## W = 642.5, p-value = 0.2677
    ## alternative hypothesis: true mu is not equal to 0

| Group | N   | Median | IQR | Min | Max |
|:------|:----|:-------|:----|:----|:----|
| E     | 41  | 43     | 16  | 17  | 98  |
| U     | 27  | 37     | 30  | 7   | 94  |

#### Conditional plot of employment and pain status

![](./figures/pmax_pain.employment-1.png)

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max |
|:-----------|:---------------|:----|:-------|:----|:----|:----|
| no.pain    | E              | 24  | 45     | 18  | 17  | 98  |
| no.pain    | U              | 7   | 37     | 19  | 13  | 63  |
| pain       | E              | 17  | 42     | 16  | 23  | 94  |
| pain       | U              | 20  | 39     | 31  | 7   | 94  |

### Mean sum of daily activity over the week

#### Process the data

#### Pain vs no pain

![](./figures/total_activity_pain-1.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  data by pain
    ## W = 549, p-value = 0.7691
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR  | Min | Max  |
|:--------|:----|:-------|:-----|:----|:-----|
| no.pain | 31  | 1020   | 772  | 81  | 3465 |
| pain    | 37  | 1074   | 1054 | 92  | 3341 |

#### Employed vs unemployed

![](./figures/total_activity_employment-1.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  data by employed
    ## W = 647, p-value = 0.2456
    ## alternative hypothesis: true mu is not equal to 0

| Group | N   | Median | IQR | Min | Max  |
|:------|:----|:-------|:----|:----|:-----|
| E     | 41  | 1178   | 909 | 81  | 3465 |
| U     | 27  | 783    | 968 | 92  | 2340 |

#### Conditional plot of employment and pain status

![](./figures/total_activity_pain.employment-1.png)

| Group.Pain | Group.Employed | N   | Median | IQR  | Min | Max  |
|:-----------|:---------------|:----|:-------|:-----|:----|:-----|
| no.pain    | E              | 24  | 1130   | 736  | 81  | 3465 |
| no.pain    | U              | 7   | 632    | 599  | 275 | 2123 |
| pain       | E              | 17  | 1240   | 999  | 365 | 3341 |
| pain       | U              | 20  | 959    | 1151 | 92  | 2340 |

Univariate analysis of complete data
------------------------------------

***(active and inactive periods, data.10)*** \#\#\# Time spent (minutes) in quartiles (\(\geq\) 75%, 50-74%, 25-49%, and 0-24%) of percent patient maximum activity count per day over the week \#\#\#\# Fourth quartile (\(\geq\) 75%) ![](./figures/forth.q-1.png) ![](./figures/forth.q-2.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  time.2 by pain
    ## W = 634, p-value = 0.4593
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max |
|:--------|:----|:-------|:----|:----|:----|
| no.pain | 31  | 1      | 4   | 0   | 10  |
| pain    | 37  | 1      | 2   | 0   | 14  |

| Group | N   | Median | IQR | Min | Max |
|:------|:----|:-------|:----|:----|:----|
| E     | 41  | 1      | 3   | 0   | 14  |
| U     | 27  | 1      | 2   | 0   | 7   |

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max |
|:-----------|:---------------|:----|:-------|:----|:----|:----|
| no.pain    | E              | 24  | 1      | 3   | 0   | 10  |
| no.pain    | U              | 7   | 1      | 4   | 0   | 7   |
| pain       | E              | 17  | 2      | 2   | 0   | 14  |
| pain       | U              | 20  | 1      | 1   | 0   | 7   |

#### Third quartile (50-74%)

![](./figures/third.q-1.png) ![](./figures/third.q-2.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  time.2 by pain
    ## W = 489.5, p-value = 0.52
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max |
|:--------|:----|:-------|:----|:----|:----|
| no.pain | 30  | 6      | 9   | 1   | 19  |
| pain    | 36  | 7      | 8   | 0   | 31  |

| Group | N   | Median | IQR | Min | Max |
|:------|:----|:-------|:----|:----|:----|
| E     | 40  | 9      | 10  | 0   | 28  |
| U     | 26  | 5      | 7   | 0   | 31  |

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max |
|:-----------|:---------------|:----|:-------|:----|:----|:----|
| no.pain    | E              | 23  | 7      | 9   | 1   | 19  |
| no.pain    | U              | 7   | 3      | 9   | 1   | 13  |
| pain       | E              | 17  | 10     | 8   | 0   | 28  |
| pain       | U              | 19  | 5      | 5   | 0   | 31  |

#### Second quartile (25-49%)

![](./figures/second.q-1.png) ![](./figures/second.q-2.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  time.2 by pain
    ## W = 505.5, p-value = 0.4066
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max |
|:--------|:----|:-------|:----|:----|:----|
| no.pain | 31  | 19     | 13  | 1   | 71  |
| pain    | 37  | 25     | 20  | 2   | 54  |

| Group | N   | Median | IQR | Min | Max |
|:------|:----|:-------|:----|:----|:----|
| E     | 41  | 22     | 18  | 1   | 71  |
| U     | 27  | 18     | 16  | 5   | 50  |

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max |
|:-----------|:---------------|:----|:-------|:----|:----|:----|
| no.pain    | E              | 24  | 20     | 16  | 1   | 71  |
| no.pain    | U              | 7   | 18     | 7   | 7   | 50  |
| pain       | E              | 17  | 27     | 18  | 2   | 54  |
| pain       | U              | 20  | 18     | 17  | 5   | 50  |

#### First quartile (0-24%)

![](./figures/first.q-1.png) ![](./figures/first.q-2.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  time.2 by pain
    ## W = 677, p-value = 0.2061
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max |
|:--------|:----|:-------|:----|:----|:----|
| no.pain | 31  | 362    | 103 | 158 | 530 |
| pain    | 37  | 315    | 105 | 152 | 532 |

| Group | N   | Median | IQR | Min | Max |
|:------|:----|:-------|:----|:----|:----|
| E     | 41  | 327    | 102 | 173 | 530 |
| U     | 27  | 298    | 122 | 152 | 532 |

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max |
|:-----------|:---------------|:----|:-------|:----|:----|:----|
| no.pain    | E              | 24  | 363    | 97  | 209 | 530 |
| no.pain    | U              | 7   | 298    | 124 | 158 | 499 |
| pain       | E              | 17  | 318    | 125 | 173 | 481 |
| pain       | U              | 20  | 303    | 114 | 152 | 532 |

#### Time spent at 0 count

![](./figures/zero-1.png) ![](./figures/zero-2.png)

    ## 
    ##  Exact Wilcoxon rank sum test
    ## 
    ## data:  time.2 by pain
    ## W = 492.5, p-value = 0.3223
    ## alternative hypothesis: true mu is not equal to 0

| Group   | N   | Median | IQR | Min | Max  |
|:--------|:----|:-------|:----|:----|:-----|
| no.pain | 31  | 1067   | 116 | 860 | 1252 |
| pain    | 37  | 1094   | 116 | 873 | 1271 |

| Group | N   | Median | IQR | Min | Max  |
|:------|:----|:-------|:----|:----|:-----|
| E     | 41  | 1071   | 94  | 860 | 1260 |
| U     | 27  | 1116   | 120 | 873 | 1271 |

| Group.Pain | Group.Employed | N   | Median | IQR | Min | Max  |
|:-----------|:---------------|:----|:-------|:----|:----|:-----|
| no.pain    | E              | 24  | 1066   | 95  | 860 | 1206 |
| no.pain    | U              | 7   | 1131   | 157 | 916 | 1252 |
| pain       | E              | 17  | 1076   | 140 | 911 | 1260 |
| pain       | U              | 20  | 1106   | 113 | 873 | 1271 |

Session information
-------------------

    ## R version 3.2.2 (2015-08-14)
    ## Platform: x86_64-apple-darwin13.4.0 (64-bit)
    ## Running under: OS X 10.11.1 (El Capitan)
    ## 
    ## locale:
    ## [1] C
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] knitr_1.11            exactRankTests_0.8-28 scales_0.3.0         
    ## [4] ggplot2_1.0.1         lubridate_1.3.3       tidyr_0.3.1          
    ## [7] dplyr_0.4.3          
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.1      magrittr_1.5     MASS_7.3-44      munsell_0.4.2   
    ##  [5] colorspace_1.2-6 R6_2.1.1         highr_0.5.1      stringr_1.0.0   
    ##  [9] plyr_1.8.3       tools_3.2.2      parallel_3.2.2   grid_3.2.2      
    ## [13] gtable_0.1.2     DBI_0.3.1        htmltools_0.2.6  lazyeval_0.1.10 
    ## [17] yaml_2.1.13      assertthat_0.1   digest_0.6.8     reshape2_1.4.1  
    ## [21] formatR_1.2.1    memoise_0.2.1    evaluate_0.8     rmarkdown_0.8.1 
    ## [25] labeling_0.3     stringi_1.0-1    proto_0.3-10
