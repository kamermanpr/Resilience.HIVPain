Load required packages and set chunk options
--------------------------------------------

Process data
------------

### Import

``` r
data <- read_csv('./data/activity.bpi.eq5d.csv')
```

### Quick look

    ## Source: local data frame [6 x 6]
    ## 
    ##      ID  Pain bpi_walk_interference Median_activity_duration
    ##   (int) (chr)                 (int)                    (dbl)
    ## 1     9  Pain                     5                    235.0
    ## 2    21  Pain                     4                    140.0
    ## 3    23  Pain                     9                    250.0
    ## 4    40  Pain                     2                     92.5
    ## 5    67  Pain                     0                     70.0
    ## 6    69  Pain                     5                    147.5
    ## Variables not shown: Median_activity (int), eq5d_mobility (chr)

    ## Source: local data frame [6 x 6]
    ## 
    ##      ID  Pain bpi_walk_interference Median_activity_duration
    ##   (int) (chr)                 (int)                    (dbl)
    ## 1   161  Pain                     6                       40
    ## 2   163  Pain                     8                      195
    ## 3   164  Pain                     7                       20
    ## 4   165  Pain                     8                      110
    ## 5   167  Pain                     3                      175
    ## 6   168  Pain                    10                      135
    ## Variables not shown: Median_activity (int), eq5d_mobility (chr)

    ## Observations: 37
    ## Variables: 6
    ## $ ID                       (int) 9, 21, 23, 40, 67, 69, 71, 72, 73, 74...
    ## $ Pain                     (chr) "Pain", "Pain", "Pain", "Pain", "Pain...
    ## $ bpi_walk_interference    (int) 5, 4, 9, 2, 0, 5, 0, 7, 0, 4, 5, 5, 2...
    ## $ Median_activity_duration (dbl) 235.0, 140.0, 250.0, 92.5, 70.0, 147....
    ## $ Median_activity          (int) 9, 5, 6, 12, 6, 4, 5, 6, 4, 3, 4, 4, ...
    ## $ eq5d_mobility            (chr) "I have no problems in walking about"...

### Clean

``` r
data.1 <- data %>%
    mutate(ID = factor(ID),
           Pain = factor(Pain),
           eq5d_mobility = factor(eq5d_mobility,
                                  levels = c('I have no problems in walking about', 'I have some problems in walking about'),
                                  labels = c('I have no problems in walking about', 'I have some problems in walking about'),
                                  ordered = TRUE))
```

Analyses
--------

### Correlation between BPI interference with walking and time active

**(median time active daily over the past week)** ![](./figures/BPIInterference.v.ActivityDuration-1.png)<!-- -->

    ## 
    ##  Asymptotic Spearman Correlation Test
    ## 
    ## data:  bpi_walk_interference by Median_activity_duration
    ## Z = -0.25138, p-value = 0.8015
    ## alternative hypothesis: true rho is not equal to 0

### Correlation between BPI interference with walking and intensity of activity

**(median daily intensity of activity over the past week)** ![](./figures/BPIInterference.v.ActivityIntensity-1.png)<!-- -->

    ## 
    ##  Asymptotic Spearman Correlation Test
    ## 
    ## data:  bpi_walk_interference by Median_activity
    ## Z = -0.42428, p-value = 0.6714
    ## alternative hypothesis: true rho is not equal to 0

### EQ5D mobility rating vs time active

**(median time active daily over the past week)** ![](./figures/EQ5DMobility.v.ActivityDuration-1.png)<!-- -->

    ## 
    ##  Asymptotic Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  Median_activity_duration by
    ##   eq5d_mobility (I have no problems in walking about < I have some problems in walking about)
    ## Z = -0.27857, p-value = 0.7806
    ## alternative hypothesis: true mu is not equal to 0

### EQ5D mobility rating vs intensity of activity

**(median daily intensity of activity over the past week)** ![](./figures/EQ5DMobility.v.ActivityIntensity-1.png)<!-- -->

    ## 
    ##  Asymptotic Wilcoxon-Mann-Whitney Test
    ## 
    ## data:  Median_activity by
    ##   eq5d_mobility (I have no problems in walking about < I have some problems in walking about)
    ## Z = -0.97505, p-value = 0.3295
    ## alternative hypothesis: true mu is not equal to 0

Session information
-------------------

    ## R version 3.2.3 (2015-12-10)
    ## Platform: x86_64-apple-darwin13.4.0 (64-bit)
    ## Running under: OS X 10.11.3 (El Capitan)
    ## 
    ## locale:
    ## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
    ## 
    ## attached base packages:
    ## [1] grid      stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ## [1] cowplot_0.6.0   scales_0.4.0    ggplot2_2.1.0   coin_1.1-2     
    ## [5] survival_2.38-3 tidyr_0.4.1     dplyr_0.4.3     readr_0.2.2    
    ## [9] knitr_1.12.3   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.3       formatR_1.2.1     plyr_1.8.3       
    ##  [4] tools_3.2.3       digest_0.6.9      evaluate_0.8     
    ##  [7] gtable_0.2.0      lattice_0.20-33   DBI_0.3.1        
    ## [10] yaml_2.1.13       parallel_3.2.3    mvtnorm_1.0-5    
    ## [13] stringr_1.0.0     stats4_3.2.3      R6_2.1.2         
    ## [16] rmarkdown_0.9.5   multcomp_1.4-4    TH.data_1.0-7    
    ## [19] magrittr_1.5      codetools_0.2-14  htmltools_0.3    
    ## [22] modeltools_0.2-21 splines_3.2.3     MASS_7.3-45      
    ## [25] assertthat_0.1    colorspace_1.2-6  labeling_0.3     
    ## [28] sandwich_2.3-4    stringi_1.0-1     lazyeval_0.1.10  
    ## [31] munsell_0.4.3     zoo_1.7-12
