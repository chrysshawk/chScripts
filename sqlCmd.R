sqlCmd <- function() {
     # Init sqldf to be used for SQL commands sent to data frame
     library(sqldf)
     
     # Setting file parameters
     csvURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
     fileDest <- "./data/getData.csv"
     
     # Downloading file, using curl to ensure the https protocol works
     download.file(csvURL, fileDest, method = "curl")
     
     # Reading file into data frame
     acs <- read.csv(fileDest)
     
     sqlSelect <- sqldf("select pwgtp1 from acs where AGEP < 50")
     
     return(str(sqlSelect))
     
     # summary(unique(acs$AGEP)) =
     # summary(sqldf("select distinct AGEP from acs"))
     
     
}