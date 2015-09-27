
rm(list=ls()) # clear all lists
library(reshape2) # load library for melt function

# Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement. 
features_mean_and_stdv <- grep(".*mean.*|.*std.*", features[,2])
features_mean_and_stdv.names <- features[features_mean_and_stdv,2] # get the names from features along features_mean_and_stdv indices
features_mean_and_stdv.names = gsub('-mean', 'Mean', features_mean_and_stdv.names) # Replace mean
features_mean_and_stdv.names = gsub('-std', 'Std', features_mean_and_stdv.names) # Replace std
features_mean_and_stdv.names <- gsub('[-()]', '', features_mean_and_stdv.names) # Remove [-()]

# Load the datasets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_mean_and_stdv]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData <- cbind(trainSubjects, train_activities, x_train)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_mean_and_stdv]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSubjects, test_activities, x_test)

# Merges the training and the test sets to create one data set.
# Appropriately labels the data set with descriptive variable names. 
finalData <- rbind(trainData, testData)
colnames(finalData) <- c("subject", "activity", features_mean_and_stdv.names)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
finalData$activity <- factor(finalData$activity, levels = activityLabels[,1], labels = activityLabels[,2]) # for all data use the levels 1 to 6 to create a vector with the corresponding acitivity labels
finalData$subject <- as.factor(finalData$subject)

finalData.melted <- melt(finalData, id = c("subject", "activity"))
finalData.mean <- dcast(finalData.melted, subject + activity ~ variable, mean)

write.table(finalData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
