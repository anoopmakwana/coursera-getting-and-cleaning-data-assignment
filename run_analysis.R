library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

#Load activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

# As Character value
activityLabels[,2] <- as.character(activityLabels[,2])

#Load features
features <- read.table("UCI HAR Dataset/features.txt")

# As Character value
features[,2] <- as.character(features[,2])

# Extract the data on mean and std deviation
requiredFeatures <- grep(".*mean.*|.*std.*", features[,2])
requiredFeatures.names = features[requiredFeatures, 2]

#Replace patterns in names
requiredFeatures.names = gsub('-mean', 'Mean', requiredFeatures.names)
requiredFeatures.names = gsub('-std', 'Std', requiredFeatures.names)
requiredFeatures.names <- gsub('[-()]', '', requiredFeatures.names)


# Load the datasets
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")[requiredFeatures]
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainY, trainX)

testX <- read.table("UCI HAR Dataset/test/X_test.txt")[requiredFeatures]
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testY, testX)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", requiredFeatures.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# Write to File
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)