# Overview
This repository contains the data, the analysis script, and its output for an assessment of phsyical activity data in 68 HIV-positive patients who wore Actical accelerometers for two weeks. The device was worn for 24-hours each day. The first seven days were used to acclimate participants to the device, and only data for the second week (days 8 to 14) was analysed. One participant *(# 176)*, only had 5 days of recordings in the second week. All files related to this analysis are named _'activity.analysis'_ or are stored in subfolders named _'activity.analysis'_. 

The repository also contains the data, analysis script, and its outputs for the activity plot included in the manuscript. All files related to this plot are named _'activity.plot'_ or are stored in subfolders named _'activity.plot'_. 

Code sheets for the analysed data are provided below.

# Code sheets
## activity.data.csv
_Imported by 'activity.analysis.Rmd'_  

24-hour activity data for the last 7 days of Actical wear was imported into MSExcel and saved a single, "long format" file with columns:

- **Pt ID:** participant id code

- **Pain:** yes / no

- **Employed:** employed (E) / unemployed (U)

- **Time:** time of day (hh:mm:ss) in one-minute intervals	

- **Day:** date (dd-mmm-yyyy)	

- **Count:** raw activity count

- **% count:** study participant raw activity count data standardised to the maximum count attained on each actical when worn by an investigator (AW) undertaking maximal activity (stair climbing) (participant raw activity count/investigator maximum activity count *100)

- **pcount.ptmax:** study participant raw activity count data standardised to the maximum activity count recorded by the participant during the secpnd 7-day period (participant raw activity count/maximum participant activity count * 100) 

## time.active.*q.csv
_Imported by 'activity.plot.Rmd'_  

- **id:** participant id code

- **pain:** yes / no

- **employed** employed (E) / unemployed (U)

- **minutes per week** minutes per recording period spent at 0, 1-24, 25-49, 50-74, >75% of maximum activity

- **days of recording:** number of recording days (5 or 7)

- **minutes per day** minutes per week corrected by the number of days in the recording period
