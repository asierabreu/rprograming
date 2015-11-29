best<-function(state,outcome) {
  validOutcomes<-c("heart attack","heart failure","pneumonia")
  hospitals<-read.csv("hospitaldata/outcome-of-care-measures.csv",colClasses = "character")
  if(!(state %in%  hospitals$State)) stop("invalid state")
  if(!(outcome %in% validOutcomes)) stop("invalid outcome")
  selected=hospitals[hospitals$State==state,]
  switch(outcome,
         "heart attack"={name=selected[which.min(selected[,11]),2]},
         "heart failure"={name=selected[which.min(selected[,17]),2]},
         "pneumonia"={name=selected[which.min(selected[,23]),2]}
  )
  message(name)
  return(name)
} 
