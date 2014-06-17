Getting and Cleaning Data Assignment
=============

##Background

###Context

The purpose of this project is to demonstrate an ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The following are required to submit and included in this repo: 

1. a tidy data set as described below, 
2. a link to a Github repository with your script for performing the analysis, and 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 

This readme explains how all of the scripts work and how they are connected.   

###Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.

A full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The source data for the assignment can be obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

####Variables

original data set variables are documented extensively in the README.txt file contained in the source zip file. Only variables included in the two transformed data sets will be documented here.

###Required Outputs

one R script called run_analysis.R that does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##Repo Contents

* **README.md** - this file
* **Codebook.md** - description of processes used to create the tidy datasets
* **varNames.xls** - Excel file used to generate the variable list markdown
* **run_analysis.R** - R script to load source data and create a consolidated tidy dataset. This process is detailed below and in the CodeBook.md file. 
* two tidy data csv files:
 * **tidy1.csv** - Consolidated dataset with clean variable names, merging X,Y and subject components containing only mean and standard deviation measurements 
 * **tidy2.csv** - Second, independent tidy data set with the average of each variable for each activity and each subject. 

###Working Directory

The script assumes your working directory contains the unzipped data set consistent with the format of the data zip file, ie. with the following structure
* activity_labels.txt
* features.txt
* features_info.txt
* README.txt
* test	(DIRECTORY)
* train (DIRECTORY)

etc.

##How It Works

##Script process

The script performs the following activities in order to create a tidy dataset, each activity is clearly marked with comments in the attached *run_analysis.R* file:

* Data preparation:
 1. Loads required test and training data sets (X, Y and Subject) data into R
 2. binds Subject, X and Y data for both training and test data (cbind)
 3. combines test and training data (rbind)
 4. loads features.txt file into R for creation of column names.
 5. parses features data to create syntactically correct variable names (make.names), replace all occurences of full-stops with underscores. 
 6. Add an Activity factor column converting the Activity data to a factor human readable activity values
* Data extraction
 1. using grep, extracts all column names with only 'Subject', 'mean' or 'std' (excluding meanFreq) in order to filter only required columns. 
 2. creates a subset of all columns that fulfil the conditions in 1
 3. casts all numeric data explcitly to numeric in case any data has been cast to char in the load
 4. saves this dataset as *tidy1.csv*
 5. converts dataset to data.table for quick aggregation
 6. creates a further dataset which provides mean of each combination of subject and activity for each variable.
 7. updates the names of this dataset to ensure they are descriptive of the data they contain, and not confused with data in `tidy1.csv`
 8. saves this output to *tidy2.csv*

##Variables

###General

The features selected for the source database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

As per assignment instructions, the set of variables that were retained from the original dataset were restricted to: 

* mean(): Mean value
* std(): Standard deviation

 Original variable names were all cleaned with the `make.names` function to ensure syntactically correct names. All .'s have been replaced with underscores for better readability. 

###tidy1.csv: Consolidated dataset with mean and standard deviations

Contains a data frame with 10299 observations of  67 variables. The file is saved as standard csv. To load, simply use `read.csv(file="tidy_1.csv")`

Included variables are as follows:

* **Subject**:Factor with 30 levels, the subject id for whom the results pertain
* **Activity**:Factor with 6 levels
 1. *WALKING*
 2. *WALKING_UPSTAIRS*
 3. *WALKING_DOWNSTAIRS*
 4. *SITTING*
 5. *STANDING*
 6. *LAYING*
