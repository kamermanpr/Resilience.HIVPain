Description
-----------

A series of scatter-plots for the supplementary material provided with the manuscript.

*Note: All activity data are derived from 24-hour accelerometer recordings over a 7-day period (the exception is participant \#176, who only had 5 days of recordings).*

The plots fall into two categories
1. Plots of resilience score (from the Resilience Score questionnaire) against: - Median activity over the recording period;
 - Total time (in minutes) spent in the past week at 0% of maximum activity over the recording period;
 - Total time (in minutes) spent in the past week at 1-24% of maximum activity over the recording period;
 - Total time (in minutes) spent in the past week at 25-49% of maximum activity over the recording period;
 - Total time (in minutes) spent in the past week at 50-74% of maximum activity over the recording period;
 - Total time (in minutes) spent in the past week at \>75% of maximum activity over the recording period.

1.  Plots of median activity over the recording period against:
    -   Pain interference (11-point numerical rating scale, NRS), scored over the last week (recorded at baseline);
    -   Worst pain (11-point NRS), scored over the last week (recorded at baseline);
    -   Least pain (11-point NRS), scored over the last week (recorded at baseline).

Load required packages and set chunk options
--------------------------------------------

``` r
# Load packages
library(knitr)
library(readr)
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
library(scales)
```

    ## 
    ## Attaching package: 'scales'
    ## 
    ## The following objects are masked from 'package:readr':
    ## 
    ##     col_factor, col_numeric

``` r
library(grid)

# knitr chunk options
opts_chunk$set(echo = FALSE,
               warning = FALSE,
               message = FALSE,
               fig.path = './figures/',
               dev = c('png', 'pdf'),
               tidy = TRUE, 
               tidy.opts = list(width.cutoff = 65))
```

Resilience vs Activity dot-plots
--------------------------------

***68 participants, 37 with pain and 31 without pain*** \#\#\# Import data

### Quick look

    ## Source: local data frame [6 x 9]
    ## 
    ##      ID    Pain Median_activity RS_corrected Minutes_at_0_activity
    ##   (int)   (chr)           (dbl)        (int)                 (dbl)
    ## 1     9    pain               9          166               1145.86
    ## 2    10 no.pain               6          173               1038.71
    ## 3    11 no.pain               7          151               1002.14
    ## 4    13 no.pain               5          154               1064.71
    ## 5    21    pain               5          143               1075.86
    ## 6    23    pain               6          167               1064.71
    ## Variables not shown: Minutes_at_q1 (dbl), Minutes_at_q2 (dbl),
    ##   Minutes_at_q3 (dbl), Minutes_at_q4 (dbl)

    ## Source: local data frame [6 x 9]
    ## 
    ##      ID    Pain Median_activity RS_corrected Minutes_at_0_activity
    ##   (int)   (chr)           (dbl)        (int)                 (dbl)
    ## 1   165    pain               8          156               1051.57
    ## 2   167    pain               6          159                981.43
    ## 3   168    pain               6          159                911.29
    ## 4   172 no.pain               4          145                999.14
    ## 5   174 no.pain               6          151               1048.43
    ## 6   176 no.pain               6          137               1167.60
    ## Variables not shown: Minutes_at_q1 (dbl), Minutes_at_q2 (dbl),
    ##   Minutes_at_q3 (dbl), Minutes_at_q4 (dbl)

    ## Observations: 68
    ## Variables: 9
    ## $ ID                    (int) 9, 10, 11, 13, 21, 23, 24, 28, 32, 33, 3...
    ## $ Pain                  (chr) "pain", "no.pain", "no.pain", "no.pain",...
    ## $ Median_activity       (dbl) 9, 6, 7, 5, 5, 6, 4, 4, 3, 4, 10, 5, 12,...
    ## $ RS_corrected          (int) 166, 173, 151, 154, 143, 167, 134, 150, ...
    ## $ Minutes_at_0_activity (dbl) 1145.86, 1038.71, 1002.14, 1064.71, 1075...
    ## $ Minutes_at_q1         (dbl) 276.57, 361.57, 381.14, 365.29, 323.14, ...
    ## $ Minutes_at_q2         (dbl) 16.43, 16.14, 44.57, 8.71, 26.29, 11.71,...
    ## $ Minutes_at_q3         (dbl) 1.00, 16.00, 10.71, 0.86, 13.57, 0.43, 3...
    ## $ Minutes_at_q4         (dbl) 0.14, 7.57, 1.43, 0.43, 1.14, 0.71, 0.29...

    ## Observations: 68
    ## Variables: 8
    ## $ activity (dbl) 9, 6, 7, 5, 5, 6, 4, 4, 3, 4, 10, 5, 12, 4, 8, 5, 5, ...
    ## $ rs.score (int) 166, 173, 151, 154, 143, 167, 134, 150, 166, 148, 172...
    ## $ zero     (dbl) 1145.86, 1038.71, 1002.14, 1064.71, 1075.86, 1064.71,...
    ## $ q1       (dbl) 276.57, 361.57, 381.14, 365.29, 323.14, 362.43, 394.1...
    ## $ q2       (dbl) 16.43, 16.14, 44.57, 8.71, 26.29, 11.71, 25.14, 20.14...
    ## $ q3       (dbl) 1.00, 16.00, 10.71, 0.86, 13.57, 0.43, 3.14, 4.29, 2....
    ## $ q4       (dbl) 0.14, 7.57, 1.43, 0.43, 1.14, 0.71, 0.29, 0.86, 0.86,...
    ## $ pain     (fctr) pain, no.pain, no.pain, no.pain, pain, pain, no.pain...

Create resilience plots
-----------------------

![](./figures/Plot-1.png) ![](./figures/Plot-2.png) ![](./figures/Plot-3.png) ![](./figures/Plot-4.png) ![](./figures/Plot-5.png) ![](./figures/Plot-6.png)

Brief Pain Inventory vs Activity dot-plots
------------------------------------------

***37 participants with pain, only*** \#\#\# Import data

### Quick look

    ## Source: local data frame [6 x 6]
    ## 
    ##      ID  Pain Median_activity BPI_interference Worst_pain Least_pain
    ##   (int) (chr)           (int)            (int)      (int)      (int)
    ## 1     9  Pain               9                6          7          2
    ## 2    21  Pain               5                4          3          0
    ## 3    23  Pain               6                8         10          4
    ## 4    40  Pain              12                7          9          6
    ## 5    67  Pain               6                3          8          0
    ## 6    69  Pain               4                4          4          2

    ## Source: local data frame [6 x 6]
    ## 
    ##      ID  Pain Median_activity BPI_interference Worst_pain Least_pain
    ##   (int) (chr)           (int)            (int)      (int)      (int)
    ## 1   161  Pain               7                4          7          5
    ## 2   163  Pain               4                6          8          4
    ## 3   164  Pain               3                8          9          3
    ## 4   165  Pain               8                6         10          5
    ## 5   167  Pain               6                4          8          2
    ## 6   168  Pain               6                5          8          3

    ## Observations: 37
    ## Variables: 6
    ## $ ID               (int) 9, 21, 23, 40, 67, 69, 71, 72, 73, 74, 75, 76...
    ## $ Pain             (chr) "Pain", "Pain", "Pain", "Pain", "Pain", "Pain...
    ## $ Median_activity  (int) 9, 5, 6, 12, 6, 4, 5, 6, 4, 3, 4, 4, 7, 4, 6,...
    ## $ BPI_interference (int) 6, 4, 8, 7, 3, 4, 5, 8, 3, 4, 3, 2, 4, 9, 6, ...
    ## $ Worst_pain       (int) 7, 3, 10, 9, 8, 4, 10, 8, 7, 7, 5, 8, 8, 10, ...
    ## $ Least_pain       (int) 2, 0, 4, 6, 0, 2, 3, 0, 3, 5, 0, 4, 2, 0, 0, ...

    ## Observations: 37
    ## Variables: 5
    ## $ activity         (int) 9, 5, 6, 12, 6, 4, 5, 6, 4, 3, 4, 4, 7, 4, 6,...
    ## $ bpi_interference (int) 6, 4, 8, 7, 3, 4, 5, 8, 3, 4, 3, 2, 4, 9, 6, ...
    ## $ worst_pain       (int) 7, 3, 10, 9, 8, 4, 10, 8, 7, 7, 5, 8, 8, 10, ...
    ## $ least_pain       (int) 2, 0, 4, 6, 0, 2, 3, 0, 3, 5, 0, 4, 2, 0, 0, ...
    ## $ pain             (fctr) Pain, Pain, Pain, Pain, Pain, Pain, Pain, Pa...

Create bpi plots
----------------

![](./figures/Plot.bpi-1.png) ![](./figures/Plot.bpi-2.png) ![](./figures/Plot.bpi-3.png)

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
    ## [1] grid      stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ## [1] scales_0.3.0  ggplot2_1.0.1 tidyr_0.3.1   dplyr_0.4.3   readr_0.2.2  
    ## [6] knitr_1.11   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.1      magrittr_1.5     MASS_7.3-44      munsell_0.4.2   
    ##  [5] colorspace_1.2-6 R6_2.1.1         stringr_1.0.0    plyr_1.8.3      
    ##  [9] tools_3.2.2      parallel_3.2.2   gtable_0.1.2     DBI_0.3.1       
    ## [13] htmltools_0.2.6  lazyeval_0.1.10  yaml_2.1.13      assertthat_0.1  
    ## [17] digest_0.6.8     reshape2_1.4.1   formatR_1.2.1    evaluate_0.8    
    ## [21] rmarkdown_0.8.1  labeling_0.3     stringi_1.0-1    proto_0.3-10
