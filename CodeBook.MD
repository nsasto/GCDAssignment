Assignment CodeBook
=============

##Context

This Codebook documents the process involved in generating the tidy data sets. In addition, detail is provided for all variables in both *tidy_1.txt* and  *tidy_2.txt*. A full meta data description of variables in the final output is also included.    

The R script run_analysis.R provided, performs the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

###Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.

A full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The source data for the assignment can be obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

####Variables

original data set variables are documented extensively in the README.txt file contained in the source zip file. Only variables included in the two transformed data sets will be documented here.

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

###Script process

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
 4. saves this dataset as *tidy1.txt*
 5. converts dataset to data.table for quick aggregation
 6. creates a further dataset which provides mean of each combination of subject and activity for each variable.
 7. updates the names of this dataset to ensure they are descriptive of the data they contain, and not confused with data in `tidy1.txt`
 8. saves this output to *tidy2.txt*

###Variables

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

###tidy1.txt: Consolidated dataset with mean and standard deviations

Contains a data frame with 10299 observations of  67 variables. The file is saved as standard csv. To load, simply use `read.txt(file="tidy_1.txt")`

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


###tidy2.txt: Data set with mean of each variable per activity and subject


Contains a data frame with 180 observations of  67 variables. The file is saved as standard csv. To load, simply use `read.txt(file="tidy_2.txt")`
The variables in this case are the average of each variable in tidy_1 for each activity and each subject combination. As such, variables are prefixed with 'mean.' to avoid confusion with variables in tidy1.txt

Included variables are as follows:

* **Subject**:Factor with 30 levels, the subject id for whom the results pertain
* **Activity**:Factor with 6 levels
 1. *WALKING*
 2. *WALKING_UPSTAIRS*
 3. *WALKING_DOWNSTAIRS*
 4. *SITTING*
 5. *STANDING*
 6. *LAYING*