* **tBodyAcc_mean_X**:numeric. mean of *tBodyAcc_X*
* **tBodyAcc_mean_Y**:numeric. mean of *tBodyAcc_Y*
* **tBodyAcc_mean_Z**:numeric. mean of *tBodyAcc_Z*
* **tBodyAcc_std_X**:numeric. standard deviation of *tBodyAcc_X*
* **tBodyAcc_std_Y**:numeric. standard deviation of *tBodyAcc_Y*
* **tBodyAcc_correlation_Y_Z**:numeric. standard deviation of *tBodyAcc_correlation_Y_Z*
* **tGravityAcc_mean_X**:numeric. mean of *tGravityAcc_X*
* **tGravityAcc_mean_Y**:numeric. mean of *tGravityAcc_Y*
* **tGravityAcc_mean_Z**:numeric. mean of *tGravityAcc_Z*
* **tGravityAcc_std_X**:numeric. standard deviation of *tGravityAcc_X*
* **tGravityAcc_std_Y**:numeric. standard deviation of *tGravityAcc_Y*
* **tGravityAcc_correlation_Y_Z**:numeric. standard deviation of *tGravityAcc_correlation_Y_Z*
* **tBodyAccJerk_mean_X**:numeric. mean of *tBodyAccJerk_X*
* **tBodyAccJerk_mean_Y**:numeric. mean of *tBodyAccJerk_Y*
* **tBodyAccJerk_mean_Z**:numeric. mean of *tBodyAccJerk_Z*
* **tBodyAccJerk_std_X**:numeric. standard deviation of *tBodyAccJerk_X*
* **tBodyAccJerk_std_Y**:numeric. standard deviation of *tBodyAccJerk_Y*
* **tBodyAccJerk_correlation_Y_Z**:numeric. standard deviation of *tBodyAccJerk_correlation_Y_Z*
* **tBodyGyro_mean_X**:numeric. mean of *tBodyGyro_X*
* **tBodyGyro_mean_Y**:numeric. mean of *tBodyGyro_Y*
* **tBodyGyro_mean_Z**:numeric. mean of *tBodyGyro_Z*
* **tBodyGyro_std_X**:numeric. standard deviation of *tBodyGyro_X*
* **tBodyGyro_std_Y**:numeric. standard deviation of *tBodyGyro_Y*
* **tBodyGyro_correlation_Y_Z**:numeric. standard deviation of *tBodyGyro_correlation_Y_Z*
* **tBodyGyroJerk_mean_X**:numeric. mean of *tBodyGyroJerk_X*
* **tBodyGyroJerk_mean_Y**:numeric. mean of *tBodyGyroJerk_Y*
* **tBodyGyroJerk_mean_Z**:numeric. mean of *tBodyGyroJerk_Z*
* **tBodyGyroJerk_std_X**:numeric. standard deviation of *tBodyGyroJerk_X*
* **tBodyGyroJerk_std_Y**:numeric. standard deviation of *tBodyGyroJerk_Y*
* **tBodyGyroJerk_correlation_Y_Z**:numeric. standard deviation of *tBodyGyroJerk_correlation_Y_Z*
* **tBodyAccMag_mean**:numeric. mean of *tBodyAccMag_mean*
* **tBodyAccMag_arCoeff_4**:numeric. standard deviation of *tBodyAccMag_arCoeff_4*
* **tGravityAccMag_mean**:numeric. mean of *tGravityAccMag_mean*
* **tGravityAccMag_arCoeff_4**:numeric. standard deviation of *tGravityAccMag_arCoeff_4*
* **tBodyAccJerkMag_mean**:numeric. mean of *tBodyAccJerkMag_mean*
* **tBodyAccJerkMag_arCoeff_4**:numeric. standard deviation of *tBodyAccJerkMag_arCoeff_4*
* **tBodyGyroMag_mean**:numeric. mean of *tBodyGyroMag_mean*
* **tBodyGyroMag_arCoeff_4**:numeric. standard deviation of *tBodyGyroMag_arCoeff_4*
* **tBodyGyroJerkMag_mean**:numeric. mean of *tBodyGyroJerkMag_mean*
* **tBodyGyroJerkMag_arCoeff_4**:numeric. standard deviation of *tBodyGyroJerkMag_arCoeff_4*
* **fBodyAcc_mean_X**:numeric. mean of *fBodyAcc_X*
* **fBodyAcc_mean_Y**:numeric. mean of *fBodyAcc_Y*
* **fBodyAcc_mean_Z**:numeric. mean of *fBodyAcc_Z*
* **fBodyAcc_std_X**:numeric. standard deviation of *fBodyAcc_X*
* **fBodyAcc_std_Y**:numeric. standard deviation of *fBodyAcc_Y*
* **fBodyAcc_bandsEnergy_25_48.2**:numeric. standard deviation of *fBodyAcc_bandsEnergy_25_48.2*
* **fBodyAccJerk_mean_X**:numeric. mean of *fBodyAccJerk_X*
* **fBodyAccJerk_mean_Y**:numeric. mean of *fBodyAccJerk_Y*
* **fBodyAccJerk_mean_Z**:numeric. mean of *fBodyAccJerk_Z*
* **fBodyAccJerk_std_X**:numeric. standard deviation of *fBodyAccJerk_X*
* **fBodyAccJerk_std_Y**:numeric. standard deviation of *fBodyAccJerk_Y*
* **fBodyAccJerk_bandsEnergy_25_48.2**:numeric. standard deviation of *fBodyAccJerk_bandsEnergy_25_48.2*
* **fBodyGyro_mean_X**:numeric. mean of *fBodyGyro_X*
* **fBodyGyro_mean_Y**:numeric. mean of *fBodyGyro_Y*
* **fBodyGyro_mean_Z**:numeric. mean of *fBodyGyro_Z*
* **fBodyGyro_std_X**:numeric. standard deviation of *fBodyGyro_X*
* **fBodyGyro_std_Y**:numeric. standard deviation of *fBodyGyro_Y*
* **fBodyGyro_bandsEnergy_25_48.2**:numeric. standard deviation of *fBodyGyro_bandsEnergy_25_48.2*
* **fBodyAccMag_mean**:numeric. mean of *fBodyAccMag_mean*
* **fBodyAccMag_kurtosis**:numeric. standard deviation of *fBodyAccMag_kurtosis*
* **fBodyBodyAccJerkMag_mean**:numeric. mean of *fBodyBodyAccJerkMag_mean*
* **fBodyBodyAccJerkMag_kurtosis**:numeric. standard deviation of *fBodyBodyAccJerkMag_kurtosis*
* **fBodyBodyGyroMag_mean**:numeric. mean of *fBodyBodyGyroMag_mean*
* **fBodyBodyGyroMag_kurtosis**:numeric. standard deviation of *fBodyBodyGyroMag_kurtosis*
* **fBodyBodyGyroJerkMag_mean**:numeric. mean of *fBodyBodyGyroJerkMag_mean*


