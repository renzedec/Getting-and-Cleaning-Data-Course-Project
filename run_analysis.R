library(dplyr)


# Obtain all necessary data 
features <- read.table('./UCI HAR Dataset/features.txt',header=FALSE);
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE); 
colnames(activity_labels) <- c("activityId","activityType");
subjectTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE); 
colnames(subjectTrain) <- "subjectId";
x_train <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE); colnames(x_train) <- 
  features[,2];
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE); colnames(y_train) <- 
  "activityId";
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
colnames(subject_test) <- "subjectId";
x_test <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE); colnames(x_test) <- 
  features[,2];
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE); colnames(y_test) <- 
  "activityId";

# Merge the train and test data to create one data set.
train_set = cbind(y_train,subjectTrain,x_train);
test_set = cbind(y_test,subject_test,x_test);

# Combine Training Data Set and Test Data Set into one Merged Data Set
merged_data = rbind(train_set,test_set);
columns <- colnames(merged_data);

# Extractaction of the measurements aon the mean and standard deviation for each measurement
vector <- (grepl("activity..",columns) | grepl("subject..",columns) | grepl("-mean..",columns) &
             !grepl("-meanFreq..",columns) & !grepl("mean..-",columns) | 
             grepl("-std..",columns) & !grepl("-std()..-",columns));

# Filter merged data according to the extracted mean and stdev
merged_data <- merged_data[vector==TRUE];

# Use descriptive activity names to name the activities in the data set
merged_data <- merge(merged_data,activity_labels,by='activityId',all.x=TRUE);
merged_data$activityId <-activity_labels[,2][match(merged_data$activityId, activity_labels[,1])] 

columns <- colnames(merged_data);

# Appropriate labeling the data set with descriptive variable names
for (i in 1:length(columns)) 
{
  columns[i] <- gsub("\\()","",columns[i])
  columns[i] <- gsub("-std$","StdDev",columns[i])
  columns[i] <- gsub("-mean","Mean",columns[i])
  columns[i] <- gsub("^(t)","time",columns[i])
  columns[i] <- gsub("^(f)","freq",columns[i])
  columns[i] <- gsub("([Gg]ravity)","Gravity",columns[i])
  columns[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",columns[i])
  columns[i] <- gsub("[Gg]yro","Gyro",columns[i])
  columns[i] <- gsub("AccMag","AccMagnitude",columns[i])
  columns[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columns[i])
  columns[i] <- gsub("JerkMag","JerkMagnitude",columns[i])
  columns[i] <- gsub("GyroMag","GyroMagnitude",columns[i])
};


colnames(merged_data) <- columns;

merged_data <- merged_data[,names(merged_data) != 'activityType'];

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(merged_data[,names(merged_data) 
                                    != c('activityId','subjectId')],by=list
                      (activityId=merged_data$activityId,
                        subjectId=merged_data$subjectId),mean);

# Output as text file 
write.table(tidyData, './TidyData.txt',row.names=FALSE,sep='\t')