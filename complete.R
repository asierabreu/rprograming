complete<-function(dir,id=1:332) {
  files<- list.files(path = dir,no.. = TRUE,full.names = TRUE)
  ids<-numeric()
  nobs<-numeric()
  for (i in id){
    data<-read.csv(file = files[i],header = TRUE)
    n<-nrow(data[!(is.na(data["sulfate"])) & !(is.na(data["nitrate"])),])
    ids<-c(ids,i)
    nobs<-c(nobs,n)
    cat("\ncomplete observations for sensor:",files[i],":",n)
  }
  cat("\n")
  df<-data.frame(ids,nobs)
  return(df)
} 