###tidy2.csv: Data set with mean of each variable per activity and subject


Contains a data frame with 180 observations of  67 variables. The file is saved as standard csv. To load, simply use `read.csv(file="tidy_2.csv")`
The variables in this case are the average of each variable in tidy_1 for each activity and each subject combination. As such, variables are prefixed with 'mean.' to avoid confusion with variables in tidy1.csv

Included variables are as follows:

* **Subject**:Factor with 30 levels, the subject id for whom the results pertain
* **Activity**:Factor with 6 levels
 1. *WALKING*
 2. *WALKING_UPSTAIRS*
 3. *WALKING_DOWNSTAIRS*
 4. *SITTING*
 5. *STANDING*
 6. *LAYING*
* **mean.tBodyAcc_mean_X**:numeric. Average (mean) of *tBodyAcc_mean_X* in tidy1.csv
* **mean.tBodyAcc_mean_Y**:numeric. Average (mean) of *tBodyAcc_mean_Y* in tidy1.csv
* **mean.tBodyAcc_mean_Z**:numeric. Average (mean) of *tBodyAcc_mean_Z* in tidy1.csv
* **mean.tBodyAcc_std_X**:numeric. Average (mean) of *tBodyAcc_std_X* in tidy1.csv
* **mean.tBodyAcc_std_Y**:numeric. Average (mean) of *tBodyAcc_std_Y* in tidy1.csv
* **mean.tBodyAcc_correlation_Y_Z**:numeric. Average (mean) of *tBodyAcc_correlation_Y_Z* in tidy1.csv
* **mean.tGravityAcc_mean_X**:numeric. Average (mean) of *tGravityAcc_mean_X* in tidy1.csv
* **mean.tGravityAcc_mean_Y**:numeric. Average (mean) of *tGravityAcc_mean_Y* in tidy1.csv
* **mean.tGravityAcc_mean_Z**:numeric. Average (mean) of *tGravityAcc_mean_Z* in tidy1.csv
* **mean.tGravityAcc_std_X**:numeric. Average (mean) of *tGravityAcc_std_X* in tidy1.csv
* **mean.tGravityAcc_std_Y**:numeric. Average (mean) of *tGravityAcc_std_Y* in tidy1.csv
* **mean.tGravityAcc_correlation_Y_Z**:numeric. Average (mean) of *tGravityAcc_correlation_Y_Z* in tidy1.csv
* **mean.tBodyAccJerk_mean_X**:numeric. Average (mean) of *tBodyAccJerk_mean_X* in tidy1.csv
* **mean.tBodyAccJerk_mean_Y**:numeric. Average (mean) of *tBodyAccJerk_mean_Y* in tidy1.csv
* **mean.tBodyAccJerk_mean_Z**:numeric. Average (mean) of *tBodyAccJerk_mean_Z* in tidy1.csv
* **mean.tBodyAccJerk_std_X**:numeric. Average (mean) of *tBodyAccJerk_std_X* in tidy1.csv
* **mean.tBodyAccJerk_std_Y**:numeric. Average (mean) of *tBodyAccJerk_std_Y* in tidy1.csv
* **mean.tBodyAccJerk_correlation_Y_Z**:numeric. Average (mean) of *tBodyAccJerk_correlation_Y_Z* in tidy1.csv
* **mean.tBodyGyro_mean_X**:numeric. Average (mean) of *tBodyGyro_mean_X* in tidy1.csv
* **mean.tBodyGyro_mean_Y**:numeric. Average (mean) of *tBodyGyro_mean_Y* in tidy1.csv
* **mean.tBodyGyro_mean_Z**:numeric. Average (mean) of *tBodyGyro_mean_Z* in tidy1.csv
* **mean.tBodyGyro_std_X**:numeric. Average (mean) of *tBodyGyro_std_X* in tidy1.csv
* **mean.tBodyGyro_std_Y**:numeric. Average (mean) of *tBodyGyro_std_Y* in tidy1.csv
* **mean.tBodyGyro_correlation_Y_Z**:numeric. Average (mean) of *tBodyGyro_correlation_Y_Z* in tidy1.csv
* **mean.tBodyGyroJerk_mean_X**:numeric. Average (mean) of *tBodyGyroJerk_mean_X* in tidy1.csv
* **mean.tBodyGyroJerk_mean_Y**:numeric. Average (mean) of *tBodyGyroJerk_mean_Y* in tidy1.csv
* **mean.tBodyGyroJerk_mean_Z**:numeric. Average (mean) of *tBodyGyroJerk_mean_Z* in tidy1.csv
* **mean.tBodyGyroJerk_std_X**:numeric. Average (mean) of *tBodyGyroJerk_std_X* in tidy1.csv
* **mean.tBodyGyroJerk_std_Y**:numeric. Average (mean) of *tBodyGyroJerk_std_Y* in tidy1.csv
* **mean.tBodyGyroJerk_correlation_Y_Z**:numeric. Average (mean) of *tBodyGyroJerk_correlation_Y_Z* in tidy1.csv
* **mean.tBodyAccMag_mean**:numeric. Average (mean) of *tBodyAccMag_mean* in tidy1.csv
* **mean.tBodyAccMag_arCoeff_4**:numeric. Average (mean) of *tBodyAccMag_arCoeff_4* in tidy1.csv
* **mean.tGravityAccMag_mean**:numeric. Average (mean) of *tGravityAccMag_mean* in tidy1.csv
* **mean.tGravityAccMag_arCoeff_4**:numeric. Average (mean) of *tGravityAccMag_arCoeff_4* in tidy1.csv
* **mean.tBodyAccJerkMag_mean**:numeric. Average (mean) of *tBodyAccJerkMag_mean* in tidy1.csv
* **mean.tBodyAccJerkMag_arCoeff_4**:numeric. Average (mean) of *tBodyAccJerkMag_arCoeff_4* in tidy1.csv
* **mean.tBodyGyroMag_mean**:numeric. Average (mean) of *tBodyGyroMag_mean* in tidy1.csv
* **mean.tBodyGyroMag_arCoeff_4**:numeric. Average (mean) of *tBodyGyroMag_arCoeff_4* in tidy1.csv
* **mean.tBodyGyroJerkMag_mean**:numeric. Average (mean) of *tBodyGyroJerkMag_mean* in tidy1.csv
* **mean.tBodyGyroJerkMag_arCoeff_4**:numeric. Average (mean) of *tBodyGyroJerkMag_arCoeff_4* in tidy1.csv
* **mean.fBodyAcc_mean_X**:numeric. Average (mean) of *fBodyAcc_mean_X* in tidy1.csv
* **mean.fBodyAcc_mean_Y**:numeric. Average (mean) of *fBodyAcc_mean_Y* in tidy1.csv
* **mean.fBodyAcc_mean_Z**:numeric. Average (mean) of *fBodyAcc_mean_Z* in tidy1.csv
* **mean.fBodyAcc_std_X**:numeric. Average (mean) of *fBodyAcc_std_X* in tidy1.csv
* **mean.fBodyAcc_std_Y**:numeric. Average (mean) of *fBodyAcc_std_Y* in tidy1.csv
* **mean.fBodyAcc_bandsEnergy_25_48.2**:numeric. Average (mean) of *fBodyAcc_bandsEnergy_25_48.2* in tidy1.csv
* **mean.fBodyAccJerk_mean_X**:numeric. Average (mean) of *fBodyAccJerk_mean_X* in tidy1.csv
* **mean.fBodyAccJerk_mean_Y**:numeric. Average (mean) of *fBodyAccJerk_mean_Y* in tidy1.csv
* **mean.fBodyAccJerk_mean_Z**:numeric. Average (mean) of *fBodyAccJerk_mean_Z* in tidy1.csv
* **mean.fBodyAccJerk_std_X**:numeric. Average (mean) of *fBodyAccJerk_std_X* in tidy1.csv
* **mean.fBodyAccJerk_std_Y**:numeric. Average (mean) of *fBodyAccJerk_std_Y* in tidy1.csv
* **mean.fBodyAccJerk_bandsEnergy_25_48.2**:numeric. Average (mean) of *fBodyAccJerk_bandsEnergy_25_48.2* in tidy1.csv
* **mean.fBodyGyro_mean_X**:numeric. Average (mean) of *fBodyGyro_mean_X* in tidy1.csv
* **mean.fBodyGyro_mean_Y**:numeric. Average (mean) of *fBodyGyro_mean_Y* in tidy1.csv
* **mean.fBodyGyro_mean_Z**:numeric. Average (mean) of *fBodyGyro_mean_Z* in tidy1.csv
* **mean.fBodyGyro_std_X**:numeric. Average (mean) of *fBodyGyro_std_X* in tidy1.csv
* **mean.fBodyGyro_std_Y**:numeric. Average (mean) of *fBodyGyro_std_Y* in tidy1.csv
* **mean.fBodyGyro_bandsEnergy_25_48.2**:numeric. Average (mean) of *fBodyGyro_bandsEnergy_25_48.2* in tidy1.csv
* **mean.fBodyAccMag_mean**:numeric. Average (mean) of *fBodyAccMag_mean* in tidy1.csv
* **mean.fBodyAccMag_kurtosis**:numeric. Average (mean) of *fBodyAccMag_kurtosis* in tidy1.csv
* **mean.fBodyBodyAccJerkMag_mean**:numeric. Average (mean) of *fBodyBodyAccJerkMag_mean* in tidy1.csv
* **mean.fBodyBodyAccJerkMag_kurtosis**:numeric. Average (mean) of *fBodyBodyAccJerkMag_kurtosis* in tidy1.csv
* **mean.fBodyBodyGyroMag_mean**:numeric. Average (mean) of *fBodyBodyGyroMag_mean* in tidy1.csv
* **mean.fBodyBodyGyroMag_kurtosis**:numeric. Average (mean) of *fBodyBodyGyroMag_kurtosis* in tidy1.csv
* **mean.fBodyBodyGyroJerkMag_mean**:numeric. Average (mean) of *fBodyBodyGyroJerkMag_mean* in tidy1.csv
