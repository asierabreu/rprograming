pollutantmean<-function(dir,pollutant,id=1:332) {
    cat("computing mean for",pollutant,"from sensor ids : ",id)
    files<- list.files(path = dir,no.. = TRUE,full.names = TRUE)
    # read pollutant data from file for given file id range
    values <-lapply(files[id],function(f) {
        data<-read.csv(file = f,header = TRUE)
        # curious : operator $ does NOT work inside the function ??
        pollutant_data<-data[[pollutant]]
        validones<-pollutant_data[!is.na(pollutant_data)]
        cat("\n'local' mean for pollutant",pollutant,"in: ",f,"is: ",mean(validones))
        return(mean(validones))
      })
    # mean of means
    return(mean(unlist(values)))
    } 