* **mean.tBodyAcc_mean_X**:numeric. Average (mean) of *tBodyAcc_mean_X* in tidy1.txt
* **mean.tBodyAcc_mean_Y**:numeric. Average (mean) of *tBodyAcc_mean_Y* in tidy1.txt
* **mean.tBodyAcc_mean_Z**:numeric. Average (mean) of *tBodyAcc_mean_Z* in tidy1.txt
* **mean.tBodyAcc_std_X**:numeric. Average (mean) of *tBodyAcc_std_X* in tidy1.txt
* **mean.tBodyAcc_std_Y**:numeric. Average (mean) of *tBodyAcc_std_Y* in tidy1.txt
* **mean.tBodyAcc_correlation_Y_Z**:numeric. Average (mean) of *tBodyAcc_correlation_Y_Z* in tidy1.txt
* **mean.tGravityAcc_mean_X**:numeric. Average (mean) of *tGravityAcc_mean_X* in tidy1.txt
* **mean.tGravityAcc_mean_Y**:numeric. Average (mean) of *tGravityAcc_mean_Y* in tidy1.txt
* **mean.tGravityAcc_mean_Z**:numeric. Average (mean) of *tGravityAcc_mean_Z* in tidy1.txt
* **mean.tGravityAcc_std_X**:numeric. Average (mean) of *tGravityAcc_std_X* in tidy1.txt
* **mean.tGravityAcc_std_Y**:numeric. Average (mean) of *tGravityAcc_std_Y* in tidy1.txt
* **mean.tGravityAcc_correlation_Y_Z**:numeric. Average (mean) of *tGravityAcc_correlation_Y_Z* in tidy1.txt
* **mean.tBodyAccJerk_mean_X**:numeric. Average (mean) of *tBodyAccJerk_mean_X* in tidy1.txt
* **mean.tBodyAccJerk_mean_Y**:numeric. Average (mean) of *tBodyAccJerk_mean_Y* in tidy1.txt
* **mean.tBodyAccJerk_mean_Z**:numeric. Average (mean) of *tBodyAccJerk_mean_Z* in tidy1.txt
* **mean.tBodyAccJerk_std_X**:numeric. Average (mean) of *tBodyAccJerk_std_X* in tidy1.txt
* **mean.tBodyAccJerk_std_Y**:numeric. Average (mean) of *tBodyAccJerk_std_Y* in tidy1.txt
* **mean.tBodyAccJerk_correlation_Y_Z**:numeric. Average (mean) of *tBodyAccJerk_correlation_Y_Z* in tidy1.txt
* **mean.tBodyGyro_mean_X**:numeric. Average (mean) of *tBodyGyro_mean_X* in tidy1.txt
* **mean.tBodyGyro_mean_Y**:numeric. Average (mean) of *tBodyGyro_mean_Y* in tidy1.txt
* **mean.tBodyGyro_mean_Z**:numeric. Average (mean) of *tBodyGyro_mean_Z* in tidy1.txt
* **mean.tBodyGyro_std_X**:numeric. Average (mean) of *tBodyGyro_std_X* in tidy1.txt
* **mean.tBodyGyro_std_Y**:numeric. Average (mean) of *tBodyGyro_std_Y* in tidy1.txt
* **mean.tBodyGyro_correlation_Y_Z**:numeric. Average (mean) of *tBodyGyro_correlation_Y_Z* in tidy1.txt
* **mean.tBodyGyroJerk_mean_X**:numeric. Average (mean) of *tBodyGyroJerk_mean_X* in tidy1.txt
* **mean.tBodyGyroJerk_mean_Y**:numeric. Average (mean) of *tBodyGyroJerk_mean_Y* in tidy1.txt
* **mean.tBodyGyroJerk_mean_Z**:numeric. Average (mean) of *tBodyGyroJerk_mean_Z* in tidy1.txt
* **mean.tBodyGyroJerk_std_X**:numeric. Average (mean) of *tBodyGyroJerk_std_X* in tidy1.txt
* **mean.tBodyGyroJerk_std_Y**:numeric. Average (mean) of *tBodyGyroJerk_std_Y* in tidy1.txt
* **mean.tBodyGyroJerk_correlation_Y_Z**:numeric. Average (mean) of *tBodyGyroJerk_correlation_Y_Z* in tidy1.txt
* **mean.tBodyAccMag_mean**:numeric. Average (mean) of *tBodyAccMag_mean* in tidy1.txt
* **mean.tBodyAccMag_arCoeff_4**:numeric. Average (mean) of *tBodyAccMag_arCoeff_4* in tidy1.txt
* **mean.tGravityAccMag_mean**:numeric. Average (mean) of *tGravityAccMag_mean* in tidy1.txt
* **mean.tGravityAccMag_arCoeff_4**:numeric. Average (mean) of *tGravityAccMag_arCoeff_4* in tidy1.txt
* **mean.tBodyAccJerkMag_mean**:numeric. Average (mean) of *tBodyAccJerkMag_mean* in tidy1.txt
* **mean.tBodyAccJerkMag_arCoeff_4**:numeric. Average (mean) of *tBodyAccJerkMag_arCoeff_4* in tidy1.txt
* **mean.tBodyGyroMag_mean**:numeric. Average (mean) of *tBodyGyroMag_mean* in tidy1.txt
* **mean.tBodyGyroMag_arCoeff_4**:numeric. Average (mean) of *tBodyGyroMag_arCoeff_4* in tidy1.txt
* **mean.tBodyGyroJerkMag_mean**:numeric. Average (mean) of *tBodyGyroJerkMag_mean* in tidy1.txt
* **mean.tBodyGyroJerkMag_arCoeff_4**:numeric. Average (mean) of *tBodyGyroJerkMag_arCoeff_4* in tidy1.txt
* **mean.fBodyAcc_mean_X**:numeric. Average (mean) of *fBodyAcc_mean_X* in tidy1.txt
* **mean.fBodyAcc_mean_Y**:numeric. Average (mean) of *fBodyAcc_mean_Y* in tidy1.txt
* **mean.fBodyAcc_mean_Z**:numeric. Average (mean) of *fBodyAcc_mean_Z* in tidy1.txt
* **mean.fBodyAcc_std_X**:numeric. Average (mean) of *fBodyAcc_std_X* in tidy1.txt
* **mean.fBodyAcc_std_Y**:numeric. Average (mean) of *fBodyAcc_std_Y* in tidy1.txt
* **mean.fBodyAcc_bandsEnergy_25_48.2**:numeric. Average (mean) of *fBodyAcc_bandsEnergy_25_48.2* in tidy1.txt
* **mean.fBodyAccJerk_mean_X**:numeric. Average (mean) of *fBodyAccJerk_mean_X* in tidy1.txt
* **mean.fBodyAccJerk_mean_Y**:numeric. Average (mean) of *fBodyAccJerk_mean_Y* in tidy1.txt
* **mean.fBodyAccJerk_mean_Z**:numeric. Average (mean) of *fBodyAccJerk_mean_Z* in tidy1.txt
* **mean.fBodyAccJerk_std_X**:numeric. Average (mean) of *fBodyAccJerk_std_X* in tidy1.txt
* **mean.fBodyAccJerk_std_Y**:numeric. Average (mean) of *fBodyAccJerk_std_Y* in tidy1.txt
* **mean.fBodyAccJerk_bandsEnergy_25_48.2**:numeric. Average (mean) of *fBodyAccJerk_bandsEnergy_25_48.2* in tidy1.txt
* **mean.fBodyGyro_mean_X**:numeric. Average (mean) of *fBodyGyro_mean_X* in tidy1.txt
* **mean.fBodyGyro_mean_Y**:numeric. Average (mean) of *fBodyGyro_mean_Y* in tidy1.txt
* **mean.fBodyGyro_mean_Z**:numeric. Average (mean) of *fBodyGyro_mean_Z* in tidy1.txt
* **mean.fBodyGyro_std_X**:numeric. Average (mean) of *fBodyGyro_std_X* in tidy1.txt
* **mean.fBodyGyro_std_Y**:numeric. Average (mean) of *fBodyGyro_std_Y* in tidy1.txt
* **mean.fBodyGyro_bandsEnergy_25_48.2**:numeric. Average (mean) of *fBodyGyro_bandsEnergy_25_48.2* in tidy1.txt
* **mean.fBodyAccMag_mean**:numeric. Average (mean) of *fBodyAccMag_mean* in tidy1.txt
* **mean.fBodyAccMag_kurtosis**:numeric. Average (mean) of *fBodyAccMag_kurtosis* in tidy1.txt
* **mean.fBodyBodyAccJerkMag_mean**:numeric. Average (mean) of *fBodyBodyAccJerkMag_mean* in tidy1.txt
* **mean.fBodyBodyAccJerkMag_kurtosis**:numeric. Average (mean) of *fBodyBodyAccJerkMag_kurtosis* in tidy1.txt
* **mean.fBodyBodyGyroMag_mean**:numeric. Average (mean) of *fBodyBodyGyroMag_mean* in tidy1.txt
* **mean.fBodyBodyGyroMag_kurtosis**:numeric. Average (mean) of *fBodyBodyGyroMag_kurtosis* in tidy1.txt
* **mean.fBodyBodyGyroJerkMag_mean**:numeric. Average (mean) of *fBodyBodyGyroJerkMag_mean* in tidy1.txt

