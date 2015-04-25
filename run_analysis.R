# Getting and Cleaning Data
# Course Project

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
data.x <- rbind(data.x.train, data.x.test)
data.y <- rbind(data.y.train, data.y.test)
data.subject <- rbind(data.subject.train, data.subject.test)

colnames(data.x) <- features[,2]
names(data.y) <- "Activity"
names(data.subject) <- "Subject"

print("Phase 1.3: Create one single data set from x, y and subject resources")
data <- cbind(data.x, data.y, data.subject)

##############################################################################
# Task 2 - Extracts only the measurements on the mean and standard deviation #
#          for each measurement.                                             #
##############################################################################

print("Phase 2: Extracts ony the measurements on the mean and standard deviation for each measurement")

useful_columns <- grep("[Mm]ean|std|Activity|Subject",colnames(data))
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

#print(dim(data.x.train))
#print(dim(data.y.train))
#print(dim(data.subject.train))
#print(dim(data.x.test))
#print(dim(data.y.test))
#print(dim(data.subject.test))

#print(dim(data.x))
#print(dim(data.y))
#print(dim(data.subject))

#print(dim(features))

#print(dim(data))
