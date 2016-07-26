# Resilience.HIVPain

## Bibliometric details:
[To be added when published]  

**Article:** Wadley AL, Mitchell D, Kamerman PR. Resilience does not explain the dissociation between chronic pain and 
physical activity in South Africans living with HIV. **PeerJ** _(UNDER REVIEW)_ 

**Data backup:** Kamerman PR, Wadley AL, Mitchell D. Resilience, physical activity and chronic pain in people living with HIV. **Figshare** DOI: [10.6084/m9.figshare.3497759](//dx.doi.org/10.6084/m9.figshare.3497759)

## Overview
We investigated two primary questions: 1) what is the impact of resilience (the ability to overcome and adapt to adversity) on pain intensity and quality of life in HIV-infected individuals with chronic pain, and 2) does chronic HIV-related pain lead to functional impairment. In addressing these two questions we also reported (for the first time) on the use of actigraphy to objectively assess pain-related functional impairment in HIV-related individuals, and we validated two English-language resilience scales in isiZulu. To determine whether any associations we detected were pain-related or merely characteristics of our HIV-infected population as such, we compared the chronic pain cohort with patients recruited from the same patient population, but who did not have chronic pain.

The study was performed on a convenience sample of 197 ambulatory HIV-positive patients (99 with chronic pain and 98 without chronic pain) attending the HIV clinic at Charlotte Maxeke Johannesburg Academic Hospital, South Africa. All patients answered questionniares assessing: their pain (intensity, duration, sites), the effect of pain on function and quality of life, and levels of depression, anxiety, and resilience. A subset of 68 participants (37 with chonic pain and 31 without chronic pain) consented to wearing Actical accelerometers for 24-hours per day for 14 days (only the last 7 days were included in the analysis). This subset of participants were used to provide an objective assessment of physical activity. 

This repository includes data (.csv) and analysis scripts (.Rmd), and the associated markdown (.md) and figure outputs (.pdf/.svg and .png) for the analysis of:

- [Activity levels](./ActivityAnalysis/) in the subset of patients who wore accelerometers for 24-hours per day for 14 days;
- [Factor structure and internal consistency](./FactorAnalysis/) of two English-language resilience questionnaires, which had been translated into isiZulu.
- [Univariate analyses](./univariate-bootstrap/) of resilience, pain and activity data using bootstrapped test statistics and permuted p-values;
- [Multivariate analysis](./RandomForest/) of activity levels and having pain;
- [Moderator analysis](./moderator-analysis/) of the of resilience on the relationship between pain and activity, and pain and quality of life;

scripts for the plotting of:

- [Supplementary plots](./SupplFigures/) for the manuscript (includes supplementary analyses of the relationship between the various objective and subjective measures of activity in people with pain);

and miscellaneous .csv files of raw data not included elsewhere:
- [Demographic data](./demographic-data/)
- [Worries data](./worries-data/)

****
## Supplementary descriptive data
_(raw data can be found at: [demographic data](./demographic-data/))_

#### Table 1. Demographic and resilience characteristics of the whole cohort and subsets

|                                                  | **Whole cohort:<br>Pain**<br>(n = 98) | **Whole cohort:<br>No pain**<br>(n = 99) | **Actigraphy subset:<br>Pain**<br>(n = 37) | **Actigraphy subset:<br>No pain**<br>(n = 31) | **No actigraphy subset:<br>Pain**<br>(n = 61) | **No actigraphy subset:<br>No pain**<br>(n = 68) |
|:-------------------------------------------------|--------------------------------:|-----------------------------------:|-------------------------------------:|----------------------------------------:|----------------------------------------:|-------------------------------------------:|
| **Age** (years),<br>mean (SD)                       | 44 (10)                         | 41 (10)                            | 42 (7)                               | 40 (9)                                  | 45 (11)                                 | 41 (10)                                    |
| **Female**,<br>n (%)                                | 64 (65)                         | 77 (78)                            | 25 (68)                              | 24 (77)                                 | 40 (66)                                 | 53 (78)                                    |
| **Education**,<br>n (%)<sup>1</sup>                           |                                 |                                    |                                      |                                         |                                         |                                            |
| _No education_                                   | 23 (23)                         | 6 (6)                              | 7 (19)                               | 0 (0)                                   | 10 (17)                                 | 6 (9)                                      |
| _Primary_                                        | 40 (41)                         | 45 (47)                            | 11 (30)                              | 15 (48)                                 | 35  (58)                                | 30 (44)                                    |
| _Secondary_                                      | 28 (29)                         | 38 (40)                            | 19 (51)                              | 14 (45)                                 | 14 (23)                                 | 25 (37)                                    |
| _Tertiary_                                       | 7 (7)                           | 7 (7)                              | 0 (0)                                | 0 (0)                                   | 2 (3)                                   | 6 (9)                                      |
| **Employment**,<br>n (%)                            |                                 |                                    |                                      |                                         |                                         |                                            |
| _Full time_                                      | 37 (38)                         | 53 (54)                            | 9 (24)                               | 19 (61)                                 | 28 (46)                                 | 34 (50)                                    |
| _Part time/piece work_                           | 17 (17)                         | 14 (14)                            | 9 (24)                               | 4 (13)                                  | 8 (13)                                  | 10 (15)                                    |
| _Unemployed_                                     | 44 (45)                         | 32 (32)                            | 19 (51)                              | 8 (26)                                  | 25 (41)                                 | 24 (35)                                    |
| **Time since diagnosis** (years),<br>median (range) | 6 (1-25)                        | 6 (1-20)                           | 6 (1-25)                             | 8 (1-20)                                | 6 (1-18)                                | 6 (1-19)                                   |
| **Time on ART** (years),<br>median (range)          | 4 (0-24)                        | 4 (0-18)                           | 5 (0-24)                             | 5 (0-11)                                | 3 (0-10)                                | 4 (0-18)                                   |
| **Nadir CD4 T-cell** (cells/ul),<br>median (range)    | 136 (3-775)                     | 140 (1-678)                        | 117 (3-775)                          | 128 (1-500)                             | 165 (4-569)                             | 145 (1-678)                                |
| **Resilience Scale score**,<br> mean (SD)            | 142 (19)                        | 153 (14)                           | 147 (17)                             | 156 (11)                                | 139 (20)                                | 152 (15)                                   |
| **CD-RISC score**,<br>mean (SD)                     | 77 (12)                         | 82 (11)                            | 77 (11)                              | 83 (8)                                  | 77 (13)                                 | 82 (12)                                    |
| **EQ5D VAS score**,<br>median (range) | 50 (0-90) | 80 (30-100) | 50 (10-80) | 80 (50-100) | 50 (0-90) | 80 (30-100) |
_<sup>1</sup>: Education analysed using a chi squared test for trend; missing data in no pain cohorts: 3 in n=99 cohort, 1 from n=68 cohort._
