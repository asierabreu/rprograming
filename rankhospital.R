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
         "heart attack" ={z=s[order(as.numeric(s[,11]),na.last = NA),c(2,11)]},
         "heart failure"={z=s[order(as.numeric(s[,17]),na.last = NA),c(2,17)]},
         "pneumonia"    ={z=s[order(as.numeric(s[,23]),na.last = NA),c(2,23)]}
  )
  # now only those  for the given ranking
  hits<-head(z,ranking)
  # re-shape output
  thisone<-hits[which.max(hits[,2]),1]
  message(thisone)
  return(thisone)
} 
