# Data Cleaning
# WK4, Quiz 1

# To clean the workspace: 
# rm(list=ls())

chSplit <- function(){
     # Get relevant data
     if(!file.exists("./data")){dir.create("./data")}
     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
     download.file(fileURL, destfile="./data/acsWk4.csv", method="auto")
     dfACS <- read.csv(file = "./data/acsWk4.csv")
     
     # Applying strsplit on the names of the df, splitting on "wgtp"
     acsSplit <- strsplit(names(dfACS), split = "wgtp")
     
     # Returning the value of the 123th element of the resulting list
     acsSplit[[123]] ## equals [1] ""   "15"
     
}

# WK4, Quiz 2 & Quiz 3
chAvgCount <- function(){
     # Get relevant data
     if(!file.exists("./data")){dir.create("./data")}
     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
     download.file(fileURL, destfile="./data/GDPWk4.csv", method="auto")
     dfGDP <- read.csv(file = "./data/GDPWk4.csv", skip = 3)
     
     # Selecting relevant rows
     countryGDP <- dfGDP[2:191,]
     
     # Removing commas from GDP
     countryGDP$US.dollars. <- gsub(",", "", countryGDP$US.dollars.)
     
     # Calculating mean
     mean(as.numeric(countryGDP$US.dollars.))
     
     # mutating the table with the numeric GDPs for the hell of it
     library(dplyr)
     countryGDP <- mutate(countryGDP, numGDP = as.numeric(countryGDP$US.dollars.))
     
     # Dropping the crap
     countryGDP <- countryGDP[,-c(3, 6:10)]
     summary(countryGDP)
     mean(countryGDP$numGDP)
     
     
     ## QUIZ 3 - Count the countries starting with "United" ##
     ##=====================================================##
     
     # Renaming country label to "countryNames"
     colnames(countryGDP)[3] <- "countryNames"
     colnames(countryGDP)[1] <- "countryCode"
     
     # How many countryNames begin with "United":
     length(grep("^United", countryGDP$countryNames))
     
     
     ## QUIZ 4 - MATCH WITH EDUCATION DATASET ##
     ##=======================================##
     
     # Get additional data
     if(!file.exists("./data")){dir.create("./data")}
     file1URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
     download.file(file1URL, destfile="./data/EDWk4.csv", method="auto")
     dfED <- read.csv(file = "./data/EDWk4.csv")
     
     # Tidying the GDP table
     countryGDP <- countryGDP[, -4]
     
     # Merging data sets
     mCountry <- merge(countryGDP, dfED, by.x = "countryCode", by.y = "CountryCode")
     
     # Determining how many countries with fiscal years ending in june
     strFY <- "[Ff][i][s][c][a][l](.*)[Jj][u][n]"
     fiscalJune <- grep(strFY, mCountry$Special.Notes, value = TRUE)
     length(fiscalJune)
}

# QUANTMOD Quiz 5 -- AMAZON
amazonStock <- function(){
     library(quantmod)
     amzn = getSymbols("AMZN",auto.assign=FALSE)
     sampleTimes = index(amzn)
     
     # Initialising lubdidate for date operations
     library(lubridate)
     
     # Samples for year 2012
     table(year(sampleTimes), year(sampleTimes))
     samples2012 <- sum(year(sampleTimes) == 2012)
     
     # Samples for Mondays 2012
     table(year(sampleTimes), wday(sampleTimes, label = TRUE))
     
     # Mondays are day 2 (weeks start Sundays == 1)
     samplesMon2012 <- sum(year(sampleTimes) == 2012 & wday(sampleTimes) == 2)
     
     
     
     
}