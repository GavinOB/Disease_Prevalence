
town.rates <- merge(towns.cancer[, c("town", "breast.cancer.rate", "breast.cancer.number")], towns.hiv[, c("town", "HIV.rate", "HIV.number")], by = "town", all = TRUE)
town.rates <- merge(town.rates, poverty[, c("town", "poverty.rate")], by = "town", all.x = TRUE)

state <- c(134.5, 261.0, 11.4)

# Calculate % difference from state-level prevalence rates
town.deviations <- data.frame(town.rates[, 1], mapply("/", town.rates[, c(2, 4, 6)], state))
names(town.deviations)[1] <- "town"


if (!file.exists("data/prevalence.RData")) {
  save(town.rates, town.deviations, file = "data/prevalence.RData")
}
