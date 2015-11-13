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
    cat("computing mean for : ",object@type,"... from file ids : ",object@id)
    files<- list.files(path = object@dir,no.. = TRUE,full.names = TRUE)
    # read pollutant data from file for given file id range
    values <-lapply(files[object@id],function(f) {
        data<-read.csv(file = f,header = TRUE)
        # curious : operator $ does NOT work inside the function ??
        pollutant_data<-data[[object@type]]
        validones<-pollutant_data[!is.na(pollutant_data)]
        cat("\n'local' mean for pollutant",object@type,"in: ",f,"is: ",mean(validones))
        return(mean(validones))
      })
    # mean of means
    return(mean(unlist(values)))
    } 
)

#
# Compute mean of pollutant sulfate from the first 20 files
#
pol1 <-new("pollutant")
pol1
slot(pol1,"dir")<- "/Users/asierabreu/rprograming/specdata/"
slot(pol1,"type")<- "nitrate"
slot(pol1,"id")<-23
m<-getMean(pol1)
cat("\n'global' mean for pollutant is:",m)