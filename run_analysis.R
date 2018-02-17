# Coursera Excercise -  Getting and Cleaning Data
# Saranga Ram - 02/15/2018

# File run_Analysis.R

# Things To Do -
# Fetch the source data - unzip and store locally
# Merge the training and the test sets to create one data set.
# Extract only the measurements on the mean and standard deviation for each measurement.
# Set descriptive activity names to name the activities in the data set
# Appropriately label the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the 
# -  average of each variable for each activity and each subject.

#set working directory to the location where the UCI HAR Dataset was unzipped
filePath <- paste(getwd(), "/RProjects/GettingAndCleaningData/ProjectData/UCI-HAR-Dataset", sep="")
#setwd(filePath)

# Read in the data from all the  files
features     <- read.table(paste(filePath, '/features.txt', sep=""),header=FALSE) 
activityType <- read.table(paste(filePath, '/activity_labels.txt',sep=""),header=FALSE)
subjectTrain <- read.table(paste(filePath, '/train/subject_train.txt',sep=""),header=FALSE)
xTrain       <- read.table(paste(filePath, '/train/x_train.txt',sep=""),header=FALSE)
yTrain       <- read.table(paste(filePath, '/train/y_train.txt',sep=""),header=FALSE)

# Assign column names to the data tables above
colnames(activityType)  <- c('activity_id','activity_type')
colnames(subjectTrain)  <- "subject_id"
colnames(yTrain)        <- "activity_id" 

#Merge in to yTrain, the activity definitions from activityType
#yTrain<-merge(yTrain, activityType)

# Data pulled in from  xTrain should only include mean|std columns
# For this - Get mean|std column indices using Features and subset with those

#Column Indices 
colInd <- grep("mean|std", features[,2], ignore.case=TRUE, value= features[1] )

#Remove from xTrain all other columns
xTrain <-  xTrain[, colInd]

# set colNames on XTrain
colnames(xTrain) <- features[colInd, 2]

# Bind Columns - Subject_id, activity_id , all mean|std columns - together
trainingDS <- cbind(subjectTrain,yTrain,xTrain)

#Similarly Load, Name Columns and Merge test data
subjectTest <- read.table(paste(filePath, '/test/subject_test.txt',sep=""),header=FALSE)
xTest       <- read.table(paste(filePath, '/test/x_test.txt',sep=""),header=FALSE)
yTest       <- read.table(paste(filePath, '/test/y_test.txt',sep=""),header=FALSE)

colnames(subjectTest) <- "subject_id"
colnames(yTest)       <- "activity_id"

xTest <-  xTest[, colInd]
colnames(xTest) <- features[colInd, 2]



testDS <- cbind(subjectTest,yTest,xTest)

# 1. Merge the training and the test sets to create one data set.
singleDS = rbind(trainingDS, testDS)

#on the merged Train/Test Data - Tidy Data
# Summarizing the singleDS table to include just the mean of each variable for each activity and each subject
tidyData    = aggregate(singleDS[,names(singleDS) != c('activity_id','subject_id')],
                  by=list(activity_id=singleDS$activity_id,subject_id = singleDS$subject_id),mean, simplify = TRUE)

#remove extra columns contributed by aggregate
tidyData<- tidyData[-c(3,4)]

#Merge with activityTyoe for activty_name 
tidyData <-merge(activityType, tidyData)

#remove activity_id
tidyData<- tidyData[-c(1)]

# Export the tidyData set 
write.table(tidyData, paste(filePath, '/tidydata.txt',sep="" ),row.names=FALSE,sep='\t', quote=FALSE)



