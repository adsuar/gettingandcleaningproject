# Getting and Cleaning Data - Course Project

## Introduction

The current repository contains the work developed for the final project of the *Getting and Cleaning Data* Coursera project.

For that purpose, I've created a script named _run_analysis.R_ that will perform the whole work.

## Repository Structure

The main folder of the repository contains the following entries:
* *CodeBook.md*: file that describes the variables, the data, and any transformations or work performed to clean up the data.
* *README.md*: file that gives an introduction of the whole project.
* *run_analysis.R*: script that cleans up the data.
* *tidy_data.txt*: tidy data.
* *UCI HAR Dataset*: original data that is going to be cleaned up.

## run_analysis.R

The execution of the script is really simple. Since there was no requirement about how to give the raw data to the script, I've hardcoded such data in the source code.

The execution has to be done as follows:
```sh
$ cd REPOSITORY_PATH
$ Rscript run_analysis.R
```

Automatically, the script will perform the required tasks.

### Script tasks

The tasks to be performed are the following:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
