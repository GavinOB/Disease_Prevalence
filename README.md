# Disease Prevalance
--------------------
HIV and breast cancer prevalence rates in Massachusetts taken from [MassCHIP](http://www.mass.gov/eohhs/researcher/community-health/masschip/)'s reports on [Health Status Indicators](http://www.mass.gov/eohhs/researcher/community-health/masschip/health-status-indicators.html) and [Breast Cancer](http://www.mass.gov/eohhs/researcher/community-health/masschip/breast-cancer.html).

[Census data source](http://factfinder.census.gov/bkmk/table/1.0/en/ACS/13_5YR/GCT1701.US13PR/0100000US)

This R script downloads each individual town RTF file and scrapes them for prevalence data. Run "code/getfiles.R" to perform all the tasks. The RTF files are saved in the "data/" directory along with "prevalence_rates.csv", which contains all of the scraped HIV data. The project requires the XML library. If necessary, install it by running the command `install.packages("XML")`.

In the future, I hope to extract more health data from the RTF files.