###tidy2.txt Detailed Variable Summary


   DT.Subject

---------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Measurement: nominal

   Values and labels   N   Percent
                                  
            1   '1'    6   3.3 3.3
            2   '2'    6   3.3 3.3
            3   '3'    6   3.3 3.3
            4   '4'    6   3.3 3.3
            5   '5'    6   3.3 3.3
            6   '6'    6   3.3 3.3
            7   '7'    6   3.3 3.3
            8   '8'    6   3.3 3.3
            9   '9'    6   3.3 3.3
           10   '10'   6   3.3 3.3
           11   '11'   6   3.3 3.3
           12   '12'   6   3.3 3.3
           13   '13'   6   3.3 3.3
           14   '14'   6   3.3 3.3
           15   '15'   6   3.3 3.3
           16   '16'   6   3.3 3.3
           17   '17'   6   3.3 3.3
           18   '18'   6   3.3 3.3
           19   '19'   6   3.3 3.3
           20   '20'   6   3.3 3.3
           21   '21'   6   3.3 3.3
           22   '22'   6   3.3 3.3
           23   '23'   6   3.3 3.3
           24   '24'   6   3.3 3.3
           25   '25'   6   3.3 3.3
           26   '26'   6   3.3 3.3
           27   '27'   6   3.3 3.3
           28   '28'   6   3.3 3.3
           29   '29'   6   3.3 3.3
           30   '30'   6   3.3 3.3

