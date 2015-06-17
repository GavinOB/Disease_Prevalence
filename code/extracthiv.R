Lines <- readLines("data/hsicity-townabington.rtf")
# match <- sub("HIV\\/AIDS Prevalence\\\\\\~", Lines, value = TRUE)
match <- grep(".*HIV\\/AIDS Prevalence\\\\\\~", Lines)
match.result <- Lines[match + 1]
# match.rate <- gsub("\\\\\\~..", "\\1", match.result)
match.rate <- gsub(".*\\\\\\~(...).*", "\\1", match.result)
