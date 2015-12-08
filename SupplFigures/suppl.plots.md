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
library(cowplot)
```

    ## 
    ## Attaching package: 'cowplot'
    ## 
    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     ggsave

``` r
# Load palette
cb8.categorical <- c("#0072B2", "#D55E00", "#009E73", "#F0E442", "#56B4E9", "#E69F00", "#CC79A7", "#999999")

# knitr chunk options
opts_chunk$set(echo = FALSE,
               warning = FALSE,
               message = FALSE,
               fig.path = './figures/',
               fig.width = 11.7,
               fig.height = 8.2,
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
    ## $ pain     (fctr) Pain, No pain, No pain, No pain, Pain, Pain, No pain...

Create resilience plots
-----------------------

![](./figures/Plot-1.png) ![](./figures/Plot-2.png) ![](./figures/Plot-3.png) ![](./figures/Plot-4.png) ![](./figures/Plot-5.png) ![](./figures/Plot-6.png)

Brief Pain Inventory vs activity dot-plots
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

Activity vs predictor scatterplots
----------------------------------

***68 participants with (37) and without (31) pain*** \#\#\# Import data

### Quick look

    ## Source: local data frame [6 x 14]
    ## 
    ##      ID median_activity    pain   age    sex          education   bmi
    ##   (int)           (dbl)   (chr) (int)  (chr)              (chr) (dbl)
    ## 1     9               9    Pain    34   Male  Completed grade 7  26.6
    ## 2    10               6 No pain    49 Female  Completed grade 7  28.3
    ## 3    11               7 No pain    32 Female  Completed grade 7  25.5
    ## 4    13               5 No pain    51   Male  Completed grade 7  23.2
    ## 5    21               5    Pain    34 Female Completed grade 12  30.1
    ## 6    23               6    Pain    47   Male Completed grade 12  16.0
    ## Variables not shown: employed (chr), rs_score (int), eq5d_vas (int), money
    ##   (chr), family (chr), food (chr), health (chr)

    ## Source: local data frame [6 x 14]
    ## 
    ##      ID median_activity    pain   age    sex          education   bmi
    ##   (int)           (dbl)   (chr) (int)  (chr)              (chr) (dbl)
    ## 1   165               8    Pain    46 Female Completed grade 12  36.4
    ## 2   167               6    Pain    42 Female Completed grade 12  34.6
    ## 3   168               6    Pain    45 Female  Completed grade 7  28.6
    ## 4   172               4 No pain    49 Female Completed grade 12  26.1
    ## 5   174               6 No pain    44 Female Completed grade 12  24.5
    ## 6   176               6 No pain    44   Male  Completed grade 7    NA
    ## Variables not shown: employed (chr), rs_score (int), eq5d_vas (int), money
    ##   (chr), family (chr), food (chr), health (chr)

    ## Observations: 68
    ## Variables: 14
    ## $ ID              (int) 9, 10, 11, 13, 21, 23, 24, 28, 32, 33, 37, 38,...
    ## $ median_activity (dbl) 9, 6, 7, 5, 5, 6, 4, 4, 3, 4, 10, 5, 12, 4, 8,...
    ## $ pain            (chr) "Pain", "No pain", "No pain", "No pain", "Pain...
    ## $ age             (int) 34, 49, 32, 51, 34, 47, 53, 37, 40, 40, 32, 58...
    ## $ sex             (chr) "Male", "Female", "Female", "Male", "Female", ...
    ## $ education       (chr) "Completed grade 7", "Completed grade 7", "Com...
    ## $ bmi             (dbl) 26.6, 28.3, 25.5, 23.2, 30.1, 16.0, 25.0, 26.8...
    ## $ employed        (chr) "Unemployed", "Employed", "Employed", "Employe...
    ## $ rs_score        (int) 166, 173, 151, 154, 143, 167, 134, 150, 166, 1...
    ## $ eq5d_vas        (int) 60, 100, 70, 95, 70, 50, 90, 60, 100, 70, 60, ...
    ## $ money           (chr) "Nearly all the time", "Sometimes", "Sometimes...
    ## $ family          (chr) "Nearly all the time", "Nearly all the time", ...
    ## $ food            (chr) "Sometimes", "Often", "Not at all", "Often", "...
    ## $ health          (chr) "Sometimes", "Sometimes", "Not at all", "Not a...

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    272 obs. of  12 variables:
    ##  $ ID             : Factor w/ 68 levels "9","10","11",..: 1 1 1 1 2 2 2 2 3 3 ...
    ##  $ median_activity: num  9 9 9 9 6 6 6 6 7 7 ...
    ##  $ pain           : Factor w/ 2 levels "No pain","Pain": 2 2 2 2 1 1 1 1 1 1 ...
    ##  $ age            : int  34 34 34 34 49 49 49 49 32 32 ...
    ##  $ sex            : Factor w/ 2 levels "Female","Male": 2 2 2 2 1 1 1 1 1 1 ...
    ##  $ education      : Ord.factor w/ 4 levels "No education"<..: 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ bmi            : num  26.6 26.6 26.6 26.6 28.3 28.3 28.3 28.3 25.5 25.5 ...
    ##  $ employed       : Factor w/ 2 levels "Employed","Unemployed": 2 2 2 2 1 1 1 1 1 1 ...
    ##  $ rs_score       : int  166 166 166 166 173 173 173 173 151 151 ...
    ##  $ eq5d_vas       : int  60 60 60 60 100 100 100 100 70 70 ...
    ##  $ worry_about    : Factor w/ 4 levels "money","family",..: 1 2 3 4 1 2 3 4 1 2 ...
    ##  $ rating         : Ord.factor w/ 5 levels "Not at all"<"Rarely"<..: 5 5 3 3 3 5 4 3 3 1 ...

Create bpi plots
----------------

![](./figures/Plot.act-1.png) ![](./figures/Plot.act-2.png) ![](./figures/Plot.act-3.png) ![](./figures/Plot.act-4.png) ![](./figures/Plot.act-5.png) ![](./figures/Plot.act-6.png) ![](./figures/Plot.act-7.png) ![](./figures/Plot.act-8.png)

    ## Source: local data frame [272 x 12]
    ## 
    ##        ID median_activity    pain   age    sex         education   bmi
    ##    (fctr)           (dbl)  (fctr) (int) (fctr)            (fctr) (dbl)
    ## 1       9               9    Pain    34   Male Completed grade 7  26.6
    ## 2       9               9    Pain    34   Male Completed grade 7  26.6
    ## 3       9               9    Pain    34   Male Completed grade 7  26.6
    ## 4       9               9    Pain    34   Male Completed grade 7  26.6
    ## 5      10               6 No pain    49 Female Completed grade 7  28.3
    ## 6      10               6 No pain    49 Female Completed grade 7  28.3
    ## 7      10               6 No pain    49 Female Completed grade 7  28.3
    ## 8      10               6 No pain    49 Female Completed grade 7  28.3
    ## 9      11               7 No pain    32 Female Completed grade 7  25.5
    ## 10     11               7 No pain    32 Female Completed grade 7  25.5
    ## ..    ...             ...     ...   ...    ...               ...   ...
    ## Variables not shown: employed (fctr), rs_score (int), eq5d_vas (int),
    ##   worries_a (fctr), rating (fctr)

![](./figures/Plot.act.b-1.png)

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
    ## [1] cowplot_0.5.0 scales_0.3.0  ggplot2_1.0.1 tidyr_0.3.1   dplyr_0.4.3  
    ## [6] readr_0.2.2   knitr_1.11   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.2      magrittr_1.5     MASS_7.3-45      munsell_0.4.2   
    ##  [5] colorspace_1.2-6 R6_2.1.1         stringr_1.0.0    plyr_1.8.3      
    ##  [9] tools_3.2.2      parallel_3.2.2   gtable_0.1.2     DBI_0.3.1       
    ## [13] htmltools_0.2.6  lazyeval_0.1.10  yaml_2.1.13      assertthat_0.1  
    ## [17] digest_0.6.8     reshape2_1.4.1   formatR_1.2.1    evaluate_0.8    
    ## [21] rmarkdown_0.8.1  labeling_0.3     stringi_1.0-1    proto_0.3-10
