
town.rates <- merge(towns.cancer[, c("town", "breast.cancer.rate", "breast.cancer.number")], towns.hiv[, c("town", "HIV.rate", "HIV.number")], by = "town", all = TRUE)
town.rates <- merge(town.rates, poverty[, c("town", "poverty.rate")], by = "town", all.x = TRUE)

state.rates <- read.table(header = TRUE, text = "
                   Measure Rate
                   'Breast Cancer' 134.5
                   'HIV' 261.0
                   'Poverty' 11.4
                   ")

if (!file.exists("data/prevalence.RData")) {
  save(town.rates, state.rates, file = "data/prevalence.RData")
}