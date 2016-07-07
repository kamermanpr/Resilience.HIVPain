Bootstrap analyses
================
Peter Kamerman and Antonia Wadley
7 July 2016

-   [Session setup](#session-setup)
-   [Load data](#load-data)
-   [Quick look](#quick-look)
-   [Process data](#process-data)
-   [Spearman correlation](#spearman-correlation)
    -   [Spearman bootstrapping and permutation function](#spearman-bootstrapping-and-permutation-function)
    -   [Analysis](#analysis)
        -   [WHOLE COHORT](#whole-cohort)
            -   [EQ5D VAS vs resilience](#eq5d-vas-vs-resilience)
        -   [PAIN COHORT ONLY](#pain-cohort-only)
            -   [Worst pain vs resilience](#worst-pain-vs-resilience)
            -   [Least pain vs resilience](#least-pain-vs-resilience)
            -   [Nadir CD4 vs resilience](#nadir-cd4-vs-resilience)
            -   [BPI inteference vs resilience](#bpi-inteference-vs-resilience)
            -   [BPI inteference vs worst pain](#bpi-inteference-vs-worst-pain)
            -   [EQ5D VAS vs worst pain](#eq5d-vas-vs-worst-pain)
            -   [EQ5D mobility vs BPI walking](#eq5d-mobility-vs-bpi-walking)
        -   [ACTIGRAPHY COHORT](#actigraphy-cohort)
            -   [Median daily activity vs resilience](#median-daily-activity-vs-resilience)
            -   [Minutes active per day vs resilience](#minutes-active-per-day-vs-resilience)
            -   [Time spent at 0% of maximum activity vs resilience](#time-spent-at-0-of-maximum-activity-vs-resilience)
            -   [Time spent in the first quartile of maximum activity vs resilience](#time-spent-in-the-first-quartile-of-maximum-activity-vs-resilience)
            -   [Time spent in the second quartile of maximum activity vs resilience](#time-spent-in-the-second-quartile-of-maximum-activity-vs-resilience)
            -   [Time spent in the third quartile of maximum activity vs resilience](#time-spent-in-the-third-quartile-of-maximum-activity-vs-resilience)
            -   [Time spent in the fourth quartile of maximum activity vs resilience](#time-spent-in-the-fourth-quartile-of-maximum-activity-vs-resilience)
        -   [ACTIGRAPHY COHORT](#actigraphy-cohort-1)
            -   [BPI walking vs median daily activity](#bpi-walking-vs-median-daily-activity)
            -   [BPI walking vs minutes active per day](#bpi-walking-vs-minutes-active-per-day)
            -   [EQ5D mobility vs median daily activity](#eq5d-mobility-vs-median-daily-activity)
            -   [EQ5D mobility vs minutes active per day](#eq5d-mobility-vs-minutes-active-per-day)
            -   [Worst pain vs median daily activity](#worst-pain-vs-median-daily-activity)
            -   [Least pain vs median daily activity](#least-pain-vs-median-daily-activity)
-   [Wilcoxon rank sum test](#wilcoxon-rank-sum-test)
    -   [Wilcoxon bootstrapping and permutation function](#wilcoxon-bootstrapping-and-permutation-function)
    -   [Analysis](#analysis-1)
        -   [ACTIGRAPHY](#actigraphy)
            -   [Minutes active per day vs pain/no pain](#minutes-active-per-day-vs-painno-pain)
            -   [Median daily active vs pain/no pain](#median-daily-active-vs-painno-pain)
            -   [Time spent at 0% maximum activity vs pain/no pain](#time-spent-at-0-maximum-activity-vs-painno-pain)
            -   [Time spent in first quartile of maximum activity vs pain/no pain](#time-spent-in-first-quartile-of-maximum-activity-vs-painno-pain)
            -   [Time spent in second quartile of maximum activity vs pain/no pain](#time-spent-in-second-quartile-of-maximum-activity-vs-painno-pain)
            -   [Time spent in third quartile of maximum activity vs pain/no pain](#time-spent-in-third-quartile-of-maximum-activity-vs-painno-pain)
            -   [Time spent in fourth quartile of maximum activity vs pain/no pain](#time-spent-in-fourth-quartile-of-maximum-activity-vs-painno-pain)
-   [Session information](#session-information)

**Last updated: July 07, 2016**

------------------------------------------------------------------------

Session setup
=============

``` r
# Load packages
library(svglite)
library(readr)
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.2.5

``` r
library(tidyr)
```

    ## Warning: package 'tidyr' was built under R version 3.2.5

``` r
library(knitr)
```

    ## Warning: package 'knitr' was built under R version 3.2.5

``` r
# set seed
set.seed(1234)

# knitr chunk options
opts_chunk$set(echo = TRUE,
               warning = FALSE,
               message = FALSE,
               cache = TRUE,
               cache.extra = rand_seed,
               fig.path = './figures/',
               fig.width = 7,
               fig.height = 7,
               dev = c('png', 'svg'),
               tidy = FALSE)
```

Load data
=========

``` r
data <- read_csv('./data/data.csv')
data_activity <- read_csv('./data/activity-data.csv')
```

Quick look
==========

``` r
############################################################
#                                                          #
#                           Data                           #
#                                                          #
############################################################
dim(data)
```

    ## [1] 197  11

``` r
names(data)
```

    ##  [1] "id"            "pain"          "actigraphy"    "resilience"   
    ##  [5] "wpi"           "lpi"           "nadir_cd4"     "bpi_i"        
    ##  [9] "eq5d_vas"      "eq5d_mobility" "bpi_walking"

``` r
head(data)
```

    ## Source: local data frame [6 x 11]
    ## 
    ##      id  pain actigraphy resilience   wpi   lpi nadir_cd4 bpi_i eq5d_vas
    ##   <int> <chr>      <chr>      <int> <int> <int>     <int> <int>    <int>
    ## 1     1  Pain         No        151     8     3         9     2       90
    ## 2     2  Pain         No        125     6     4       119     5       60
    ## 3     3  Pain         No        162     9     5        22     6       90
    ## 4     4  Pain         No        136    10     3        63     5       50
    ## 5     5  Pain         No        170     7     4       339     7       80
    ## 6     6  Pain         No         76     5     2        NA     4       30
    ## Variables not shown: eq5d_mobility <chr>, bpi_walking <int>.

``` r
tail(data)
```

    ## Source: local data frame [6 x 11]
    ## 
    ##      id  pain actigraphy resilience   wpi   lpi nadir_cd4 bpi_i eq5d_vas
    ##   <int> <chr>      <chr>      <int> <int> <int>     <int> <int>    <int>
    ## 1   193  Pain         No        157     9     0       278     1       80
    ## 2   194  Pain         No        141     5     1        35     1       70
    ## 3   195  Pain         No        116     8     6       122     6       30
    ## 4   196  Pain         No        153     5     1       213     7       50
    ## 5   197  Pain         No        151     4     2       166     2       80
    ## 6   198  Pain         No        149     5     2       319     1       60
    ## Variables not shown: eq5d_mobility <chr>, bpi_walking <int>.

``` r
glimpse(data)
```

    ## Observations: 197
    ## Variables: 11
    ## $ id            (int) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 1...
    ## $ pain          (chr) "Pain", "Pain", "Pain", "Pain", "Pain", "Pain", ...
    ## $ actigraphy    (chr) "No", "No", "No", "No", "No", "No", "No", "No", ...
    ## $ resilience    (int) 151, 125, 162, 136, 170, 76, 140, 112, 166, 173,...
    ## $ wpi           (int) 8, 6, 9, 10, 7, 5, 9, 10, 7, NA, NA, NA, NA, NA,...
    ## $ lpi           (int) 3, 4, 5, 3, 4, 2, 2, 9, 2, NA, NA, NA, NA, NA, N...
    ## $ nadir_cd4     (int) 9, 119, 22, 63, 339, NA, 20, NA, 46, 127, 21, 21...
    ## $ bpi_i         (int) 2, 5, 6, 5, 7, 4, 7, 6, 6, NA, NA, NA, NA, NA, N...
    ## $ eq5d_vas      (int) 90, 60, 90, 50, 80, 30, 20, 40, 60, 100, 70, 40,...
    ## $ eq5d_mobility (chr) "no_problems", "some_problems", "no_problems", "...
    ## $ bpi_walking   (int) 0, 8, 6, 1, 8, 0, 8, 6, 5, NA, NA, NA, NA, NA, N...

``` r
# summary(data)

############################################################
#                                                          #
#                      Activity data                       #
#                                                          #
############################################################
dim(data_activity)
```

    ## [1] 68  9

``` r
names(data_activity)
```

    ## [1] "id"              "pain"            "median_activity" "active_min"     
    ## [5] "min_q0"          "min_q1"          "min_q2"          "min_q3"         
    ## [9] "min_q4"

``` r
head(data_activity)
```

    ## Source: local data frame [6 x 9]
    ## 
    ##      id    pain median_activity active_min  min_q0 min_q1 min_q2 min_q3
    ##   <int>   <chr>           <dbl>      <dbl>   <dbl>  <dbl>  <dbl>  <dbl>
    ## 1     9    pain               9        235 1145.86 276.57  16.43   1.00
    ## 2    10 no.pain               6        140 1038.71 361.57  16.14  16.00
    ## 3    11 no.pain               7        155 1002.14 381.14  44.57  10.71
    ## 4    13 no.pain               5        270 1064.71 365.29   8.71   0.86
    ## 5    21    pain               5        140 1075.86 323.14  26.29  13.57
    ## 6    23    pain               6        250 1064.71 362.43  11.71   0.43
    ## Variables not shown: min_q4 <dbl>.

``` r
tail(data_activity)
```

    ## Source: local data frame [6 x 9]
    ## 
    ##      id    pain median_activity active_min  min_q0 min_q1 min_q2 min_q3
    ##   <int>   <chr>           <dbl>      <dbl>   <dbl>  <dbl>  <dbl>  <dbl>
    ## 1   165    pain               8        110 1051.57 347.00  29.57   9.00
    ## 2   167    pain               6        175  981.43 399.14  37.29  14.29
    ## 3   168    pain               6        135  911.29 481.43  31.57  12.29
    ## 4   172 no.pain               4        110  999.14 414.71  14.43   9.43
    ## 5   174 no.pain               6         90 1048.43 365.71  20.57   3.71
    ## 6   176 no.pain               6         65 1167.60 246.00  11.20   9.40
    ## Variables not shown: min_q4 <dbl>.

``` r
glimpse(data_activity)
```

    ## Observations: 68
    ## Variables: 9
    ## $ id              (int) 9, 10, 11, 13, 21, 23, 24, 28, 32, 33, 37, 38,...
    ## $ pain            (chr) "pain", "no.pain", "no.pain", "no.pain", "pain...
    ## $ median_activity (dbl) 9, 6, 7, 5, 5, 6, 4, 4, 3, 4, 10, 5, 12, 4, 8,...
    ## $ active_min      (dbl) 235.0, 140.0, 155.0, 270.0, 140.0, 250.0, 210....
    ## $ min_q0          (dbl) 1145.86, 1038.71, 1002.14, 1064.71, 1075.86, 1...
    ## $ min_q1          (dbl) 276.57, 361.57, 381.14, 365.29, 323.14, 362.43...
    ## $ min_q2          (dbl) 16.43, 16.14, 44.57, 8.71, 26.29, 11.71, 25.14...
    ## $ min_q3          (dbl) 1.00, 16.00, 10.71, 0.86, 13.57, 0.43, 3.14, 4...
    ## $ min_q4          (dbl) 0.14, 7.57, 1.43, 0.43, 1.14, 0.71, 0.29, 0.86...

``` r
# summary(data_activity)
```

Process data
============

``` r
############################################################
#                                                          #
#               Merge data and data_activity               #
#                                                          #
############################################################
data <- data %>%
    left_join(data_activity, by = 'id') %>%
    mutate(pain = pain.x) %>%
    select(-pain.x, -pain.y)

############################################################
#                                                          #
#                      Column formats                      #
#                                                          #
############################################################
# Convert chr values to factors
data_1 <- data %>%
    mutate(pain = factor(pain),
           actigraphy = factor(actigraphy),
           eq5d_vas = eq5d_vas/100)

# Convert eq5d mobility to numeric so that 
# Spearman's correlation doesn't throw a fit
data_1$eq5d_mobility[data_1$eq5d_mobility == 'no_problems'] <- 0 
data_1$eq5d_mobility[data_1$eq5d_mobility == 'some_problems'] <- 1 
data_1$eq5d_mobility <- as.numeric(data_1$eq5d_mobility)

############################################################
#                                                          #
#              Generate subsets for use later              #
#                                                          #
############################################################
# Pain only
data_pain <- data_1 %>%
    filter(pain == 'Pain')
# Activity only
data_activity <- data_1 %>%
    filter(actigraphy == 'Yes')
## Activity + pain
data_act_pain <- data_activity %>%
    filter(pain == 'Pain')
## Activity + no pain
data_act_no.pain <- data_activity %>%
    filter(pain == 'No pain')
```

------------------------------------------------------------------------

Spearman correlation
====================

Spearman bootstrapping and permutation function
-----------------------------------------------

``` r
############################################################
#                                                          #
#  Bootstrap Spearman's correlation with permuted p-value  #
#                                                          #
############################################################

# Create function to generate a bootstrap Spearman Rho
# and to permute a p-value. 

# 10000 iterations for both tests
# Random seed = 1234

# Arguments
## data:    Dataframe containing the data to be analysed.
## var_?:   Name of the two variables to analyse. Use the form: 'name'.

boot_spear <- function(data, var_1, var_2) {
    
    # Set seed
    set.seed(1234)
    
    # Create vector of variable names
    variable_names <- c(var_1, var_2)
    
    # Subset input data according to variable names 
    # and filter out incomplete cases
    
    # Attach required package
    require(dplyr)
    
    data_subset <- data[ , names(data) %in% variable_names] %>%
        filter(complete.cases(.)) %>%
        select_(var_1, var_2) # use standard evaluation
    
    # Check the columns are correct
    if(var_1 %in% names(data_pain) != TRUE |
       var_2 %in% names(data_pain) != TRUE) {
               warning('Column names of subsetted data DO NOT match the variable names provided in \'var_1\' and \'var_2\'')
        } 
    
    ###################
    #  Bootstrapping  #
    ###################
    
    # Attach required packages
    require(boot)
    
    # Boot 'statistic' function
    spear <- function(data_subset, i) {
        d <- data_subset[i, ]
        cor(d[[1]], d[[2]],
            method = 'spearman')
    }
    
    # Generate bootstrap sample
    boot_output <- boot(data_subset, 
                        statistic = spear,
                        R = 10000,
                        sim = 'ordinary',
                        stype = 'i')
    
    # Get 95%CI of bootstrapped sample
    boot_95CI <- boot.ci(boot_output, type = 'basic')
    
    # Generate plot of bootstrapped sample 
    boot_plot <- plot(boot_output)

    #########################
    #  p-value permutation  #
    #########################
    
    # Attach required packages
    require(coin)
    
    # Generate permuted p-value
    perm_output <- spearman_test(data_subset[[1]] ~ data_subset[[2]],
                                 distribution = 'approximate',
                                 B = 10000)
    
    ###########################
    #  Bring it all together  #
    ###########################
    
    # Create list of objects generated so far
    output <- list(paste0('INPUT VARIABLES: ', 
                          variable_names[1], ' and ',
                          variable_names[2]),
                   paste0('Passed internal subsetting check'),
                   paste0('ORIGINAL t0 = ', 
                          round(mean(boot_output$t), 7)),
                   boot_plot,
                   boot_95CI,
                   perm_output)
    
    # Print list
    output
}
```

Analysis
--------

### WHOLE COHORT

#### EQ5D VAS vs resilience

``` r
boot_spear(data = data_1, 
           var_1 = 'eq5d_vas', 
           var_2 = 'resilience')
```

![](./figures/eq5dvas_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: eq5d_vas and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.4061236"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original       bias    std. error
    ## t1* 0.4071251 -0.001001455  0.06268919
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   ( 0.2885,  0.5368 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 5.6998, p-value < 2.2e-16
    ## alternative hypothesis: true rho is not equal to 0

### PAIN COHORT ONLY

#### Worst pain vs resilience

``` r
boot_spear(data = data_pain, 
           var_1 = 'wpi', 
           var_2 = 'resilience')
```

![](./figures/wpi_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: wpi and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.1815595"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original       bias    std. error
    ## t1* 0.1825859 -0.001026341  0.09957372
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.0074,  0.3815 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 1.8075, p-value = 0.0673
    ## alternative hypothesis: true rho is not equal to 0

#### Least pain vs resilience

``` r
boot_spear(data = data_pain, 
           var_1 = 'lpi', 
           var_2 = 'resilience')
```

![](./figures/lpi_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: lpi and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0246447"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original      bias    std. error
    ## t1* -0.0274258 0.002781074   0.1115799
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.2476,  0.1899 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.2715, p-value = 0.7924
    ## alternative hypothesis: true rho is not equal to 0

#### Nadir CD4 vs resilience

``` r
boot_spear(data = data_pain, 
           var_1 = 'nadir_cd4', 
           var_2 = 'resilience')
```

![](./figures/cd4_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: nadir_cd4 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.1087378"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original      bias    std. error
    ## t1* -0.1103504 0.001612615   0.0926133
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.2977,  0.0635 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -1.0527, p-value = 0.2861
    ## alternative hypothesis: true rho is not equal to 0

#### BPI inteference vs resilience

``` r
boot_spear(data = data_pain, 
           var_1 = 'bpi_i', 
           var_2 = 'resilience')
```

![](./figures/bpi_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: bpi_i and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.0981818"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original        bias    std. error
    ## t1* 0.09907609 -0.0008943314    0.106106
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.1074,  0.3143 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.9808, p-value = 0.3222
    ## alternative hypothesis: true rho is not equal to 0

#### BPI inteference vs worst pain

``` r
boot_spear(data = data_pain, 
           var_1 = 'bpi_i', 
           var_2 = 'wpi')
```

![](./figures/bpi_wpi-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: bpi_i and wpi"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.4784227"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original       bias    std. error
    ## t1* 0.4811443 -0.002721561  0.08122867
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   ( 0.3334,  0.6493 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 4.7631, p-value < 2.2e-16
    ## alternative hypothesis: true rho is not equal to 0

#### EQ5D VAS vs worst pain

``` r
boot_spear(data = data_pain, 
           var_1 = 'eq5d_vas', 
           var_2 = 'wpi')
```

![](./figures/eq5dv_wpi-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: eq5d_vas and wpi"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.1668369"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original     bias    std. error
    ## t1* -0.1689696 0.00213269  0.09700921
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3649,  0.0154 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -1.6727, p-value = 0.0942
    ## alternative hypothesis: true rho is not equal to 0

#### EQ5D mobility vs BPI walking

``` r
boot_spear(data = data_pain, 
           var_1 = 'eq5d_mobility', 
           var_2 = 'bpi_walking')
```

![](./figures/eq5dm_bpiw-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: eq5d_mobility and bpi_walking"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.5089149"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original       bias    std. error
    ## t1* 0.5111479 -0.002232986  0.07440798
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   ( 0.3762,  0.6672 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 5.0601, p-value < 2.2e-16
    ## alternative hypothesis: true rho is not equal to 0

### ACTIGRAPHY COHORT

*(pain and no pain)*

#### Median daily activity vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'median_activity', 
           var_2 = 'resilience')
```

![](./figures/act_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: median_activity and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.1777006"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original      bias    std. error
    ## t1* -0.1819499 0.004249252   0.1761077
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.5405,  0.1413 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -1.0917, p-value = 0.2749
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'median_activity', 
           var_2 = 'resilience')
```

![](./figures/act_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: median_activity and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.0235017"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original        bias    std. error
    ## t1* 0.02382508 -0.0003233681   0.1908352
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3459,  0.3958 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.1305, p-value = 0.8959
    ## alternative hypothesis: true rho is not equal to 0

#### Minutes active per day vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'active_min', 
           var_2 = 'resilience')
```

![](./figures/act2_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: active_min and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0748491"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original       bias    std. error
    ## t1* -0.07373546 -0.001113649   0.2003868
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.4667,  0.3133 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.44241, p-value = 0.6589
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'active_min', 
           var_2 = 'resilience')
```

![](./figures/act2_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: active_min and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.2661835"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original      bias    std. error
    ## t1* -0.2754721 0.009288629      0.1572
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.6103,  0.0012 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -1.5088, p-value = 0.1373
    ## alternative hypothesis: true rho is not equal to 0

#### Time spent at 0% of maximum activity vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'min_q0', 
           var_2 = 'resilience')
```

![](./figures/q0_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q0 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.016932"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original       bias    std. error
    ## t1* 0.01625728 0.0006747339   0.1853721
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3400,  0.3811 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.097544, p-value = 0.9222
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'min_q0', 
           var_2 = 'resilience')
```

![](./figures/q0_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q0 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.1143231"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original       bias    std. error
    ## t1* 0.1228938 -0.008570663   0.1924735
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.2316,  0.5127 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.67312, p-value = 0.517
    ## alternative hypothesis: true rho is not equal to 0

#### Time spent in the first quartile of maximum activity vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'min_q1', 
           var_2 = 'resilience')
```

![](./figures/q1_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q1 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.1093144"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original       bias    std. error
    ## t1* 0.1127329 -0.003418542   0.1824393
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.2326,  0.4824 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.6764, p-value = 0.5071
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'min_q1', 
           var_2 = 'resilience')
```

![](./figures/q1_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q1 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0840777"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original      bias    std. error
    ## t1* -0.09101003 0.006932365   0.1996987
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.4877,  0.2876 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.49848, p-value = 0.628
    ## alternative hypothesis: true rho is not equal to 0

#### Time spent in the second quartile of maximum activity vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'min_q2', 
           var_2 = 'resilience')
```

![](./figures/q2_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q2 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.4467346"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original    bias    std. error
    ## t1* -0.4567464 0.0100118    0.148041
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.7817, -0.2109 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -2.7405, p-value = 0.0049
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'min_q2', 
           var_2 = 'resilience')
```

![](./figures/q2_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q2 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.2089299"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original     bias    std. error
    ## t1* -0.214329 0.00539911   0.1674899
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.5613,  0.0929 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -1.1739, p-value = 0.2522
    ## alternative hypothesis: true rho is not equal to 0

#### Time spent in the third quartile of maximum activity vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'min_q3', 
           var_2 = 'resilience')
```

![](./figures/q3_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q3 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.3851415"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original     bias    std. error
    ## t1* -0.3970997 0.01195817   0.1476319
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.7251, -0.1546 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -2.3493, p-value = 0.0187
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'min_q3', 
           var_2 = 'resilience')
```

![](./figures/q3_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q3 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.0966143"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##     original       bias    std. error
    ## t1*  0.10409 -0.007475706     0.18268
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.2335,  0.4813 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.56054, p-value = 0.5892
    ## alternative hypothesis: true rho is not equal to 0

#### Time spent in the fourth quartile of maximum activity vs resilience

``` r
############################################################
#                                                          #
#                           Pain                           #
#                                                          #
############################################################
boot_spear(data = data_act_pain, 
           var_1 = 'min_q4', 
           var_2 = 'resilience')
```

![](./figures/q4_res-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q4 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0093271"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##         original        bias    std. error
    ## t1* -0.008587857 -0.0007392439    0.158756
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3258,  0.2888 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.051527, p-value = 0.9604
    ## alternative hypothesis: true rho is not equal to 0

``` r
############################################################
#                                                          #
#                          No Pain                         #
#                                                          #
############################################################
boot_spear(data = data_act_no.pain, 
           var_1 = 'min_q4', 
           var_2 = 'resilience')
```

![](./figures/q4_res-2.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q4 and resilience"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.0002346"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original       bias    std. error
    ## t1* 0.003740777 -0.003506198   0.1946568
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3639,  0.3871 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = 0.020489, p-value = 0.9859
    ## alternative hypothesis: true rho is not equal to 0

### ACTIGRAPHY COHORT

*(pain sub-group only)*

#### BPI walking vs median daily activity

``` r
boot_spear(data = data_act_pain, 
           var_1 = 'bpi_walking', 
           var_2 = 'median_activity')
```

![](./figures/bpi_act-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: bpi_walking and median_activity"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0689718"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original      bias    std. error
    ## t1* -0.07071328 0.001741521   0.1581569
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3852,  0.2291 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.42428, p-value = 0.6763
    ## alternative hypothesis: true rho is not equal to 0

#### BPI walking vs minutes active per day

``` r
boot_spear(data = data_act_pain, 
           var_1 = 'bpi_walking', 
           var_2 = 'active_min')
```

![](./figures/bpi_act2-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: bpi_walking and active_min"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0421981"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original        bias    std. error
    ## t1* -0.04189613 -0.0003020046   0.1572042
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3563,  0.2627 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.25138, p-value = 0.8043
    ## alternative hypothesis: true rho is not equal to 0

#### EQ5D mobility vs median daily activity

``` r
boot_spear(data = data_act_pain, 
           var_1 = 'eq5d_mobility', 
           var_2 = 'median_activity')
```

![](./figures/eq5dm_act-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: eq5d_mobility and median_activity"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.1628075"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original        bias    std. error
    ## t1* -0.1625083 -0.0002992012   0.1591156
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.4797,  0.1455 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.97505, p-value = 0.3426
    ## alternative hypothesis: true rho is not equal to 0

#### EQ5D mobility vs minutes active per day

``` r
boot_spear(data = data_act_pain, 
           var_1 = 'eq5d_mobility', 
           var_2 = 'active_min')
```

![](./figures/eq5dm_act2-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: eq5d_mobility and active_min"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0473983"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original        bias    std. error
    ## t1* -0.04642914 -0.0009691633   0.1686592
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.3774,  0.2792 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.27857, p-value = 0.7949
    ## alternative hypothesis: true rho is not equal to 0

#### Worst pain vs median daily activity

``` r
boot_spear(data = data_act_pain, 
           var_1 = 'wpi', 
           var_2 = 'median_activity')
```

![](./figures/wpi_act-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: wpi and median_activity"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0862248"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original      bias    std. error
    ## t1* -0.08777867 0.001553913   0.1774762
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.4359,  0.2515 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.52667, p-value = 0.6024
    ## alternative hypothesis: true rho is not equal to 0

#### Least pain vs median daily activity

``` r
boot_spear(data = data_act_pain, 
           var_1 = 'lpi', 
           var_2 = 'median_activity')
```

![](./figures/lpi_act-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: lpi and median_activity"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.0582742"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = spear, R = 10000, sim = "ordinary", 
    ##     stype = "i")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##        original        bias    std. error
    ## t1* -0.05812779 -0.0001464537   0.1751644
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.4029,  0.2812 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Spearman Correlation Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]]
    ## Z = -0.34877, p-value = 0.7265
    ## alternative hypothesis: true rho is not equal to 0

------------------------------------------------------------------------

Wilcoxon rank sum test
======================

Wilcoxon bootstrapping and permutation function
-----------------------------------------------

``` r
############################################################
#                                                          #
#      Bootstrap Wilcoxon test with permuted p-value       #
#                                                          #
############################################################

# Create function to generate a bootstrap Wilcoxon Zeta
# and to permute a p-value. 

# 10000 iterations for both tests
# Random seed = 1234

# Arguments
## data:    Dataframe containing the data to be analysed.
## var_?:   Name of the two variables to analyse. Use the form: 'name'.

boot_wilcox <- function(data, var_1, var_2) {
    
    # Set seed
    set.seed(1234)
    
    # Create vector of variable names
    variable_names <- c(var_1, var_2)
    
    # Subset input data according to variable names,  
    # filter out incomplete cases, and order the columns
    
    # Attach required package
    require(dplyr)
    
    data_subset <- data[ , names(data) %in% variable_names] %>%
        filter(complete.cases(.)) %>%
        select_(var_1, var_2) # use standard evaluation
    
    # Check the columns are correct
    if(var_1 %in% names(data_pain) != TRUE |
       var_2 %in% names(data_pain) != TRUE) {
               warning('Column names of subsetted data DO NOT match the variable names provided in \'var_1\' and \'var_2\'')
        } 
    
    ###################
    #  Bootstrapping  #
    ###################
    
    # Attach required packages
    require(boot)
    
    # Boot 'statistic' function
    wilcox <- function(data_subset, i) {
        d <- data_subset[i, ]
        foo <- wilcox_test(d[[1]] ~ d[[2]])
        foo@statistic@teststatistic
    }
    
    # Generate bootstrap sample
    boot_output <- boot(data_subset, 
                        statistic = wilcox,
                        R = 10000,
                        sim = 'ordinary',
                        stype = 'i',
                        parallel = 'multicore')
    
    # Get 95%CI of bootstrapped sample
    boot_95CI <- boot.ci(boot_output, type = 'basic')
    
    # Generate plot of bootstrapped sample 
    boot_plot <- plot(boot_output)

    #########################
    #  p-value permutation  #
    #########################
    
    # Attach required packages
    require(coin)
    
    # Generate permuted p-value
    perm_output <- wilcox_test(data_subset[[1]] ~
                                   data_subset[[2]],
                               distribution = 'approximate',
                               B = 10000)
    
    ###########################
    #  Bring it all together  #
    ###########################
    
    # Create list of objects generated so far
    output <- list(paste0('INPUT VARIABLES: ', 
                          variable_names[1], ' and ',
                          variable_names[2]),
                   paste0('Passed internal subsetting check'),
                   paste0('ORIGINAL t0 = ', 
                          round(mean(boot_output$t), 7)),
                   boot_plot,
                   boot_95CI,
                   perm_output)
    
    # Print list
    output
}
```

Analysis
--------

### ACTIGRAPHY

*(whole cohort)*

#### Minutes active per day vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'active_min',
            var_2 = 'pain')
```

![](./figures/act2_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: active_min and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.2419454"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original     bias    std. error
    ## t1* 0.2648709 -0.0229255   0.9993843
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-1.6905,  2.2298 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = 0.26487, p-value = 0.7907
    ## alternative hypothesis: true mu is not equal to 0

#### Median daily active vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'median_activity',
            var_2 = 'pain')
```

![](./figures/act_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: median_activity and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.890049"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original      bias    std. error
    ## t1* -0.8948321 0.004783128   0.9850422
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-2.8474,  0.9954 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = -0.89483, p-value = 0.3708
    ## alternative hypothesis: true mu is not equal to 0

#### Time spent at 0% maximum activity vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'min_q0',
            var_2 = 'pain')
```

![](./figures/q0_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q0 and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.9827687"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original     bias    std. error
    ## t1* -0.9974096 0.01464088   0.9725804
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-2.9644,  0.8642 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = -0.99741, p-value = 0.3197
    ## alternative hypothesis: true mu is not equal to 0

#### Time spent in first quartile of maximum activity vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'min_q1',
            var_2 = 'pain')
```

![](./figures/q1_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q1 and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 1.259074"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##     original      bias    std. error
    ## t1* 1.274456 -0.01538161   0.9708156
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-0.557,  3.237 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = 1.2745, p-value = 0.2102
    ## alternative hypothesis: true mu is not equal to 0

#### Time spent in second quartile of maximum activity vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'min_q2',
            var_2 = 'pain')
```

![](./figures/q2_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q2 and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.8422107"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original       bias    std. error
    ## t1* -0.8373555 -0.004855233    1.005294
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-2.8327,  1.1228 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = -0.83736, p-value = 0.4042
    ## alternative hypothesis: true mu is not equal to 0

#### Time spent in third quartile of maximum activity vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'min_q3',
            var_2 = 'pain')
```

![](./figures/q3_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q3 and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = -0.6398119"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original     bias    std. error
    ## t1* -0.6504982 0.01068628    1.019546
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-2.6876,  1.3363 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = -0.6505, p-value = 0.5151
    ## alternative hypothesis: true mu is not equal to 0

#### Time spent in fourth quartile of maximum activity vs pain/no pain

``` r
boot_wilcox(data = data_activity,
            var_1 = 'min_q4',
            var_2 = 'pain')
```

![](./figures/q4_pain-1.png)

    ## [[1]]
    ## [1] "INPUT VARIABLES: min_q4 and pain"
    ## 
    ## [[2]]
    ## [1] "Passed internal subsetting check"
    ## 
    ## [[3]]
    ## [1] "ORIGINAL t0 = 0.7326594"
    ## 
    ## [[4]]
    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = data_subset, statistic = wilcox, R = 10000, sim = "ordinary", 
    ##     stype = "i", parallel = "multicore")
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original      bias    std. error
    ## t1* 0.7471495 -0.01449005    1.013899
    ## 
    ## [[5]]
    ## BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
    ## Based on 10000 bootstrap replicates
    ## 
    ## CALL : 
    ## boot.ci(boot.out = boot_output, type = "basic")
    ## 
    ## Intervals : 
    ## Level      Basic         
    ## 95%   (-1.1783,  2.7353 )  
    ## Calculations and Intervals on Original Scale
    ## 
    ## [[6]]
    ## 
    ##  Approximative Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  data_subset[[1]] by data_subset[[2]] (No pain, Pain)
    ## Z = 0.74715, p-value = 0.4526
    ## alternative hypothesis: true mu is not equal to 0

------------------------------------------------------------------------

Session information
===================

``` r
sessionInfo()
```

    ## R version 3.2.4 (2016-03-10)
    ## Platform: x86_64-apple-darwin13.4.0 (64-bit)
    ## Running under: OS X 10.11.5 (El Capitan)
    ## 
    ## locale:
    ## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] coin_1.1-2      survival_2.39-5 boot_1.3-18     knitr_1.13     
    ## [5] tidyr_0.5.1     dplyr_0.5.0     readr_0.2.2     svglite_1.1.0  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.5        magrittr_1.5       MASS_7.3-45       
    ##  [4] splines_3.2.4      lattice_0.20-33    R6_2.1.2          
    ##  [7] multcomp_1.4-5     stringr_1.0.0      tools_3.2.4       
    ## [10] grid_3.2.4         TH.data_1.0-7      DBI_0.4-1         
    ## [13] modeltools_0.2-21  htmltools_0.3.5    lazyeval_0.2.0    
    ## [16] yaml_2.1.13        assertthat_0.1     digest_0.6.9      
    ## [19] tibble_1.0         Matrix_1.2-6       formatR_1.4       
    ## [22] codetools_0.2-14   evaluate_0.9       rmarkdown_0.9.6.14
    ## [25] sandwich_2.3-4     stringi_1.1.1      gdtools_0.0.7     
    ## [28] stats4_3.2.4       mvtnorm_1.0-5      zoo_1.7-13
