# GettingAndCleaningData : CourseProject 
- Author      : Asier Abreu
- Script Name : run_analysis.R

### Script Overview :
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Sets descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Checks output data validity

### Detailed Description:
Each step indicated above is implemented by a corresponding function in the script

| Step | Function    | (Short) Description | Link |
| ---- | ----------- | ------------| ----------- | 
| 1    | readData()  | reads in input data and creates global variables required further down | [readData](run_analysis.R#L{17})|
| 2    | mergeData() | combines the test and train datasets including activity ids and test subjects | [mergeData](run_analysis.R#L{57})|
| 3    | extractMeasurements() | extracts only those features which provide mean and StdDev for the given measurement |[extractMeasurements](run_analysis.R#L{71})|
| 4    | assignActivityNames() | assigns relevant names from measurement labels | [assignActivityNames](run_analysis.R#L{97})|
| 5    | createTidyData() | creates a tidy dataset containing the mean of the corresponding measurement grouped by activity and subject |[createTidyData](run_analysis.R#L{108})|
| 6    | persistTidyData() | saves the tidy data set |[persistTidyData](run_analysis.R#L{122})|
| 7    | checkPersistedData() | performs some sanity checks over the tidy dataset |[checkPersistedData](run_analysis.R#L{128})|

*Note:* a Main() function is used to perform the top level sequence (1 to 7). User should use this

### Execution

*Pre-requisite:* you must have downloaded AND unzipped the dataset from :
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

*Assuming you run this in a unix like system ... sorry*

| Step | Description | Tip |
| ---- | ------------|-----|
| 1    | download GitHub repo to local | type: git clone https://github.com/asierabreu/GettingAndCleaningData |
| 2    | Go to repo | type: cd GettingAndCleaningData |  
| 3    | startup R and source script| type: R; type: source("run_analysis.R")  |
| 4    | execute main | type: main(inputDir)  where inputDir points to the unzipped data directory| |
