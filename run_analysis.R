if (!file.exists('accelerometers.zip')) {
  url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(url, destfile='accelerometers.zip', method='curl')
  unzip('accelerometers.zip')
}

## Extract the names of the coloumns from features.txt
features <- read.table('UCI HAR Dataset/features.txt', stringsAsFactors = FALSE)
col_names <- features[,2]
activities <- read.table('UCI HAR Dataset/activity_labels.txt', stringsAsFactors = FALSE)

## Combine the Test DataSet
test_data_set <- read.table('UCI HAR Dataset/test/X_test.txt')
colnames(test_data_set) <- col_names
test_data_activities <- read.table('UCI HAR Dataset/test/y_test.txt')
colnames(test_data_activities) <- 'activity'
test_data <- cbind(test_data_activities, test_data_set)
test_subjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
colnames(test_subjects) <- 'subject'
test_data <- cbind(test_subjects, test_data)

## Combine the Train Dataset
train_data_set <- read.table('UCI HAR Dataset/train/X_train.txt')
colnames(train_data_set) <- col_names
train_data_activities <- read.table('UCI HAR Dataset/train/y_train.txt')
colnames(train_data_activities) <- 'activity'
train_data <- cbind(train_data_activities, train_data_set)
train_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
colnames(train_subjects) <- 'subject'
train_data <- cbind(train_subjects, train_data)

## Combine the Test and Train data
combined_data <- rbind(test_data, train_data)

## Remove columns that do not contain mean or std measurements
filter_cols <- grep(pattern = '*-std\\(\\)|*-mean\\(\\)|subject|activity', names(combined_data))
filtered_combined_data = combined_data[,filter_cols]

## Aggregate the data
agg_data <- aggregate(filtered_combined_data, by=list(filtered_combined_data$activity, filtered_combined_data$subject),
                      FUN=mean)
agg_data <- agg_data[,c(3:70)]
activity_labels <- gsub("_", " ", tolower(activities[,2]))

## Assign activity labels to the activity
agg_data$activity <- as.factor(activity_labels)
new_col_labels <- c("subject", "activitiy","tBodyAccMeanX" , "tBodyAccMeanY", "tBodyAccMeanZ", "tBodyAccDevX", 
                    "tBodyAccDevY", "tBodyAccDevZ", "tGravityAccMeanX", "tGravityAccMeanY", "tGravityAccMeanZ", 
                    "tGravityAccDevX", "tGravityAccDevY", "tGravityAccDevZ", "tBodyAccJerkMeanX", "tBodyAccJerkMeanY",
                     "tBodyAccJerkMeanZ", "tBodyAccJerkDevX", "tBodyAccJerkDevY", "tBodyAccJerkDevZ", "tBodyGyroMeanX",
                     "tBodyGyroMeanY", "tBodyGyroMeanZ", "tBodyGyroDevX", "tBodyGyroDevY", "tBodyGyroDevZ", "tBodyGyroJerkMeanX",
                     "tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ", "tBodyGyroJerkDevX", "tBodyGyroJerkDevY", "tBodyGyroJerkDevZ", "tBodyAccMagMean",
                     "tBodyAccMagDev", "tGravityAccMagMean", "tGravityAccMagDev", "tBodyAccJerkMagMean",
                     "tBodyAccJerkMagDev", "tBodyGryoMagMean", "tBodyGyroMagDev", "tBodyGyroJerkMagMean",
                     "tBodyGyroJerkMagDev", "fBodyAccMeanX", "fBodyAccMeanY", "fBodyAccMeanZ", "fBodyAccDevX",
                     "fBodyAccDevY", "fBodyAccDevZ", "fBodyAccJerkMeanX", "fBodyAccJerkMeanY", "fBodyAccJerkMeanZ",
                     "fBodyAccJerkDevX", "fBodyAccJerkDevY", "fBodyAccJerkDevZ", "fBodyGyroMeanX", "fBodyGyroMeanY",
                     "fBodyGyroMeanZ", "fBodyGyroDevX", "fBodyGyroDevY", "fBodyGyroDevZ", "fBodyAccMagMean",
                     "fBodyAccMagDev", "fBodyAccJerkMagMean", "fBodyAccJerkMagDev", "fBodyGyroMagMean",
                     "fBodyGyroMagDev", "fBodyGyroJerkMagMean", "fBodyGyroJerkMagDev")
colnames(agg_data) <- new_col_labels
write.csv(agg_data, file="tidy_data.csv", row.names=FALSE)