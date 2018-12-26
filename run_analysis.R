library(dplyr)

# Obtain all necessary data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the train and test data to create one data set.
X <- rbind(X_train,X_test)
Y <- rbind(Y_train,Y_test)
subject <- rbind(subject_train,subject_test)

# Extractaction of the measurements on the mean and standard deviation for each measurement
features_selected <- features[grep("mean|std",features[,2]),]
X <- X[,features_selected[,1]]

# Uses descriptive activity names to name the activities in the data set
colnames(Y) <- "label"
Y$activity <- factor(Y$label, labels = as.character(activity_labels[,2]))
activity <- Y$activity

# Appropriate labeling the data set with descriptive variable names
colnames(X) <- features[features_selected[,1],2]

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(subject) <- "subject"
combine <- cbind(X, activity, subject)
combine2 <- group_by(combine,activity, subject)
tidy <- summarize_all(combine2,funs(mean))

# Ouput into TidyData.txt
write.table(tidy, file = "./TidyData.txt", row.names = FALSE, col.names = TRUE)

