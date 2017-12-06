# Coursera : Getting And Cleaning Data 
# Course Project 
# Author  : Asier Abreu
# Version : $Id$
#
# This R script performs the following actions :
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Set descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
library(dplyr)
# Input directory is argument to read data function
# Default to current working directory
# global variables 'test','train','features','activity_labels', 'subject' are created
readData <- function(topDir=".") {
  # Sanity checks
  if (!dir.exists(topDir)) {
    stop("input directory ", topDir, " does not exist!")
  } else if(topDir==".") {
    # (default used) check is not empty
    fs <- list.files(path = topDir)
    if (length(fs)==0) stop("input directory ", topDir, " is empty!")
    # check train/test files exist
    if(!file.exists(paste(topDir,"train","y_train.txt")))
      stop("train set does not exist in ", getwd(), " provide valid dir for reading data")
  } 
  root <<-topDir
  # reached here , get the data and make it available in the parent scope (<<)
  # note : we also load here the labels for train and test datasets that will be needed later
  message("reading , this may take a while ...")
  train <<-read.delim(
    file = paste(topDir,"train","X_train.txt",sep = "/"), header=FALSE,sep="",colClasses = numeric(),fill = T)
  test  <<-read.delim(
    file = paste(topDir,"test","X_test.txt",sep = "/"), header=FALSE,sep="", colClasses = numeric(),fill = T)
  # labels 
  l_train <<-read.table(
    file = paste(topDir,"train","y_train.txt",sep = "/"), header=FALSE,sep="",colClasses = numeric(),fill = T)
  l_test  <<-read.table(
    file = paste(topDir,"test","y_test.txt",sep = "/"), header=FALSE,sep="",colClasses = numeric(),fill = T)
  # features
  features<<-read.table(
    file = paste(topDir,"features.txt",sep = "/"), header=FALSE,sep="",colClasses = c(numeric(),character()),fill = T)
  # activity labels
  activity_labels<<-read.table(
    file = paste(topDir,"activity_labels.txt",sep = "/"), header=FALSE,sep="",colClasses = c(numeric(),character()),fill = T)
  # test subject
  subjects_train<<-read.table(
    file = paste(topDir,"train","subject_train.txt",sep = "/"), header=FALSE,sep="",colClasses = numeric(),fill = T)
  subjects_test<<-read.table(
    file = paste(topDir,"test","subject_test.txt",sep = "/"), header=FALSE,sep="",colClasses = numeric(),fill = T)
  }

# Performs STEP1 : Merges the test and train datasets
mergeData <-function() {
  message("merging data ...")
  train_comp <- cbind(l_train,subjects_train,train)
   test_comp <- cbind(l_test,subjects_test,test)
  total <- rbind(train_comp,test_comp)
  return(total)
  }

# Performs STEP2 : Extracts Mean and Standard Deviation for each measurement
# and assigns corresponding names to columns
#
# NOTE : a simple grep seems to work much better that an select() dyplr command
#        to find the columns in features that correspondn to mean and std, 
#        so used grep to find the indices that contain the measuremetns we want 
extractMeasurements <-function(df) {
  message("extracting means and stddev for each measurement ...")
  # First we need the indices of the columns (in features.txt) that correspond to means and stddev
  mean_idx = grep(pattern = "mean", features[,2])
  stdv_idx = grep(pattern = "std", features[,2])
  # Merge and sort the indices
  idx <- sort(c(mean_idx,stdv_idx)) 
  # 1st column in df are activity and second is subjects so add +2 to indexes
  measurements <-df[,(idx+2)]
  labels <-features[idx,2]
  # Assign telling names to columns
  colnames(measurements) <- labels 
  # Now setup the final dataframe :
  # first column corresponds to activity ids from the features dataframe
  # following ones to the mean+stddev for each measurement
  activities<-data.frame(ID=df[,1]) 
  subjects  <-data.frame(SUBJECT=df[,2]) 
  newdf <<-cbind(
    activities,
    subjects,
    measurements
    )
  return(newdf)
  }

# Performs STEP3 : Assign meaningfull names to Activity column
assignActivityNames <-function(df) {
  message("assigning names to data ...")
  # Prepare activity labels for merge
  colnames(activity_labels)<-c("ID","ACTIVITY")
  # Merge 
  newdf<<-merge(activity_labels,df,"ID")
  return(newdf)
  }

# Performs STEP4: Create a tidy dataset 
# Use command concatenation and dplyr functionality (really useful here)
# global variable 'tidy' is created
createTidyData<- function(df) {
  message("creating tidy data ...")
  # Now, 
  # 1. remove the primary key (ID) used for the join ,don't need it anymore
  # 2. group by subject and activity
  # 3. compute means for each subject and activity
  tidy <<- 
    df %>% 
    select(-ID) %>%
    group_by(SUBJECT,ACTIVITY) %>%
    summarise_each(funs(mean))
  }

# Performs STEP5 : Write the tidy data set out
persistTidyData <-function() {
  message("writing tidied data set ...")
  write.table(tidy,file=paste(root,"tidy_dataset.txt",sep = "/"),row.names = FALSE)
  }

# extra sanity check
checkPersistedData <-function() {
  message("validating output data set ...")
  # check tidy file exists
  if (!file.exists(paste(root,"tidy_dataset.txt",sep = "/"))) stop("apparently some error occurred , no tidy dataset file was created")
  # check data intergrity
  # output data must be of dimensions:
  # ROWS    : (30 (SUBJECT) x 6(ACTIVITY ))
  # COLUMNS : 81 measurments (of mean/stddev)
  output <-read.table(
    file = paste(root,"tidy_dataset.txt",sep = "/"), header=TRUE,sep="")
  if(nrow(output)!=180) stop("output tidy data invalid number of rows : ",nrow(output), " expected (30 (SUBJECT) x 6 (ACTIVITY))")
  if(ncol(output)!=81)  stop("output tidy data invalid number of cols : ",ncol(output), " expected 81")
  message("tidy data set available @ : ",paste(root,"tidy_dataset.txt",sep = "/"))
  }

#######
# MAIN
#######
message("Please type: main(inputDir) inputDir should point to directory with unzipped dataset")
main <-function(inputDir) {
  if(missing(inputDir)) stop("Please,provide input directory (should point to unzipped data dir)")
  readData(inputDir)
  df=mergeData()
  df %>%
  extractMeasurements() %>%
  assignActivityNames() %>%
  createTidyData()
  persistTidyData()
  checkPersistedData()
}
