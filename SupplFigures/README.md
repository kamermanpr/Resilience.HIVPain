# Supplementary figures

## Overview
A series of plots for the supplementary material provided with the manuscript _[link to be added when published]_.

**Note:**  

- All activity data are derived from 24-hour accelerometer recordings over a 7-day period (the exception is participant #176, who only had 5 days of recordings)

The plots fall into two categories   

1. Plots of resilience score (from the Resilience Score questionnaire) against:  
*[All plots used data from [resilience.V.endurance.csv](./data/resilience.V.endurance.csv)]*  

    - Median activity over the recording period<br> ([Plot-1.pdf](./figures/Plot-1.pdf), [Plot-1.png](./figures/Plot-1.png));
    - Total time (in minutes) spent in the past week at 0% of maximum activity over the recording period<br> ([Plot-2.pdf](./figures/Plot-2.pdf), [Plot-2.png](./figures/Plot-2.png));
    - Total time (in minutes) spent in the past week at 1-24% of maximum activity over the recording period<br>  ([Plot-3.pdf](./figures/Plot-3.pdf), [Plot-3.png](./figures/Plot-3.png));
    - Total time (in minutes) spent in the past week at 25-49% of maximum activity over the recording period<br>  ([Plot-4.pdf](./figures/Plot-4.pdf), [Plot-4.png](./figures/Plot-4.png));
    - Total time (in minutes) spent in the past week at 50-74% of maximum activity over the recording period<br>   ([Plot-5.pdf](./figures/Plot-5.pdf), [Plot-5.png](./figures/Plot-5.png));
    - Total time (in minutes) spent in the past week at >75% of maximum activity over the recording period<br>  ([Plot-6.pdf](./figures/Plot-6.pdf), [Plot-6.png](./figures/Plot-6.png)). 
    
2. Plots of median activity over the recording period against:  
*[Pain interference, Worst pain, and Least pain plots (the first 3 plots below) used data from [bpi.activity.csv](./data/bpi.activity.csv), all remaining plots used data from [activity.V.predictors.csv](./data/activity.V.predictors.csv)]*  

    - Pain interference (11-point numerical rating scale, NRS), scored over the last week (recorded at baseline)<br> ([Plot.bpi-1.pdf](./figures/Plot.bpi-1.pdf), [Plot.bpi-1.png](./figures/Plot.bpi-1.png));
    - Worst pain (11-point NRS), scored over the last week (recorded at baseline)<br> ([Plot.bpi-2.pdf](./figures/Plot.bpi-2.pdf), [Plot.bpi-2.png](./figures/Plot.bpi-2.png));
    - Least pain (11-point NRS), scored over the last week (recorded at baseline)<br> ([Plot-1.pdf](./figures/Plot-1.pdf), [Plot.bpi-3.png](./figures/Plot.bpi-3.png)); 
    - Presence of pain (yes or no)<br>([Plot.act-1.pdf](./figures/Plot.act-1.pdf), [Plot.act-1.png](./figures/Plot.act-1.png));
    - Age (in years) <br>([Plot.act-2.pdf](./figures/Plot.act-2.pdf), [Plot.act-2.png](./figures/Plot.act-2.png));
    - Sex (male or female) <br>([Plot.act-3.pdf](./figures/Plot.act-3.pdf), [Plot.act-3.png](./figures/Plot.act-3.png));
    - Education (none, completed primary school, completed secondary school, tertiary training) <br>([Plot.act-4.pdf](./figures/Plot.act-4.pdf), [Plot.act-4.png](./figures/Plot.act-4.png));
    - Body mass index (kg/m^2) <br>([Plot.act-5.pdf](./figures/Plot.act-5.pdf), [Plot.act-5.png](./figures/Plot.act-5.png));
    - Employed (yes or no) <br>([Plot.act-6.pdf](./figures/Plot.act-6.pdf), [Plot.act-6.png](./figures/Plot.act-6.png));
    - Resilience (Resilience Scale) <br>([Plot.act-7.pdf](./figures/Plot.act-7.pdf), [Plot.act-7.png](./figures/Plot.act-7.png));
    - Quality of life (EQ5D visual analogue scale) <br>([Plot.act-8.pdf](./figures/Plot.act-8.pdf), [Plot.act-8.png](./figures/Plot.act-8.png));
    - Worries about family, food, health, and money (5-point Likert)<br> ([Plot.act.b-1.pdf](./figures/Plot.act.b-1.pdf), [Plot.act.b-1.png](./figures/Plot.act.b-1.png)).

Code sheets for the three datasets are provided below.

## Code sheets
[*resilience.V.endurance.csv*](./data/resilience.V.endurance.csv)  
_68 participants, 37 with pain and 31 without pain_  

|Key                   |Label |
|:---------------------|:-----|
|ID                    |Participant identification number   |
|Pain                  |Is pain present? (no.pain, pain)    |
|Median_activity       |Median activity count over the last 7 days of the recording period (5 days for participant #176)     |
|RS_corrected          |Resilience Scale Score (corrected for the number of questions used in the English vs isiZulu versions)     |
|Minutes_at_0_activity |Total time (in minutes) spent in the past week at 0% of maximum activity over the recording period    |
|Minutes_at_q1         |Total time (in minutes) spent in the past week at 1-24% of maximum activity over the recording period   |
|Minutes_at_q2         |Total time (in minutes) spent in the past week at 25-49% of maximum activity over the recording period    |
|Minutes_at_q3         |Total time (in minutes) spent in the past week at 50-74% of maximum activity over the recording period    |
|Minutes_at_q4         |Total time (in minutes) spent in the past week at >75% of maximum activity over the recording period   |

[*bpi.activity.csv*](./data/bpi.activity.csv)  
_37 participants with pain, only_  

|Key              |Label |
|:----------------|:-----|
|ID               |Participant identification number    |
|Pain             |Is pain present? (Pain)    |
|Median_activity  |Median activity count over the last 7 days of the recording period (5 days for participant #176)     |
|BPI_interference |Average pain inteference across all domains (11-point NRS), scored over the last week (recorded at baseline)   |
|Worst_pain       |Pain at its worst (11-point NRS), scored over the last week (recorded at baseline)    |
|Least_pain       |Pain at its least (11-point NRS), scored over the last week (recorded at baseline)    |


[*activity.V.predictors.csv*](./data/activity.V.predictors.csv)  
_68 participants, 37 with pain and 31 without pain_    

| Label           	| Key                                                                                                                    	|
|:----------------	|:-----------------------------------------------------------------------------------------------------------------------	|
| ID            	| Participant identification number                                                                             	|
| median_activity 	| Median activity count over the last 7 days of the recording period (5 days for participant #176)                       	|
| pain            	| Is pain present? (No pain, Pain)                                                                               	|
| age             	| Age (years)                                                                                                           	|
| sex          	| Sex (Male, Female)                                                                                           	|
| employment      	| Are you employed? (Employed, Unemployed)                                                                                    	|
| education       	| Highest schooling level completed (No education, Completed grade 7, Completed grade 12, tertiary education)                                 	|
| bmi             	| Body mass index (kg/m^2^)                                                                                              	|
| rs_score   	| Resilience Scale Score (corrected for the number of questions used in the English vs isiZulu versions)                 	|
| eq5d_vas        	| EQ-5D 3L visual analogue scale score (0 = worst imaginable health state, 100 = best imaginable health state)           	|
| money     	| Do you worry about money? (Not at all, Rarely, Sometimes, Often, Nearly all the time)              	|
| family    	| Do you worry about family concerns? (Not at all, Rarely, Sometimes, Often, Nearly all the time))    	|
| food      	| Do you worry about having enough food? (Not at all, Rarely, Sometimes, Often, Nearly all the time) 	|
| health    	| Do you worry about your health? (Not at all, Rarely, Sometimes, Often, Nearly all the time)        	|

***

The files also contain [supplementary analyses](suppl.analysis.md) and plots of the relationship between objective (actigraphy) and subjective (BPI interference with walking, EQ5D mobility) measures of activity in people with pain.

## Plots

- BPI interference with walking score versus time active ([BPIInterference.v.ActivityDuration-1.png](./figures/BPIInterference.v.ActivityDuration-1.png), [BPIInterference.v.ActivityDuration-1.pdf](./figures/BPIInterference.v.ActivityDuration-1.pdf));
- BPI interference with walking score versus intensity of activity ([BPIInterference.v.ActivityIntensity-1.png](./figures/BPIInterference.v.ActivityIntensity-1.png), [BPIInterference.v.ActivityIntensity-1.pdf](./figures/BPIInterference.v.ActivityIntensity-1.pdf));
- EQ5D mobility versus time active ([EQ5DMobility.v.ActivityDuration-1.png](./figures/EQ5DMobility.v.ActivityDuration-1.png), [EQ5DMobility.v.ActivityDuration-1.pdf](./figures/EQ5DMobility.v.ActivityDuration-1.pdf));
- EQ5D mobility subscale versus intensity of activity ([EQ5DMobility.v.ActivityIntensity-1.png](./figures/EQ5DMobility.v.ActivityIntensity-1.png), [EQ5DMobility.v.ActivityIntensity-1.pdf](./figures/EQ5DMobility.v.ActivityIntensity-1.pdf)).

## Code sheet

[*activity.bpi.eq5d.csv*](./data/activity.bpi.eq5d.csv)  
_37 participants with pain, only_  

|Key              |Label |
|:----------------|:-----|
|ID               |Participant identification number    |
|Pain             |Is pain present? (Pain)    |
|bpi\_walk\_interference |Median pain interference with walking (11-point NRS), scored over the last week (recorded at baseline)   |
|Median\_activity\_duration  |Median time active (minutes) over the last 7 days of the recording period (5 days for participant #176)   |
|Median_activity  |Median activity count over the last 7 days of the recording period (5 days for participant #176)     |
|eq5d_mobility    |Rating of mobility on the EQ5D mobility subscale (3-point Likert scale, but only the first two items were used by participants; I have no problems in walking about, I have some problems in walking about) |

