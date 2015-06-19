library(XML) # HTML processing
options(stringsAsFactors = FALSE)

# Set location variables
source.url <- "http://www.mass.gov/eohhs/researcher/community-health/masschip/health-status-indicators.html"
base.url <- "http://www.mass.gov"
dest.loc <- "data/"
  
# Read HTML file
doc.html <- htmlParse(source.url)

# Scrape links and town names
doc.links <- xpathSApply(doc.html, "//a[@class='titlelink']/@href")
rtf.url <- as.character(doc.links[grep(".*hsicity.*rtf", doc.links)])
doc.towns <- xpathSApply(doc.html, "//a[@href[contains(., 'hsicity')] and @class='titlelink']", xmlValue)
doc.towns <- gsub(" \\(RTF\\)", "", doc.towns)

# Assemble URLs to download documents
rtf.base <- basename(rtf.url)
get.list <- paste(base.url, rtf.url, sep = "")

# Download RTF files if they do not already exist locally
for (i in 1:length(get.list)) {
  dest.file <- paste(dest.loc, rtf.base[i], sep = "")
  if (!file.exists(dest.file)) {
    download.file(get.list[i], dest.file)
    }
}

# Create data frame of filenames and town names
towns <- data.frame(town = doc.towns, file = rtf.base, HIV.rate = NA)

# Scrape RTF files for prevalence rates and add to "town" data frame
for (i in 1:nrow(towns)) {
  lines <- readLines(paste(dest.loc, towns[i, "file"], sep = ""))
  lines <- lines[lines != ""]
  match <- grep(".*HIV\\/AIDS Prevalence.*", lines)
  match.result <- lines[match + 1]
  match.rate <- gsub(".*\\\\\\~.(.*?)\\\\cell.*", "\\1", match.result)
  match.rate <- as.integer(gsub(",", "", match.rate))
  towns[i, "HIV.rate"] <- match.rate
}