=========================================================================================================

   DT.Activity

---------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Measurement: nominal

          Values and labels    N    Percent 
                                            
   1   'WALKING'              30   16.7 16.7
   2   'WALKING_UPSTAIRS'     30   16.7 16.7
   3   'WALKING_DOWNSTAIRS'   30   16.7 16.7
   4   'SITTING'              30   16.7 16.7
   5   'STANDING'             30   16.7 16.7
   6   'LAYING'               30   16.7 16.7

=========================================================================================================

   DT.mean.tBodyAcc_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:   0.222
            Max:   0.301
           Mean:   0.274
       Std.Dev.:   0.012
       Skewness:  -1.055
       Kurtosis:   2.329

=========================================================================================================

   DT.mean.tBodyAcc_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.041
            Max:  -0.001
           Mean:  -0.018
       Std.Dev.:   0.006
       Skewness:  -0.537
       Kurtosis:   1.612

=========================================================================================================

   DT.mean.tBodyAcc_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.153
            Max:  -0.075
           Mean:  -0.109
       Std.Dev.:   0.010
       Skewness:  -1.115
       Kurtosis:   4.910

=========================================================================================================

   DT.mean.tBodyAcc_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.996
            Max:   0.627
           Mean:  -0.558
       Std.Dev.:   0.450
       Skewness:   0.438
       Kurtosis:  -1.216

=========================================================================================================

   DT.mean.tBodyAcc_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.990
            Max:   0.617
           Mean:  -0.460
       Std.Dev.:   0.495
       Skewness:   0.235
       Kurtosis:  -1.586

=========================================================================================================

   DT.mean.tBodyAcc_correlation_Y_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.632
            Max:   0.602
           Mean:   0.110
       Std.Dev.:   0.239
       Skewness:  -0.682
       Kurtosis:   0.031

=========================================================================================================

   DT.mean.tGravityAcc_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.680
            Max:   0.975
           Mean:   0.697
       Std.Dev.:   0.486
       Skewness:  -1.811
       Kurtosis:   1.452

=========================================================================================================

   DT.mean.tGravityAcc_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.480
            Max:   0.957
           Mean:  -0.016
       Std.Dev.:   0.344
       Skewness:   1.427
       Kurtosis:   1.051

=========================================================================================================

   DT.mean.tGravityAcc_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.495
            Max:   0.958
           Mean:   0.074
       Std.Dev.:   0.288
       Skewness:   1.145
       Kurtosis:   1.208

=========================================================================================================

   DT.mean.tGravityAcc_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.997
            Max:  -0.830
           Mean:  -0.964
       Std.Dev.:   0.025
       Skewness:   1.669
       Kurtosis:   5.051

=========================================================================================================

   DT.mean.tGravityAcc_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.994
            Max:  -0.644
           Mean:  -0.952
       Std.Dev.:   0.033
       Skewness:   4.817
       Kurtosis:  42.501

=========================================================================================================

   DT.mean.tGravityAcc_correlation_Y_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.931
            Max:   0.734
           Mean:   0.096
       Std.Dev.:   0.348
       Skewness:  -0.825
       Kurtosis:   0.481

=========================================================================================================

   DT.mean.tBodyAccJerk_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  0.043
            Max:  0.130
           Mean:  0.079
       Std.Dev.:  0.013
       Skewness:  0.821
       Kurtosis:  2.560

