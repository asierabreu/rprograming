#
# This function 
#
# Inputs:
# 1. (character) outcome : a valid outcome (one of) "heart attack","heart failure","pneumonia"
# 2.   (numeric) raking  : the ranking of a hospital across all states
#
# Outputs:
# A character vector containing the name of the hospital with the nth lowest 30-day death rate for the given outcome
# 
# Usage : example : rankhospital("MD","heart failure",5)
#
rankall<-function(outcome,ranking) {
  # Read input data
  validOutcomes<-c("heart attack","heart failure","pneumonia")
  hospitals<-read.csv("hospitaldata/outcome-of-care-measures.csv",colClasses = "character")
  # Validity check
  if(!(outcome %in% validOutcomes)) stop("invalid outcome")
  # Get the ranks
  df<-data.frame("hospital"=character(),"state"=character())
  values<-lapply(unique(hospitals$State),function(state,ranking) {
    s<-hospitals[hospitals$State==state,]
    switch(outcome,
           "heart attack" ={
             s=s[order(as.numeric(s[,11])),]
             },
           "heart failure"={
             s=s[order(as.numeric(s[,17])),]
             },
           "pneumonia"    ={
             s=s[order(as.numeric(s[,23])),]
             }
    )
    if(ranking>nrow(s)) {
      return(NA)
    } else{
      return(s[ranking,c(2,7)])
    }
  },
  ranking=ranking)
  df<-NULL
  for (i in 1:length(values)) {
    row=c(values[[i]][1],values[[i]][2])
    df<-rbind(df,row)
  }
  colnames(df)<-c("hospital","state")
  return(df)
} 