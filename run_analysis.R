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
suppressMessages(library(dplyr))

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

print("Phase 1.2: Merging training and testing data sets into one single object")
data.x <- rbind(data.x.train, data.x.test)
data.y <- rbind(data.y.train, data.y.test)
data.subject <- rbind(data.subject.train, data.subject.test)

colnames(data.x) <- features[,2]
names(data.y) <- "Activity"
names(data.subject) <- "Subject"

print("Phase 1.3: Create one single data set from x, y and subject resources")
data <- cbind(data.x, data.y, data.subject)

