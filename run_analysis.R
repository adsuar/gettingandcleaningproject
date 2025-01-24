#!/usr/bin/Rscript
##################################################
## R script that executes the script that solves
## the Coursera's Getting and Cleaning Data 
## Course Project.
##
## Author: Antonio Adsuar
###################################################

############################
# Cleaning the environment #
############################
rm(list=ls())
system("clear")

#####################
# Loading libraries #
#####################
# The library is loaded in silent mode
suppressMessages(library(plyr))

#######################
# Variable definition #
#######################

print("Phase 0: Configuration of the Environment")

# I assume that the data folder has not been renamed and it's in
# the current working directory.
# The use of sep="/" helps me to not to pay attention to the linking
# of the different portions of the path.
baseFolder <- paste(getwd(),"UCI HAR Dataset", sep="/")

file.x.train <- paste(baseFolder,"train","X_train.txt",sep="/")
file.y.train <- paste(baseFolder,"train","y_train.txt",sep="/")
file.subject.train <- paste(baseFolder,"train","subject_train.txt",sep="/")
file.x.test <- paste(baseFolder,"test","X_test.txt",sep="/")
file.y.test <- paste(baseFolder,"test","y_test.txt",sep="/")
file.subject.test <- paste(baseFolder,"test","subject_test.txt",sep="/")

feature.names <- paste(baseFolder,"features.txt", sep="/")

activity.labels <- paste(baseFolder, "activity_labels.txt", sep="/")

#########################################################################
# Task 1 - Merge the training and the test sets to create one data set. #
#########################################################################

print("Phase 1: Merging the training and the test sets to create one data set")

print("Phase 1.1: Reading data sources")
data.x.train <- read.table(file.x.train)
data.y.train <- read.table(file.y.train)
data.subject.train <- read.table(file.subject.train)
data.x.test <- read.table(file.x.test)
data.y.test <- read.table(file.y.test)
data.subject.test <- read.table(file.subject.test)

features <- read.table(feature.names)

activities <- read.table(activity.labels)

print("Phase 1.2: Merging training and testing data sets into one single object")
# The order has to be preserved. Always test after train.
data.x <- rbind(data.x.train, data.x.test)
data.y <- rbind(data.y.train, data.y.test)
data.subject <- rbind(data.subject.train, data.subject.test)

colnames(data.x) <- features[,2]
names(data.y) <- "Activity"
names(data.subject) <- "Subject"

print("Phase 1.3: Create one single data set from x, y and subject resources")
# The two new columns are added at the end of the object.
data <- cbind(data.x, data.y, data.subject)

##############################################################################
# Task 2 - Extracts only the measurements on the mean and standard deviation #
#          for each measurement.                                             #
##############################################################################

print("Phase 2: Extracts ony the measurements on the mean and standard deviation for each measurement")

# With grepl I get which columns match any of the expressions
useful_columns <- grepl("mean\\(\\)|std\\(\\)|Activity|Subject",colnames(data))
data <- data[,useful_columns]

###############################################################################
# Task 3: Uses descriptive acctivity names to name the activities in the data #
#         set                                                                 #
###############################################################################

print("Phase 3: Uses desriptive activity names to name the activities in the data set")

# I substitute the numeric activity value by its corresponding activity label
data[,"Activity"] <- activities[data[,"Activity"],2]

# Another option is to use mapvalues
#data[,"Activity"] <- mapvalues(as.character(data[,"Activity"]), from=as.character(activities[,1]), to=as.character(activities[,2]))

##############################################################################
# Task 4: Appropriately labels the data set with descriptive variable names. #
##############################################################################

print("Phase 4: Appropriately labels the data set with descriptive variable names.")

# Substitution of the non-descriptive portions of the variable names
# The new description is created taking as a reference the information
# provided at features_info.txt
colnames(data) <- gsub("^t","time",colnames(data))
colnames(data) <- gsub("^f","frequency",colnames(data))
colnames(data) <- gsub("Acc","Accelerometer",colnames(data))
colnames(data) <- gsub("Gyro","Gyroscope",colnames(data))
colnames(data) <- gsub("BodyBody","Body",colnames(data))
colnames(data) <- gsub("Mag","Magnitude",colnames(data))
colnames(data) <- gsub("std","StandardDevitation",colnames(data))
colnames(data) <- gsub("-X","OnXAxis",colnames(data))
colnames(data) <- gsub("-Y","OnYAxis",colnames(data))
colnames(data) <- gsub("-Z","OnZAxis",colnames(data))
colnames(data) <- gsub("-","",colnames(data))
colnames(data) <- gsub("\\(\\)","",colnames(data))

# By default, I use the CamelCase form, but since I'm not sure if it can
# be applied, I change everything to lowercase.
colnames(data) <- tolower(colnames(data))

##############################################################################
# Task 5: Create a second independent tidy data set with the average of each #
#         variable for each activity and each subject.                       #
##############################################################################

print("Phase 5: Create a second independent tidy data set with the average of each variable for each activity and each subject.")

# We first group by activity and subject and then apply the mean function.
tidy_data <- ddply(data,c("activity","subject"), numcolwise(mean))

# ###########################################
# Final Task: Write the result into a file. #
# ###########################################

print("Final Task: Write the result into a file.")

# It's important to add the row.names=F option, or you will get an
# additional column with the row number.
write.table(tidy_data,file = "tidy_data.txt", row.names=F)
