
## load the data.table library to use the read.table and write.table functions among others
library(data.table)

## to avoid reading the files each time the program is run, we first check if the tables 
## already exist
if(!exists("valtest")){valtest <- read.table("./test/X_test.txt")}
if(!exists("valtrain")){valtrain <- read.table("./train/X_train.txt")}
## once the test and train values are read, we merge both tables. 
if(!exists("values")){values <- rbind(valtest,valtrain)}

## do the same for the subject and activity files
if(!exists("subjtest")){subjtest <- read.table("./test/subject_test.txt")}
if(!exists("subjtrain")){subjtrain <- read.table("./train/subject_train.txt")}
if(!exists("subjects")){subjects <- rbind(subjtest, subjtrain)}
if(!exists("acttest")){acttest <- read.table("./test/y_test.txt")}
if(!exists("acttrain")){acttrain <- read.table("./train/y_train.txt")}
if(!exists("activ")){activ <- rbind(acttest, acttrain)}

## now get the activity labels and the features
## as.character is done to convert them from factor to character list.
## the same can be obtained using the "stringsAsFactors = FALSE option in the read.table function
if(!exists("activitylabels")){
        activitylabels <- read.table("activity_labels.txt")
        activitylabels[] <- lapply(activitylabels, as.character)
        }
if(!exists("features")){
        features <- read.table("features.txt")
        features[] <- lapply(features, as.character)
        }

## fetch all feature names that have the string "mean" or "std" in them and store them in 
## a dataframe called mslabels
mslabels <- features[grep("mean|std",features$V2),2, drop = F]

## now, from the dataframe with the measurement values select only the column numbers that 
## correspond to features with mean or std in their feature name
msvalues <- values[,as.numeric(features[grep("mean|std",features$V2),1])]

## name the columns of this new dataframe according to the given feature names
setnames(msvalues,names(msvalues),mslabels[,1])

## make a dataframe where the activity numbers from the "activ" dataframe are replaced by the names
## of those activities
activlist <-activitylabels[activ$V1,2,drop=F]
## set the column name of the activity names to "Activity"
setnames(activlist,"V2","Activity")
## and add this dataframe as the first column of the dataframe with measurement values
msvalues <- cbind(activlist,msvalues)

## change the column name of the dataframe "subjects" to "Subject"
setnames(subjects,"V1","Subject")
## and add this dataframe also as the first column of the dataframe with measurement values
msvalues <- cbind(subjects, msvalues)

## make a summary, calculating the mean value of all columns by Subject and by Activity
summarytable <- aggregate(msvalues[,3:81], list(Subject=msvalues$Subject, Activity=msvalues$Activity),mean)
## write this new frame to a text file
write.table(summarytable, file = "summarytable.txt", row.names = FALSE)