=========================================================================================================

   DT.mean.tBodyAccJerk_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.039
            Max:   0.057
           Mean:   0.008
       Std.Dev.:   0.014
       Skewness:  -0.192
       Kurtosis:   1.606

=========================================================================================================

   DT.mean.tBodyAccJerk_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.067
            Max:   0.038
           Mean:  -0.005
       Std.Dev.:   0.013
       Skewness:  -0.835
       Kurtosis:   3.525

=========================================================================================================

   DT.mean.tBodyAccJerk_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.995
            Max:   0.544
           Mean:  -0.595
       Std.Dev.:   0.416
       Skewness:   0.424
       Kurtosis:  -1.273

=========================================================================================================

   DT.mean.tBodyAccJerk_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.990
            Max:   0.355
           Mean:  -0.565
       Std.Dev.:   0.432
       Skewness:   0.362
       Kurtosis:  -1.450

=========================================================================================================

   DT.mean.tBodyAccJerk_correlation_Y_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.311
            Max:   0.608
           Mean:   0.085
       Std.Dev.:   0.177
       Skewness:   0.567
       Kurtosis:  -0.105

=========================================================================================================

   DT.mean.tBodyGyro_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.206
            Max:   0.193
           Mean:  -0.032
       Std.Dev.:   0.054
       Skewness:   0.341
       Kurtosis:   2.391

=========================================================================================================

   DT.mean.tBodyGyro_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.204
            Max:   0.027
           Mean:  -0.074
       Std.Dev.:   0.035
       Skewness:  -0.286
       Kurtosis:   2.070

=========================================================================================================

   DT.mean.tBodyGyro_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.072
            Max:   0.179
           Mean:   0.087
       Std.Dev.:   0.036
       Skewness:  -0.781
       Kurtosis:   3.224

=========================================================================================================

   DT.mean.tBodyGyro_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.994
            Max:   0.268
           Mean:  -0.692
       Std.Dev.:   0.290
       Skewness:   0.391
       Kurtosis:  -1.073

=========================================================================================================

   DT.mean.tBodyGyro_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.994
            Max:   0.477
           Mean:  -0.653
       Std.Dev.:   0.351
       Skewness:   0.731
       Kurtosis:  -0.458

=========================================================================================================

   DT.mean.tBodyGyro_correlation_Y_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.616
            Max:   0.713
           Mean:  -0.090
       Std.Dev.:   0.282
       Skewness:   0.368
       Kurtosis:  -0.298

=========================================================================================================

   DT.mean.tBodyGyroJerk_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.157
            Max:  -0.022
           Mean:  -0.096
       Std.Dev.:   0.023
       Skewness:   0.485
       Kurtosis:   1.825

=========================================================================================================

   DT.mean.tBodyGyroJerk_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.077
            Max:  -0.013
           Mean:  -0.043
       Std.Dev.:   0.010
       Skewness:  -0.814
       Kurtosis:   2.785

=========================================================================================================

   DT.mean.tBodyGyroJerk_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.092
            Max:  -0.007
           Mean:  -0.055
       Std.Dev.:   0.012
       Skewness:   0.258
       Kurtosis:   1.867

=========================================================================================================

   DT.mean.tBodyGyroJerk_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.997
            Max:   0.179
           Mean:  -0.704
       Std.Dev.:   0.300
       Skewness:   0.554
       Kurtosis:  -0.916

=========================================================================================================

   DT.mean.tBodyGyroJerk_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.997
            Max:   0.296
           Mean:  -0.764
       Std.Dev.:   0.267
       Skewness:   1.156
       Kurtosis:   1.064

=========================================================================================================

   DT.mean.tBodyGyroJerk_correlation_Y_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.499
            Max:   0.289
           Mean:  -0.110
       Std.Dev.:   0.165
       Skewness:   0.162
       Kurtosis:  -0.333

