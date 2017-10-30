htmlLines <- function(lineNo = c(10, 20, 30, 100)){
  con = url("http://biostat.jhsph.edu/~jleek/contact.html")
  htmlCode = readLines(con)
  close(con)
  # lineNo <- c(10, 20, 30, 100)
  
  # for (i in lineNo){
  print("the number of characters are")
  return(nchar(htmlCode[lineNo]))
    
  # }
  
  # return(nchar(htmlCode[lineNo]))
  
}