Lines <- readLines("data/hsicity-townboston.rtf")
# match <- sub("HIV\\/AIDS Prevalence\\\\\\~", Lines, value = TRUE)
match <- grep(".*HIV\\/AIDS Prevalence\\\\\\~", Lines)
match.result <- Lines[match + 1]
# match.rate <- gsub(".*\\\\\\~(.*?\\\\\\cell).*", "\\1", match.result)
match.rate <- gsub(".*\\\\\\~.(.*?)\\\\cell.*", "\\1", match.result)
match.rate <- as.integer(gsub(",", "", match.rate))


