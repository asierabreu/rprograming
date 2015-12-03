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
rankall<-function(outcome,ranking="best") {
  # Read input data
  validOutcomes<-c("heart attack","heart failure","pneumonia")
  hospitals<<-read.csv("hospitaldata/outcome-of-care-measures.csv",colClasses = "character")
  # Validity check
  if(!(outcome %in% validOutcomes)) stop("invalid outcome")
  # Get the ranks per state
  df<-NULL
  # Loop on unique states (order them alphabetically)
  # Default rankign is "best"
  for (state in sort(unique(hospitals$State))) {
    df<-rbind(df,getRanks(state,ranking,outcome))
  }
  return(df)
} 
#
# Support function to get the specified hospital for given ranking in this state
#
getRanks<-function(state,ranking,outcome) {
  o<-hospitals[hospitals$State==state,]
  s<-hospitals[hospitals$State==state,]
  # Now order first by ranking and the alphabetically within all hospitals in state
  # Create a temporary dataframe only containing the Hospital Name ,State and Ranking
  switch(outcome,
         "heart attack" ={
           s<-s[order(as.numeric(s[,11]),s[,2]),c(2,7,11)]
           colnames(s)<-c("hospital","state","ranking")
           if(ranking=="worst") {
             s<-s[which.max(s[,3]),]
           } else if(ranking=="best") {
             s<-s[which.min(s[,3]),]
           } else {
            s<-s[ranking,]
           }
         },
         "heart failure"={
           s<-s[order(as.numeric(s[,17]),s[,2]),c(2,7,17)]
           colnames(s)<-c("hospital","state","ranking")
           if(ranking=="worst") {
             s<-s[which.max(s[,3]),]
           } else if(ranking=="best") {
             s<-s[which.min(s[,3]),]
           } else {
             s<-s[ranking,]
           }
         },
         "pneumonia"    ={
           s<-s[order(as.numeric(s[,23]),s[,2]),c(2,7,23)]
           colnames(s)<-c("hospital","state","ranking")
           if(ranking=="worst") {
             s<-s[which.max(s[,3]),]
           } else if(ranking=="best") {
             s<-s[which.min(s[,3]),]
           } else {
             s<-s[ranking,]
           }
         }
  )
  if(is.numeric(ranking) && ranking>nrow(o)) {
    s$hospital<-NA
    s$state<-state
  }
  # return a shortened version of the dataframe with only hospital and name
  # AND sort outcome my hospital name alphabetically
  return(s[order(s[,1]),c(1:2)])
}