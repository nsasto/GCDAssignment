##Step 0: Load required test and training data sets into R

  library(data.table)
  
  activities <- read.csv('activity_labels.txt', header=F, stringsAsFactors=F, sep="")[,2]
  
  trainSubject <- read.csv('train/subject_train.txt', header=F, stringsAsFactors=F, sep="")[,1]
  trainSource  <- rep(1, length(trainSubject))
  trainX       <- read.csv('train/X_train.txt', header=F, stringsAsFactors=F, sep="")
  trainY       <- read.csv('train/y_train.txt', header=F, stringsAsFactors=F, sep="")
  train        <- cbind(trainSubject, trainX, trainY)
  
  testSubject <- read.csv('test/subject_test.txt', header=F, stringsAsFactors=F, sep="")[,1]
  testSource  <- rep(2, length(trainSubject))
  testX       <- read.csv('test/X_test.txt', header=F, stringsAsFactors=F, sep="")
  testY       <- read.csv('test/y_test.txt', header=F, stringsAsFactors=F, sep="")
  test        <- cbind(testSubject, testX, testY)
  
  #Todo: add source column
  
##Step 1: Merges the training and the test sets to create one data set.
  
  ##create data table containing merged data frames
  d <-rbind(test,train)
  
  ##Set Column Names from features.txt files (this will also fulfill requirement 4 of Assignment)
  namelist <- read.csv('UCI_HAR_Dataset/features.txt', header=F, stringsAsFactors=F, sep="")[,2]
  namelist <-make.names(features)
  #use regex to replace all multiple .'s with single _'s for readability
  namelist <- gsub(namelist, pattern='\\.+', replace="_")
  #use regex to replace trailing underscore's with ''
  namelist <- gsub(namelist,ignore.case=T, pattern="_$",replace="" )
  #add Activity_Idx to the name set
  names(d)<-c('Subject', namelist,'Activity_Idx')
  
  ##Add an Activity factor column convert Ativity_Idx column values to human readable activities
  ##This fulfilsrequirement 3 of the Assignment
  d <- transform(d, Activity = factor(d$Activity_Idx, labels=activities))
  ##Convert Subject to factor
  d$Subject <- factor(d$Subject)
  
##Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  ##columns with mean and sd measurements have either 'mean' or 'std' in the column name so we'll start by extracting those
  requiredCols <- grep(x=namelist, pattern='Subject|mean|std')
  ##this returns values with 'meanFreq' as well, so we now need to exlude these values
  exclude <- grep(x=namelist, pattern="meanFreq")
  requiredCols <- requiredCols[!(requiredCols %in% exclude)]
  ##Add in Activity column which is the last column
  s <- d[,c(requiredCols, ncol(d))]
  
  ##column data in s may be in char form, to ensure we have all data in numeric format, we explicitly cast back to numeric
  ##cast to char first to preserve any numbers that are the levels of a factor (rather than their internal representation)
  for(i in 2:(ncol(s)-1)) {
    s[,i] <- as.numeric(as.character(s[,i]))
  }
  
 ##Clean dataset s 'data.frame':  10299 obs. of  67 variables
  str(s)
  
  #write data back to disk as tidy1.csv
  write.csv(s, file="tidy_1.txt")
  
##step 3: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    
  ##convert s to a data table for quick summarising of data 
  DS <- data.table(s)
  ##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  DT <- DS[, lapply(.SD, mean), by=list(Subject,Activity)]
  ##rename the variables appropriately
  nm<-names(DT)
  ##First two columns are the grouping columns so we can ignore those
  nlist <- c('Subject', 'Activity', paste('mean.',nm[3:length(nm)],sep=''))
  newNames <- setNames(DT, nlist)
  ##Clean dataset DT data table of 180 obs. of  67 variables
  str(DT)
  #write data back to disk as tidy2.csv
  write.csv(DT, file="tidy_2.txt")
  