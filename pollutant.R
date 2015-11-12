##
## Pollutant class
##
setClass(
  # Name
  "pollutant",
  
  # Constructor
  slots= c(
    dir = "character", 
    type = "character", 
    id = "numeric"
    ),	
  
  # Initialization
  prototype=list(
    dir = getwd(),
    type= "nitrate",
    id  = 1:10
    )
  )

#
# Method to compute the mean value of given pollutant as extracted from a list of input files
# containing individual measurements of several pollutants at times 
#
setGeneric(
  name="getMean",
  def=function(object) {
    standardGeneric("getMean")
    }
)

setMethod(
  # Name
  f="getMean",
  # Class
  signature="pollutant",
  # The function
  definition=function(object) {
    print(object@type)
    value<-0
    files<- list.files(path = object@dir,no.. = TRUE,full.names = TRUE)
    # Read in those files
    for (f in files) {
      data <- read.csv(f,header = TRUE, comment.char = "")
      value <- sum(data[data$type])
    }
    print((mean(value)))
    return(mean(value))
  }
)