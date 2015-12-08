# Activity analysis and plot
***

## Overview
This repository contains the [data](./activity.analysis/data/), [analysis script](./activity.analysis/activity.analysis.Rmd), and the associated [markdown document](./activity.analysis/activity.analysis.md) and [figure](./activity.analysis/figures/) outputs for an assessment of physical activity in 68 ambulatory HIV-positive patients who wore Actical accelerometers for two weeks. This group of 68 represents a subset of a larger cohort of 197 individuals taking part in a study on resilience and pain in HIV-positive individuals. Of the 68 participants who wore accelerometers, 37 had chronic (pain on most days for > 3 months) pain, and 31 did not have chronic pain. The device was worn for 24-hours each day. The first seven days were used to acclimate participants to the device, and only data for the second week (days 8 to 14) was analysed. One participant *(# 176)*, only had 5 days of recordings in the second week. The study took place between September 2014 and March 2015, at the HIV Clinic, Charlotte Maxeke Johannesburg Academic Hospital, South Africa. All participants gave written informed consent (Human Ethics Research Committee, University of the Witwatersrand, South Africa -- clearance no: M140538), and no personal identifying information is provided here. All files related to this analysis are located in: [activity.analysis](./activity.analysis). 

The repository also contains the [data](./activity.plot/data/), [analysis script](./activity.plot/activity.plot.Rmd), and the associated  [markdown document](./activity.plot/activity.plot.md) and [figure](./activity.plot/figures/) outputs for the activity plot included in the manuscript. All files related to this plot located in: [activity.plot](./activity.plot). 

Code sheets for the data are provided below.

## Code sheets
### Data analysis
[**activity.data.csv**](./activity.analysis/data/)  
[_Imported by 'activity.analysis.Rmd'_](./activity.analysis/)   

24-hour activity data for the last 7 days of Actical wear was imported into MSExcel and saved a single, "long format" file with columns:

- **Pt ID:** Participant id code

- **Pain:** Do you have pain (yes / no)

- **Employed:** Are you employed [employed (E) / unemployed (U)]

- **Time:** Activity recording time stamp [time of day (hh:mm:ss)] in one-minute intervals	

- **Day:** Activity recording time stamp [date (dd-mmm-yyyy)]	

- **Count:** Raw activity counts binned over 1-minute intervals

- **% count:** Raw activity count data expressed as a percentage of the maximum count attained when the device was worn by an investigator (AW) undertaking maximal activity (stair climbing) (participant raw activity count/investigator maximum activity count * 100)

- **pcount.ptmax:** Raw activity count data expressed as a percentage of the maximum activity count recorded by the participant during the second 7-day period (participant raw activity count/maximum participant activity count * 100) 

### Activity plot
[**time.active.\*q.csv**](./activity.plot/data/) 
[_Imported by 'activity.plot.Rmd'_](./activity.plot/)    

- **id:** Participant id code

- **pain:** Do you have pain (yes / no)

- **employed** Are you employed [employed (E) / unemployed (U)]

- **minutes per week** Minutes per recording period spent at 0, 1-24, 25-49, 50-74, >75% of maximum participant activity (pcount.ptmax)

- **days of recording:** Number of recording days (5 or 7)

- **minutes per day** 'minutes per week' expressed as a function of 'days of recording'
