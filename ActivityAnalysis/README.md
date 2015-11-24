# Overview
This repository contains the data, analysis script, and analysis outputs for analyses performed on activity data from 68 HIV-positive patients who wore Actical accelerometers for two weeks. Acticals were worn for 24-hours each day. Week one was an acclimation week, and the analyses described here only include data for the second week (7 days) only. One participant *(# 176)*, only had 5 days of recordings in the second week. All files related to this analysis are named _'activity.analysis'_ or are stored in subfolders named _'activity.analysis'_. 

In addition, the repository contains the data, analysis script, and analysis outputs for the activity plot included in the manuscript. All files related to this analysis are named _'activity.plot'_ or are stored in subfolders named _'activity.plot'_. 

# Code sheets
## activity.data.csv
_**Imported by 'activity.analysis.Rmd'**_
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
_**Imported by 'activity.plot.Rmd'**_ 



, and the script used to generate the plot used in the manuscript is described in activity.plot.Rmd.
