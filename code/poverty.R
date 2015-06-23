
poverty <- read.csv(file = "data/ACS_13_5YR_GCT1701.US13PR_with_ann.csv", skip = 1, stringsAsFactors = FALSE)

# Limit records to just Massachusetts towns and selected columns
poverty <- poverty[grep("^1600000US25.*", poverty$Target.Geo.Id), c("Target.Geo.Id", "Geographic.Area.1", "Percent")]
names(poverty) <- c("geo.id", "town", "poverty.rate")

# Remove last word from town names (CDP, town, city)
poverty$town <- sub(poverty$town, pattern = " [[:alpha:]]*$", replacement = "")

# Make percent field numeric
poverty$poverty.rate <- as.numeric(poverty$poverty.rate)
