load(file = "data/prevalence.Rdata")
town.rates$town <- toupper(town.rates$town)
write.csv(town.rates, file = "gis/town_rates.csv", row.names = FALSE, na = "")