Load packages and set chunk options
-----------------------------------

``` r
# Load libraries
library(pander)
library(readr)
library(knitr)
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
library(ggplot2)
library(grid)
library(scales)
```

    ## 
    ## Attaching package: 'scales'
    ## 
    ## The following objects are masked from 'package:readr':
    ## 
    ##     col_factor, col_numeric

``` r
library(cowplot)
```

    ## 
    ## Attaching package: 'cowplot'
    ## 
    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     ggsave

``` r
library(party)
```

    ## Loading required package: mvtnorm
    ## Loading required package: modeltools
    ## Loading required package: stats4
    ## Loading required package: strucchange
    ## Loading required package: zoo
    ## 
    ## Attaching package: 'zoo'
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric
    ## 
    ## Loading required package: sandwich

``` r
# Palette
## Quantitative
dark5  <-  c("#0086EF", "#EF6900", "#19A476", "#F3379A", "#666666")

# Set seed
set.seed(123)

# Set knitr chunk options
opts_chunk$set(echo = FALSE,
               warning = FALSE,
               message = FALSE,
               cache = TRUE,
               fig.path = './figures/',
               fig.height = 11.69,
               fig.width = 8.27,
               dev = c('png', 'pdf'),
               cache.extra = rand_seed,
               tidy = TRUE, 
               tidy.opts = list(width.cutoff = 65))
```

Import data
-----------

