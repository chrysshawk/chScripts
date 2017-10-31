# Function to get and report sum of Fortran data
getForData <- function(){
  forURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
  destFile <- "./data/data.for"
  download.file(forURL, destFile)
  
  # to read columns 1, 2, and 3
  # dat <- read.fwf(destFile, widths = c(-1, 9, -5, 4, 4), skip = 3)
  
  # Reading columns 1 (week) and 4 (Nino3, SST) (- means skip characters)
  dat <- read.fwf(destFile, widths = c(-1, 9, -18, 4), skip = 4, sep=" ", col.names = c("Week", "Nino 3 SST"))
  
  # Finding sum of column 4
  return(sum(dat$Nino.3.SST, na.rm = TRUE))
  
  
}