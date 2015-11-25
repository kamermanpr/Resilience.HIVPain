# Overview
This repository contains the [data](./activity.analysis/data/), [analysis script](./activity.analysis/activity.analysis.Rmd), and its [markdown](./activity.analysis/activity.analysis.md) and [figure](./activity.analysis/figures/) outputs for an assessment of physical activity data in 68 out of 197 ambulatory HIV-positive patients who wore Actical accelerometers for two weeks. Of those 68 participants, 37 had chronic (> 3 months) pain, and 31 did not have chronic pain. The device was worn for 24-hours each day. The first seven days were used to acclimate participants to the device, and only data for the second week (days 8 to 14) was analysed. One participant *(# 176)*, only had 5 days of recordings in the second week. The study took place in between September 2014 and March 2015, at the HIV Clinic, Charlotte Maxeke Johannesburg Academic Hospital, South Africa. All participants had given written informed consent (Human Ethics Research Committee, University of the Witwatersrand, South Africa -- clearance no: M140538), and no personal identifying information is provided here. All files related to this analysis are located in: [activity.analysis](./activity.analysis). 

The repository also contains the [data](./activity.plot/data/), [analysis script](./activity.plot/activity.plot.Rmd), and its [markdown](./activity.plot/activity.plot.md) and [figure](./activity.plot/figures/) outputs for the activity plot included in the manuscript. All files related to this plot located in: [activity.plot](./activity.plot). 

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
