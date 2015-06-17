library(XML) # HTML processing
options(stringsAsFactors = FALSE)

# Base URL
source.url <- "http://www.mass.gov/eohhs/researcher/community-health/masschip/health-status-indicators.html"
base.url <- "http://www.mass.gov"
dest.loc <- "data/"
  
# Read HTML file, extract RTF link name
doc.html <- htmlParse(source.url)
doc.links <- xpathSApply(doc.html, "//a/@href")
rtf.url <- as.character(doc.links[grep(".*hsicity.*rtf", doc.links)])
rtf.base <- basename(rtf.url)
get.list <- paste(base.url, rtf.url, sep = "")

# Download RTF files if they do not already exist locally
for (i in 1:length(get.list)) {
  dest.file <- paste(dest.loc, rtf.base[i], sep = "")
  if (!file.exists(dest.file)) {
    download.file(get.list[i], dest.file)
    }
}