# Load libraries
#install.packages("dplyr")
#install.packages("plyr")
#install.packages("tidyr")
#install.packages("tidyverse")
library(dplyr)
library(plyr)
library(tidyr)
library(tidyverse)

# TEST
# Set working directory for test files
setwd("C:/Users/peter/Documents/DataScience/Coursera/Cleaning Data/TidyData/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test")

# Load test files adding names to the columns using features files
# 4.Appropriately labels the data set with descriptive variable names.
test_col_names <- read.table("features.txt", header = FALSE)
col_names <- c(test_col_names[,2])
x_test_df <- read.table("X_test.txt", col.names = col_names, header = FALSE)

# Create column for the subjects tested
subject_test <- read.table("subject_test.txt", col.names = "subject", header = FALSE)

# Create column for the Activities (using y_test file)
activity_test <- read.table("y_test.txt", col.names = "activity", header = FALSE)
activity_labels_test <- read.table("activity_labels.txt", col.names = c("activity", "labels"), header = FALSE)

# Merge column subject and activity to x_test_df
x_test_df <- data.frame(x_test_df, subject_test)
x_test_df <- data.frame(x_test_df, activity_test)


# TRAIN
# Set working directory for train files
setwd("C:/Users/peter/Documents/DataScience/Coursera/Cleaning Data/TidyData/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train")

# Load train adding names to the columns using features files
# 4.Appropriately labels the data set with descriptive variable names.
train_col_names <- read.table("features.txt", header = FALSE)
col_names <- c(train_col_names[,2])
x_train_df <- read.table("X_train.txt", col.names = col_names, header = FALSE)

# Create column for the subjects tested
subject_train <- read.table("subject_train.txt", col.names = "subject", header = FALSE)

# Create column for the Activities (using y_train file)
activity_train <- read.table("y_train.txt", col.names = "activity", header = FALSE)
activity_labels_train <- read.table("activity_labels.txt", col.names = c("activity", "labels"), header = FALSE)

# Merge column subject and activity to x_train_df
x_train_df <- data.frame(x_train_df, subject_train)
x_train_df <- data.frame(x_train_df, activity_train)


# 1. Merge test and train data sets using rbind
train_test_df <- rbind(x_train_df, x_test_df)
train_test_df <- as_tibble(train_test_df)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
train_test_mean_std <- select(train_test_df, contains(c("subject", "activity", "mean", "std"), ignore.case = TRUE))
View(train_test_mean_std)

# 3.Uses descriptive activity names to name the activities in the data set
train_test_mean_std$activity[train_test_mean_std$activity == "1"] <- activity_labels_test$labels[1] 
train_test_mean_std$activity[train_test_mean_std$activity == "2"] <- activity_labels_test$labels[2]
train_test_mean_std$activity[train_test_mean_std$activity == "3"] <- activity_labels_test$labels[3]
train_test_mean_std$activity[train_test_mean_std$activity == "4"] <- activity_labels_test$labels[4]
train_test_mean_std$activity[train_test_mean_std$activity == "5"] <- activity_labels_test$labels[5]
train_test_mean_std$activity[train_test_mean_std$activity == "6"] <- activity_labels_test$labels[6]

View(train_test_mean_std)

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

# Group by subject and activity
group_train_test <- group_by(train_test_mean_std, subject, activity)

result<- aggregate(group_train_test[,3:38], list(subject = train_test_mean_std$subject, activity = train_test_mean_std$activity), mean)
result <- as_tibble(result)
result_arranged <- (arrange(result, subject))
result_arranged

# Create file to upload in Coursera
write.table(result_arranged, file = "run_analysis_result.txt", row.names = FALSE) 