Inspect and clean data
----------------------

    ## Source: local data frame [6 x 13]
    ## 
    ##   Median.Activity  Pain   Age Female Education   BMI Employment
    ##             (dbl) (int) (int)  (int)     (int) (dbl)      (int)
    ## 1               9     1    34      0         1  26.6          0
    ## 2               6     0    49      1         1  28.3          1
    ## 3               7     0    32      1         1  25.5          1
    ## 4               5     0    51      0         1  23.2          1
    ## 5               5     1    34      1         2  30.1          1
    ## 6               6     1    47      0         2  16.0          0
    ## Variables not shown: RS.Prop.Score (int), EQ5D.vas (int), Worry.Money
    ##   (int), Worry.Family (int), Worry.Food (int), Worry.Health (int)

    ## Source: local data frame [6 x 13]
    ## 
    ##   Median.Activity  Pain   Age Female Education   BMI Employment
    ##             (dbl) (int) (int)  (int)     (int) (dbl)      (int)
    ## 1               8     1    46      1         2  36.4          0
    ## 2               6     1    42      1         2  34.6          1
    ## 3               6     1    45      1         1  28.6          1
    ## 4               4     0    49      1         2  26.1          1
    ## 5               6     0    44      1         2  24.5          1
    ## 6               6     0    44      0         1    NA          1
    ## Variables not shown: RS.Prop.Score (int), EQ5D.vas (int), Worry.Money
    ##   (int), Worry.Family (int), Worry.Food (int), Worry.Health (int)

    ##  Median.Activity       Pain             Age            Female      
    ##  Min.   : 3.000   Min.   :0.0000   Min.   :18.00   Min.   :0.0000  
    ##  1st Qu.: 4.000   1st Qu.:0.0000   1st Qu.:35.00   1st Qu.:0.0000  
    ##  Median : 5.500   Median :1.0000   Median :41.00   Median :1.0000  
    ##  Mean   : 5.846   Mean   :0.5441   Mean   :41.28   Mean   :0.7059  
    ##  3rd Qu.: 7.000   3rd Qu.:1.0000   3rd Qu.:47.25   3rd Qu.:1.0000  
    ##  Max.   :12.000   Max.   :1.0000   Max.   :58.00   Max.   :1.0000  
    ##                                                                    
    ##    Education          BMI         Employment     RS.Prop.Score  
    ##  Min.   :0.000   Min.   :16.0   Min.   :0.0000   Min.   :107.0  
    ##  1st Qu.:1.000   1st Qu.:22.6   1st Qu.:0.0000   1st Qu.:143.0  
    ##  Median :1.500   Median :26.5   Median :1.0000   Median :155.5  
    ##  Mean   :1.545   Mean   :27.0   Mean   :0.5735   Mean   :152.5  
    ##  3rd Qu.:2.000   3rd Qu.:30.9   3rd Qu.:1.0000   3rd Qu.:163.0  
    ##  Max.   :3.000   Max.   :43.2   Max.   :1.0000   Max.   :173.0  
    ##  NA's   :2       NA's   :3                                      
    ##     EQ5D.vas       Worry.Money     Worry.Family     Worry.Food   
    ##  Min.   : 10.00   Min.   :0.000   Min.   :0.000   Min.   :0.000  
    ##  1st Qu.: 50.00   1st Qu.:3.000   1st Qu.:2.000   1st Qu.:0.000  
    ##  Median : 70.00   Median :4.000   Median :4.000   Median :2.000  
    ##  Mean   : 64.12   Mean   :3.397   Mean   :3.074   Mean   :2.147  
    ##  3rd Qu.: 80.00   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:4.000  
    ##  Max.   :100.00   Max.   :4.000   Max.   :4.000   Max.   :4.000  
    ##                                                                  
    ##   Worry.Health  
    ##  Min.   :0.000  
    ##  1st Qu.:2.000  
    ##  Median :2.000  
    ##  Mean   :2.294  
    ##  3rd Qu.:4.000  
    ##  Max.   :4.000  
    ## 

    ## Classes 'tbl_df' and 'data.frame':   68 obs. of  13 variables:
    ##  $ Median.Activity: num  9 6 7 5 5 6 4 4 3 4 ...
    ##  $ Pain           : int  1 0 0 0 1 1 0 0 0 0 ...
    ##  $ Age            : int  34 49 32 51 34 47 53 37 40 40 ...
    ##  $ Female         : int  0 1 1 0 1 0 1 1 1 1 ...
    ##  $ Education      : int  1 1 1 1 2 2 2 2 3 3 ...
    ##  $ BMI            : num  26.6 28.3 25.5 23.2 30.1 16 25 26.8 19.3 22.2 ...
    ##  $ Employment     : int  0 1 1 1 1 0 1 1 1 1 ...
    ##  $ RS.Prop.Score  : int  166 173 151 154 143 167 134 150 166 148 ...
    ##  $ EQ5D.vas       : int  60 100 70 95 70 50 90 60 100 70 ...
    ##  $ Worry.Money    : int  4 2 2 2 2 4 2 4 4 2 ...
    ##  $ Worry.Family   : int  4 4 0 3 3 4 4 0 2 3 ...
    ##  $ Worry.Food     : int  2 3 0 3 2 4 0 2 0 1 ...
    ##  $ Worry.Health   : int  2 2 0 0 3 4 0 3 2 3 ...

    ## Classes 'tbl_df' and 'data.frame':   68 obs. of  13 variables:
    ##  $ Median.Activity: num  9 6 7 5 5 6 4 4 3 4 ...
    ##  $ Pain           : Factor w/ 2 levels "No","Yes": 2 1 1 1 2 2 1 1 1 1 ...
    ##  $ Age            : int  34 49 32 51 34 47 53 37 40 40 ...
    ##  $ Female         : Factor w/ 2 levels "Male","Female": 1 2 2 1 2 1 2 2 2 2 ...
    ##  $ Education      : Factor w/ 4 levels "None","Primary",..: 2 2 2 2 3 3 3 3 4 4 ...
    ##  $ BMI            : num  26.6 28.3 25.5 23.2 30.1 16 25 26.8 19.3 22.2 ...
    ##  $ Employment     : Factor w/ 2 levels "No","Yes": 1 2 2 2 2 1 2 2 2 2 ...
    ##  $ RS.Prop.Score  : int  166 173 151 154 143 167 134 150 166 148 ...
    ##  $ EQ5D.vas       : int  60 100 70 95 70 50 90 60 100 70 ...
    ##  $ Worry.Money    : Ord.factor w/ 5 levels "Not at all"<"Rarely"<..: 5 3 3 3 3 5 3 5 5 3 ...
    ##  $ Worry.Family   : Ord.factor w/ 5 levels "Not at all"<"Rarely"<..: 5 5 1 4 4 5 5 1 3 4 ...
    ##  $ Worry.Food     : Ord.factor w/ 5 levels "Not at all"<"Rarely"<..: 3 4 1 4 3 5 1 3 1 2 ...
    ##  $ Worry.Health   : Ord.factor w/ 5 levels "Not at all"<"Rarely"<..: 3 3 1 1 4 5 1 4 3 4 ...

    ## [1] 68 13

    ## [1] 63 13

Activity
--------

### Random Forest

![](./figures/activity.forest-1.png)

|                             | Trial 1 | Trial 2 | Trial 3 | Trial 4 |
|:----------------------------|:--------|:--------|:--------|:--------|
| Seed                        | 123     | 123     | 345     | 345     |
| Number of trees grown       | 500     | 2000    | 500     | 2000    |
| Number of variables sampled | 3       | 3       | 3       | 3       |

Pain
----

### Random Forest

![](./figures/pain.forest-1.png)

|                             | Trial 1 | Trial 2 | Trial 3 | Trial 4 |
|:----------------------------|:--------|:--------|:--------|:--------|
| Seed                        | 123     | 123     | 345     | 345     |
| Number of trees grown       | 500     | 2000    | 500     | 2000    |
| Number of variables sampled | 3       | 3       | 3       | 3       |
