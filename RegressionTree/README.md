# Random forest analysis

## Overview
This repository contains the [data](./data/random.forest.csv), [analysis script](./RegressionTree.Rmd), and the associated  [markdown document](./RegressionTree.md) and [figure](./figures/) outputs for the random forest analysis of activity and pain in 68 ambulatory HIV-positive patients who wore Actical accelerometers for two weeks. This group of 68 represents a subset of a larger cohort of 197 individuals taking part in a study on resilience and pain in HIV-positive individuals. Of the 68 participants who wore accelerometers, 37 had chronic (pain on most days for > 3 months) pain, and 31 did not have chronic pain. The device was worn for 24-hours each day. The first seven days were used to acclimate participants to the device, and only data for the second week (days 8 to 14) was analysed. One participant *(# 176)*, only had 5 days of recordings in the second week. The study took place between September 2014 and March 2015, at the HIV Clinic, Charlotte Maxeke Johannesburg Academic Hospital, South Africa. All participants gave written informed consent (Human Ethics Research Committee, University of the Witwatersrand, South Africa -- clearance no: M140538), and no personal identifying information is provided here. 

Code sheet for the data is provided below.

## Code sheets
[**regression.tree.csv**](./data/random.forest.csv)  
[_Imported by 'regression.tree.Rmd'_](./RegressionTree.Rmd)   

| Label           	| Key                                                                                                                    	|
|-----------------	|------------------------------------------------------------------------------------------------------------------------	|
| Median.Activity 	| Median activity count over the last 7 days of the recording period (5 days for participant #176)                       	|
| Pain            	| Is pain present? (0 = no pain, 1 = pain)                                                                               	|
| Age             	| Age in years                                                                                                           	|
| Female          	| Female sex (0 = no, 1 = yes)                                                                                           	|
| Employment      	| Are you employed? (0 = no, 1 = yes)                                                                                    	|
| Education       	| Highest schooling level completed (0 = none, 1 = primary, 2 = secondary, 3 = tertiary)                                 	|
| BMI             	| Body mass index (kg/m^2^)                                                                                              	|
| RS.Prop.Score   	| Resilience Scale Score (corrected for the number of questions used in the English vs isiZulu versions)                 	|
| EQ5D.vas        	| EQ-5D 3L visual analogue scale score (0 = worst imaginable health state, 100 = best imaginable health state)           	|
| Worry.Money     	| Do you worry about money? (0 = not at all, 1 = rarely, 2 = sometimes, 3 = often, 4 = nearly all the time)              	|
| Worry.Family    	| Do you worry about family concerns? (0 = not at all, 1 = rarely, 2 = sometimes, 3 = often, 4 = nearly all the time)    	|
| Worry.Food      	| Do you worry about having enough food? (0 = not at all, 1 = rarely, 2 = sometimes, 3 = often, 4 = nearly all the time) 	|
| Worry.Health    	| Do you worry about your health? (0 = not at all, 1 = rarely, 2 = sometimes, 3 = often, 4 = nearly all the time)        	|