=========================================================================================================

   DT.mean.tBodyAccMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.986
            Max:   0.645
           Mean:  -0.497
       Std.Dev.:   0.472
       Skewness:   0.231
       Kurtosis:  -1.587

=========================================================================================================

   DT.mean.tBodyAccMag_arCoeff_4

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.365
            Max:   0.303
           Mean:  -0.050
       Std.Dev.:   0.139
       Skewness:   0.339
       Kurtosis:  -0.761

=========================================================================================================

   DT.mean.tGravityAccMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.986
            Max:   0.645
           Mean:  -0.497
       Std.Dev.:   0.472
       Skewness:   0.231
       Kurtosis:  -1.587

=========================================================================================================

   DT.mean.tGravityAccMag_arCoeff_4

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.365
            Max:   0.303
           Mean:  -0.050
       Std.Dev.:   0.139
       Skewness:   0.339
       Kurtosis:  -0.761

=========================================================================================================

   DT.mean.tBodyAccJerkMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.993
            Max:   0.434
           Mean:  -0.608
       Std.Dev.:   0.395
       Skewness:   0.360
       Kurtosis:  -1.388

=========================================================================================================

   DT.mean.tBodyAccJerkMag_arCoeff_4

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.386
            Max:   0.377
           Mean:  -0.039
       Std.Dev.:   0.119
       Skewness:   0.631
       Kurtosis:   0.910

=========================================================================================================

   DT.mean.tBodyGyroMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.981
            Max:   0.418
           Mean:  -0.565
       Std.Dev.:   0.397
       Skewness:   0.313
       Kurtosis:  -1.422

=========================================================================================================

   DT.mean.tBodyGyroMag_arCoeff_4

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.356
            Max:   0.316
           Mean:  -0.055
       Std.Dev.:   0.114
       Skewness:   0.201
       Kurtosis:   0.551

=========================================================================================================

   DT.mean.tBodyGyroJerkMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.997
            Max:   0.088
           Mean:  -0.736
       Std.Dev.:   0.276
       Skewness:   0.660
       Kurtosis:  -0.646

=========================================================================================================

   DT.mean.tBodyGyroJerkMag_arCoeff_4

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.446
            Max:   0.480
           Mean:  -0.104
       Std.Dev.:   0.144
       Skewness:   0.680
       Kurtosis:   0.926

=========================================================================================================

   DT.mean.fBodyAcc_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.995
            Max:   0.537
           Mean:  -0.576
       Std.Dev.:   0.429
       Skewness:   0.391
       Kurtosis:  -1.328

=========================================================================================================

   DT.mean.fBodyAcc_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.989
            Max:   0.524
           Mean:  -0.489
       Std.Dev.:   0.479
       Skewness:   0.259
       Kurtosis:  -1.567

=========================================================================================================

   DT.mean.fBodyAcc_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.989
            Max:   0.281
           Mean:  -0.630
       Std.Dev.:   0.355
       Skewness:   0.470
       Kurtosis:  -1.073

=========================================================================================================

   DT.mean.fBodyAcc_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.997
            Max:   0.659
           Mean:  -0.552
       Std.Dev.:   0.459
       Skewness:   0.469
       Kurtosis:  -1.145

=========================================================================================================

   DT.mean.fBodyAcc_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.991
            Max:   0.560
           Mean:  -0.481
       Std.Dev.:   0.473
       Skewness:   0.244
       Kurtosis:  -1.566

=========================================================================================================

   DT.mean.fBodyAcc_bandsEnergy_25_48.2

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -1.000
            Max:  -0.559
           Mean:  -0.954
       Std.Dev.:   0.072
       Skewness:   2.549
       Kurtosis:   8.157

=========================================================================================================

   DT.mean.fBodyAccJerk_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.995
            Max:   0.474
           Mean:  -0.614
       Std.Dev.:   0.397
       Skewness:   0.444
       Kurtosis:  -1.222

=========================================================================================================

   DT.mean.fBodyAccJerk_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.989
            Max:   0.277
           Mean:  -0.588
       Std.Dev.:   0.407
       Skewness:   0.347
       Kurtosis:  -1.478

