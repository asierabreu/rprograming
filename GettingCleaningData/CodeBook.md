# CodeBook
- Author      : Asier Abreu

### Data Source

- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Sub datasets used:

- test/X_test.txt
- train/X_train.txt
- test/y_test.txt
- train/y_train.txt
- activity_labels.txt
- features.txt
- test/subjects_test.txt
- train/subjects_train.txt

### Input Dataset Description :

INPUT= test/X_test.txt or train/X_train.txt

For each record in the INPUT dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

### Transformations :
- mergeData() : Test (test/X_test.txt) and Train (train/X_train.txt) datasets were (column) combined respectively with 
  activity ids (e.g: test/y_test.txt) and the subject ids (test/subject_test.txt) and finaly (row) added into a single dataset.   
- extractMeasurements() : colums containing mean and standard deviation values are then extracted (grep) from that single dataset and appropiate labels are associated using the activity_labels.txt input file
  Finally a combined dataframe (df) is created by composition of the activities , the subject that carried them out on the (mean/std) measurements extracted previously 
- assignActivityNames() : we use the merge functionality now to obtain an updated dataframe containing also some meaningfull values of activity 
- createTidyData() : full usage of dyplr funcionality here. We group data by subject and activity and finally compute the mean of each measurement

### Output Dataset Description :

OUTPUT = tidy_dataset.txt

For each record in the OUTPUT dataset it is provided:
- SUBJECT ID (type: int) (description: identifier of the subject who carried out the experiment.) (range values : 1-30)
- ACTIVITY   (type: character) (description: activity being carried out by subject) (values : List of activities are provide in Appendix 1. )
- MEASUREMENT(type: double)  (description:  A 79-feature vector with feature mean and standard devition measurements) (values: List of features is provide in Appendix 2. )

### Appendix 1. (Activity Values)

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

### Appendix 2. (Measurement Values)

Units : standard gravity units 'g' (m/s^2) 

 [1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
 [5] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"                "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"           
 [9] "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
[13] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
[17] "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"            "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"             
[21] "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
[25] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
[29] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"           "tBodyAccMag-mean()"              "tBodyAccMag-std()"              
[33] "tGravityAccMag-mean()"           "tGravityAccMag-std()"            "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
[37] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
[41] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"               "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"               
[45] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"                "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
[49] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
[53] "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"            "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"      
[57] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
[61] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
[65] "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"          "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"             
[69] "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"          "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
[73] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
[77] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"      "fBodyBodyGyroJerkMag-meanFreq()"
