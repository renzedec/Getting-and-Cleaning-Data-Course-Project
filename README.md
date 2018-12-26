# Getting-and-Cleaning-Data-Course-Project

### Steps:
1. Download and unzip the data into your R working directory using this link:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
2. Download the R source code named run_analysis.R into your working directory.

3. Run the source code to generate the tidy data file.

### Data Set Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For more information, go to this link: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The X variable represents sensor data measured with waist-mounted smartphone from 30 volunteers. 
The Y variable represents the type of activity (six in total) the volunteers performed during recording.

### Goal
The goal of the project is to create an R script called run_analysis.R that does the following.

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive activity names.
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Repository Files

#### CodeBook.md
A code book that describes the variables, the data, and any transformations or work that is performed to clean up the data

#### run_analysis.R
The code for the R script used to complete the project goals

#### TidyData.txt
The output from the run_analysis.R code
