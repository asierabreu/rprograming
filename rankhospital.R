#
# This function 
#
# Inputs:
# 1. (character) state   : a valid abbreviature for State 
# 2. (character) outcome : a valid outcome (one of) "heart attack","heart failure","pneumonia"
# 3.   (numeric) raking  : the ranking of a hospital in that State
#
# Outputs:
# A character vector containing the name of the hospital with the nth lowest 30-day death rate for the given outcome
# 
# Usage : example : rankhospital("MD","heart failure",5)
#
rankhospital<-function(state,outcome,ranking) {
  # Read input data
  validOutcomes<-c("heart attack","heart failure","pneumonia")
  hospitals<-read.csv("hospitaldata/outcome-of-care-measures.csv",colClasses = "character")
  # Validity check
  if(!(state %in%  hospitals$State)) stop("invalid state")
  if(!(outcome %in% validOutcomes)) stop("invalid outcome")
  # Select hospitals within the given state
  s=hospitals[hospitals$State==state,]
  # Get the ranks
  switch(outcome,
         "heart attack" ={
           z=s[order(as.numeric(s[,11]),s[,2]),c(2,11)]
           },
         "heart failure"={
           z=s[order(as.numeric(s[,17]),s[,2]),c(2,17)]
           },
         "pneumonia"    ={
           z=s[order(as.numeric(s[,23]),s[,2]),c(2,23)]
           }
  )
  # now only that one for the given ranking
  if(ranking=="worst") {
    return(z[which.max(z[,2]),1])
  } else if(ranking=="best") {
    return(z[which.min(z[,2]),1])
  } else {
    return(z[ranking,1])
  }
} 
