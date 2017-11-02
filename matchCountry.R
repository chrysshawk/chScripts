# Gross Domestic Product data script
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
  
  # Making a tidyGDP where country ID must be selected
  tidyGDP <- dataGDP[!(dataGDP$CountryCode == ""),]
  
  # Creating a subset of only countries with GDP
  countryGDP <- tidyGDP[1:214,]

  dataStats <- read.csv("./data/FStats.csv")
  
}