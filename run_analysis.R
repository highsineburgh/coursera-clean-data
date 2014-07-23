if (!file.exists('accelerometers.zip')) {
  url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(url, destfile='accelerometers.zip', method='curl')
  unzip('accelerometers.zip')
}

## Work with the Test DataSet
setwd('UCI HAR Dataset/test/')
test_set <- read.table('X_test.txt')