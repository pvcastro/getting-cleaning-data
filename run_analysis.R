fileName <- "data.zip"

##Obtain the specified data
if (!file.exists(fileName)) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = fileName, method = "curl")
}

##Unzip the data file
if (!file.exists("UCI HAR Dataset")) {
    unzip(fileName)
}

##Get activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

##Get features

#Read features file
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
#Filter by mean and standard deviation features only
featuresIdx <- grep("(.*mean.*|.*std.*)", features[,2])
relevantFeatures <- features[featuresIdx,]

get_data <- function(data_path, activity_path, subject_path, featuresNames, featuresIdx) {
    data <- read.table(data_path, col.names = featuresNames)
    activities <- read.table(activity_path, col.names = "activity")
    subjects <- read.table(subject_path, col.names = "subject")
    data <- data[,featuresIdx]
    data <- cbind(subjects, activities, data)
    data
}

##Process training data
train_data <- get_data(data_path = "UCI HAR Dataset/train/X_train.txt", 
                       activity_path = "UCI HAR Dataset/train/y_train.txt",
                       subject_path = "UCI HAR Dataset/train/subject_train.txt",
                       featuresNames = features[,2],
                       featuresIdx = featuresIdx)

##Process test data
test_data <- get_data(data_path = "UCI HAR Dataset/test/X_test.txt", 
                       activity_path = "UCI HAR Dataset/test/y_test.txt",
                       subject_path = "UCI HAR Dataset/test/subject_test.txt",
                       featuresNames = features[,2],
                       featuresIdx = featuresIdx)

##Merge training and test set
data <- rbind(train_data, test_data)

##Apply activities labels and factor activities and subjects
data$activity <- factor(data$activity, levels = activities[,1], labels = activities[,2])
data$subject <- as.factor(data$subject)

##Generate mean data
mean_data <- aggregate(data, by = list(activity_m = data$activity, subject_m = data$subject), mean)
#Remove these two columns because they get set to NA after getting the mean data
mean_data['subject'] = NULL
mean_data['activity'] = NULL 

##Rename columns to more descriptive values
names <- names(mean_data)
names <- gsub('^t', 'Time ', names)
names <- gsub('^f', 'Frequency ', names)
names <- gsub('[-\\.]mean', ' Mean ', names)
names <- gsub('[-\\.]std', ' Standard Deviation ', names)
names <- gsub('Acc', ' Accelerometer ', names)
names <- gsub('Gyro', ' Gyroscope ', names)
names <- gsub('Mag', ' Magnitude ', names)
names <- gsub('JerkMag', 'Jerk Mag', names)
names <- gsub('[\\.*]', ' ', names)
names <- gsub('BodyBody', 'Body', names)
names(mean_data) <- names

#Write the mean data
write.table(mean_data, "tidy_data.txt", row.name=FALSE)