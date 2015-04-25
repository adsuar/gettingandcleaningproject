# CodeBook Getting and Cleaning Data Course Project

## 1. Introduction

The current document reviews the structure of the data provided by the coursera team (chapter 2),  the useful files (chapter 3), the transformations applied (chaprter 4) and the structure of the tidy data (chapter 5).

## 2. Original Data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

## 3. Useful Files
Inside **UCI HAR Dataset** you can find:
* **train** folder: there you may find the following train files: subject, X and y.
* **test** folder: there you may find the following test files: subject, X and y.
* **activity_labels.txt**: this file contains the relation between the numeric value of the **y** values and the actual activity.
* **features_info.txt**: description of the different features.
* **features.txt**: labels for each variable (column) of the X files.

The **X** files contain the different measurements and the **y** files with the activities (each row at **X** is related to the same row at **y**).

Finally, the **subject** files contain the ID of the people that took the measurement.

## 4. Transformations Applied

With the information provided at X, y and subject, I've performed the following tasks:
* With the 6 available files (X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt), I've merged the information following the next steps:
 * merge by rows the X files (train + test)
 * merge by rows the y files (train + test)
 * merge by rows the subject files (train + test)
 * merge by columns the three previous files
 * the y column will be named **Activity**
 * the subject column will be named **Subject**
 * the X columns will be named with the data at features.txt
* Remove those measurement columns (those different from **Activity** and **Subject**) that do not end with **mean()** (mean value) or **std()** (standard deviation)
* Substitute the values of the **Activity** column by the string names stored at **activity_labels.txt**
* Apply tidy names to the columns:
 * All lower case when possible
 * Descriptive (Diagnosis versus Dx)
 * Not duplicated
 * Not have underscores or dots or white spaces
* Create a second tidy data set with the average of each variable for each activity and each subject. For that purpose, using ddply, I've grouped the rows by activity and by subject, and then I've calculated the average value when it can be applied (every column except from **Activity** and **Subject**).

## 5. Tidy Data
You will find a 180x68 file (I'm not considering the header), with the following columns:
* activity: the activity recorded with the smartphone.
* subject: the id of the subject that recorded the activity.
* the rest of the columns are the different average values recorded for different concepts. Please find below some hints about the columns:
 * accelerometer: the data has been collected from the accelerometer of the smartphone.
 * gyroscope: the data has been collected from the gyroscope of the smartphone.
 * body: body signal
 * gravity: gravity signal
 * magnitude: the magnitud of the signal, calculated using the Euclidean norm
 * mean: the average value of the whole variable values
 * standarddeviation: standard deviation of the whole variable values

For more information about the variables, please go to **chapter 2**.
