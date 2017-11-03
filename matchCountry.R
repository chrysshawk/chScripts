# Determining similar countries across files, merging them, and returning defined lowest ranked country
matchCountry <- function(countryNo = 13){
  
  # Get relevant data
  if(!file.exists("./data")){dir.create("./data")}
  file1URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  file2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(file1URL, destfile="./data/FGDP.csv", method="auto")
  download.file(file2URL, destfile="./data/FStats.csv", method="auto")
  
  # Read FGDP variable, defining the header, sep, and skipping the first 5 lines with data 
  # (although there are 10 lines in total, every second is empty)
  FGDP <- read.csv("./data/FGDP.csv", header = FALSE, sep = ",", skip = 5, na.strings = "..")
  # get the first five columns
  dataGDP <- FGDP[, c(1,2,4,5)]
  
  colnames(dataGDP) <- c("CountryCode", "Ranking", "Long.Name", "GDP")
  
  # Converting factors in ranking to integers
  dataGDP$Ranking <- as.integer(as.character(dataGDP$Ranking))
  
  # Making a ranked GDP where only ranked countries are included
  rankedGDP <- dataGDP[!(dataGDP$Ranking == "" | dataGDP$CountryCode == "" | is.na(dataGDP$Ranking)),]
  
  dataStats <- read.csv("./data/FStats.csv")
  
  # Checking how many country codes are the same in both tables (189):
  countryMatch <- length(intersect(rankedGDP$CountryCode, dataStats$CountryCode))
  print(countryMatch)
  
  # merging tables by CountryCode
  mergeGDP <- merge(rankedGDP, dataStats, by.x  ="CountryCode", by.y = "CountryCode", all = TRUE)
  
  # sorting table by descending GDP
  orderedGDP <- mergeGDP[order(-mergeGDP$Ranking),]
  
  # returning item as specified in function
  print(orderedGDP[countryNo, 1:5])
  
}