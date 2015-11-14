corr<-function(dir,threshold=0) {
  files<- list.files(path = dir,no.. = TRUE,full.names = TRUE)
  correlations <-lapply(files,function(f) {
    data<-read.csv(file = f,header = TRUE)
    cleaned<-data[!(is.na(data["sulfate"])) & !(is.na(data["nitrate"])),]
    if(nrow(cleaned)>threshold) {
      return(cor(cleaned["sulfate"],cleaned["nitrate"]))
    }
  })
  return(unlist(correlations))
}