=========================================================================================================

   DT.mean.fBodyAccJerk_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.992
            Max:   0.158
           Mean:  -0.714
       Std.Dev.:   0.296
       Skewness:   0.670
       Kurtosis:  -0.677

=========================================================================================================

   DT.mean.fBodyAccJerk_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.995
            Max:   0.477
           Mean:  -0.612
       Std.Dev.:   0.399
       Skewness:   0.413
       Kurtosis:  -1.306

=========================================================================================================

   DT.mean.fBodyAccJerk_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.990
            Max:   0.350
           Mean:  -0.571
       Std.Dev.:   0.431
       Skewness:   0.393
       Kurtosis:  -1.386

=========================================================================================================

   DT.mean.fBodyAccJerk_bandsEnergy_25_48.2

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -1.000
            Max:  -0.562
           Mean:  -0.955
       Std.Dev.:   0.071
       Skewness:   2.558
       Kurtosis:   8.172

=========================================================================================================

   DT.mean.fBodyGyro_mean_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.993
            Max:   0.475
           Mean:  -0.637
       Std.Dev.:   0.346
       Skewness:   0.417
       Kurtosis:  -1.040

=========================================================================================================

   DT.mean.fBodyGyro_mean_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.994
            Max:   0.329
           Mean:  -0.677
       Std.Dev.:   0.331
       Skewness:   0.738
       Kurtosis:  -0.471

=========================================================================================================

   DT.mean.fBodyGyro_mean_Z

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.986
            Max:   0.492
           Mean:  -0.604
       Std.Dev.:   0.383
       Skewness:   0.445
       Kurtosis:  -1.128

=========================================================================================================

   DT.mean.fBodyGyro_std_X

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.995
            Max:   0.197
           Mean:  -0.711
       Std.Dev.:   0.272
       Skewness:   0.401
       Kurtosis:  -1.052

=========================================================================================================

   DT.mean.fBodyGyro_std_Y

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.994
            Max:   0.646
           Mean:  -0.645
       Std.Dev.:   0.362
       Skewness:   0.830
       Kurtosis:  -0.090

=========================================================================================================

   DT.mean.fBodyGyro_bandsEnergy_25_48.2

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -1.000
            Max:  -0.583
           Mean:  -0.961
       Std.Dev.:   0.062
       Skewness:   2.612
       Kurtosis:   9.190

=========================================================================================================

   DT.mean.fBodyAccMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.987
            Max:   0.587
           Mean:  -0.537
       Std.Dev.:   0.450
       Skewness:   0.464
       Kurtosis:  -1.197

=========================================================================================================

   DT.mean.fBodyAccMag_kurtosis

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.905
            Max:  -0.096
           Mean:  -0.639
       Std.Dev.:   0.133
       Skewness:   0.982
       Kurtosis:   1.836

=========================================================================================================

   DT.mean.fBodyBodyAccJerkMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.994
            Max:   0.538
           Mean:  -0.576
       Std.Dev.:   0.430
       Skewness:   0.424
       Kurtosis:  -1.293

=========================================================================================================

   DT.mean.fBodyBodyAccJerkMag_kurtosis

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.899
            Max:   0.334
           Mean:  -0.588
       Std.Dev.:   0.244
       Skewness:   1.291
       Kurtosis:   1.359

=========================================================================================================

   DT.mean.fBodyBodyGyroMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.987
            Max:   0.204
           Mean:  -0.667
       Std.Dev.:   0.317
       Skewness:   0.582
       Kurtosis:  -0.793

=========================================================================================================

   DT.mean.fBodyBodyGyroMag_kurtosis

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.850
            Max:  -0.094
           Mean:  -0.585
       Std.Dev.:   0.138
       Skewness:   0.379
       Kurtosis:   0.150

=========================================================================================================

   DT.mean.fBodyBodyGyroJerkMag_mean

---------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.998
            Max:   0.147
           Mean:  -0.756
       Std.Dev.:   0.262
       Skewness:   0.957
       Kurtosis:   0.276

