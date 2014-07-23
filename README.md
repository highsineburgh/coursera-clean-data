#coursera-clean-data
===================

The run_analyis.R script performs the following:
1. Download accelerometer data from [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Merge the training and test data sets to create a single dataset consisting of only the mean and standard deviation for each measurement. 
3. Relabels activities and variables with descriptive names.
4. Creates a new data set with the average of each variable for each activity and each subject and writes it to a file. 


Full details of this data set can be obtained from the [site] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained.

###Dependancies
=============
The scripts used depend on the following R packages: 
-curl