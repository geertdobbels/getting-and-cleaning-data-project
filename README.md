# Getting and cleaning data course project
## Raw Data

URI For the raw data are: 
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The first URI is a full description of the data, the second URI is a link to a zip file containing those data.

An R script should transform this raw data to obtain the following tidy data set:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## The tidy data set

The tidy data set can be found on the github repository in the same folder as the script. 
The tidy data set was saved as a csv, its name is summarytable.csv
The first line of this csv file contains the column names.

## The code book

Description of the variables in the tidy dataset:

* Subject: he first column is the number of the subject that carried out the activity, 
* Activity: Name in cleartext of the activity that was carried out by the subject from the first column.
* The subsequent colums are the mean values and standard deviation of the different signals, as described in the file "features_info.txt"  For a full description of those features, refer to this file.

