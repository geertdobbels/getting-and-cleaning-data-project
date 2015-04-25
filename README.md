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

## Recipe

* The raw data will be modified so as to fulfill the requirements 1 to 5, described in the raw data chapter.
* The script used is called run_analysis.R, to be found in the root of the "getting-and-cleaning-data-project" repository on "https://github.com/geertdobbels/getting-and-cleaning-data-project".
* The script itself is extensively commented so as to be as much self explanatory as possible.
* Step 1 : the "train" and "test" datafiles basically come from the same test results. They have been split into 2 separate files, probably for use in a machine learning algorithm where part of the data are used to train the algorithm and another part to test the trained algorithm.  We simply join back both datasets into one with the rbind function.  The resulting dataframe is called "values", the same is done for the activities files (resulting in the dataframe "activ") and the subject files (resulting in the dataframe "subjects".  Care should be taken to maintain the same order of train/test files when using the rbind function, as the order is very important.
* Step 2 : Regular expressions are used to extract only those features whose name contains the strings "mean" or "std".  The resulting data are saved in a dataframe called "msvalues"
* Step 3 : The activity numbers in the dataframe "activ" are replaced by the activity names from the dataframe "activitylabels", the resulting dataframe is added as the first column to the "msvalues" dataframe.  After that, the "subjects" dataframe is added as the first column to this resulting "msvalues" dataframe, both using the cbind function.
* Step 4 : the "msvalues" dataframe receives the feature names as its column names with the setnames function and the "mslabels" dataframe created before.  This is actually done before step 3, because the mslabels dataframe does not contain the labels for the new first and second columns.  The names for those first 2 columns are added afterwards, also with the setnames function.
* Step 5 : mean values are calculated with the aggregate function and grouping by subject and activity.

