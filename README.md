# Resilience.HIVPain

## Bibliometric details:

### Data backup:
Kamerman PR, Wadley AL, Mitchell D. Resilience, physical activity and chronic pain in people living with HIV. **Figshare** DOI: [10.6084/m9.figshare.3497759](//dx.doi.org/10.6084/m9.figshare.3497759)

Peter Kamerman. Resilience.HIVPain: Publication release [Dataset]. **Zenodo** DOI: [10.5281/zenodo.153976](http://doi.org/10.5281/zenodo.153976), 2016

### Article:
Wadley AL, Mitchell D, Kamerman PR. (2016) Resilience does not explain the dissociation between chronic pain and physical activity in South Africans living with HIV. PeerJ 4:e2464 DOI: [10.7717/peerj.2464](https://doi.org/10.7717/peerj.2464).

#### Abstract:
Pain burden is high in people living with HIV (PLWH), but the effect of this pain on functionality is equivocal. Resilience, the ability to cope with adversity, may promote adaptation to pain, so we hypothesised that higher resilience would correlate with less pain-related impairment of activity. We recruited 197 black South African PLWH, 99 with chronic pain (CP) and 98 patients without. We measured pain intensity and interference using the Brief Pain Inventory, and resilience using the Resilience Scale. Participants were generally highly resilient. Greater resilience correlated with better health-related quality of life, but not with pain intensity or interference. We also measured physical activity objectively, by actigraphy, in a subset of patients (37 with chronic pain and 31 without chronic pain), who wore accelerometers for two weeks. There was no difference in duration or intensity of activity between those with and without pain, and activity was not associated with resilience. In this sample, pain was not associated with altered physical activity. Resilience did not explain differences in pain intensity or pain interference but was associated with improved quality of life. Financial stresses and the fear of HIV stigma may have driven patients to conceal pain and to suppress its expected impairment of activity.

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

and miscellaneous .csv files of raw data (with summary tables) not included elsewhere:
- [Demographic data](./demographic-data/) and summary table
- [Worries data](./worries-data/) and summary table
