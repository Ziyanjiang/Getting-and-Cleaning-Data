setwd("C:/Users/mikeh/Desktop/Coursera/UCI HAR Dataset/test")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
subtest <- read.table("subject_test.txt")
setwd("C:/Users/mikeh/Desktop/Coursera/UCI HAR Dataset")
features <- read.table("features.txt")
labels <- read.table("activity_labels.txt")
setwd("C:/Users/mikeh/Desktop/Coursera/UCI HAR Dataset/train")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
subtrain <- read.table("subject_train.txt")

#Uses descriptive activity names to name the activities in the data set
colnames(xtest) <- features$V2

colnames(ytest) <- "activity"
colnames(subtest) <- "ID"
xysubtest <- cbind(subtest, ytest, xtest)

#Uses descriptive activity names to name the activities in the data set
colnames(xtrain) <- features$V2

colnames(ytrain) <- "activity"
colnames(subtrain) <- "ID"
xysubtrain <- cbind(subtrain, ytrain, xtrain)

type <- rep("test", nrow(xysubtest))
testset <- cbind(type, xysubtest)
type <- rep("train", nrow(xysubtrain))
trainset <- cbind(type, xysubtrain)
set <- rbind(testset, trainset)

#Appropriately labels the data set with descriptive variable names.
for (i in 1:6)
set$activity[set$activity==i] <- labels[i, 2]

#Extracts only the measurements on the mean and standard deviation for each measurement.
colremain <- grepl("type|ID|activity|mean|std", colnames(set))
newset <- set[,colremain]

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
datafinal0 <- group_by(newset, type, ID, activity)
datafinal <- summarise_each(datafinal0, funs(mean))

write.table(datafinal, "tidy_data.txt",  row.name=FALSE)
