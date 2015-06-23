library(XML) # HTML processing
options(stringsAsFactors = FALSE)

# Set location variables
source.url <- "http://www.mass.gov/eohhs/researcher/community-health/masschip/breast-cancer.html"
base.url <- "http://www.mass.gov"
dest.loc <- "data/"
  
# Read HTML file
doc.html <- htmlParse(source.url)

# Scrape links and town names
doc.links <- xpathSApply(doc.html, "//a[@class='titlelink']/@href")
rtf.url <- as.character(doc.links[grep(".*cancerbreastcity.*rtf", doc.links)])
doc.towns <- xpathSApply(doc.html, "//a[@href[contains(., 'cancerbreastcity')] and @class='titlelink']", xmlValue)
doc.towns <- gsub(" \\(RTF\\)", "", doc.towns)

# Assemble URLs to download documents
rtf.base <- basename(rtf.url)
get.list <- paste(base.url, rtf.url, sep = "")

# Download RTF files if they do not already exist locally
for (i in 1:length(get.list)) {
  dest.file <- paste(dest.loc, rtf.base[i], sep = "")
  if (!file.exists(dest.file)) {
    Sys.sleep(2)
    download.file(get.list[i], dest.file)
    }
}

# Create data frame of filenames and town names
towns.cancer <- data.frame(town = doc.towns, file = rtf.base, cancer.rate = NA)

# Scrape RTF files for prevalence rates and add to "town" data frame
for (i in 1:nrow(towns.cancer)) {
  lines <- readLines(paste(dest.loc, towns.cancer[i, "file"], sep = ""))
  lines <- lines[lines != ""]
  match <- grep(".*Total Breast Cancer Incidence.*", lines)
  match.result <- lines[match]
  match.number <- gsub(".*\\\\\\~.*\\\\\\~(.*?)\\\\cell.*", "\\1", match.result)
  match.rate <-   gsub(".*cell \\\\\\~(.*?)\\\\cell.*", "\\1", match.result)
  match.number <- as.integer(gsub(",", "", match.number))
  match.rate <- as.numeric(gsub(",", "", match.rate))
  towns.cancer[i, "breast.cancer.number"] <- match.number
  towns.cancer[i, "breast.cancer.rate"] <- match.rate
}

# Save data to CSV file
# write.csv(towns.cancer[, c(1, 3)], file = "data/breastcancer_prevalence_rates.csv", row.names = FALSE)
