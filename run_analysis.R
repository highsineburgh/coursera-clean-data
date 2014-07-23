if (!file.exists('accelerometers.zip')) {
  url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(url, destfile='accelerometers.zip', method='curl')
  unzip('accelerometers.zip')
}

## Extract the names of the coloumns from features.txt
features <- read.table('UCI HAR Dataset/features.txt', stringsAsFactors = FALSE)
col_names <- features[,2]

## Combine the Test DataSet
test_data_set <- read.table('UCI HAR Dataset/test/X_test.txt')
colnames(test_data_set) <- col_names
test_data_subjects <- read.table('UCI HAR Dataset/test/y_test.txt')
colnames(test_data_subjects) <- 'subject'
test_data <- cbind(test_data_set, test_data_subjects)

## Combine the Train Dataset
train_data_set <- read.table('UCI HAR Dataset/train/X_train.txt')
colnames(train_data_set) <- col_names
train_data_subjects <- read.table('UCI HAR Dataset/train/y_train.txt')
colnames(train_data_subjects) <- 'subject'
train_data <- cbind(train_data_set, train_data_subjects)

## Combine the Test and Train data
combined_data <- rbind(test_data, train_data)