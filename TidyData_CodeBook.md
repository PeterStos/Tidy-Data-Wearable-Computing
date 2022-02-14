Getting and Cleaning Data Course Project
================
10/02/2022

#### Loading files from TEST volunteers

Firstly the directory where **TEST** files were located was set as
working directory.

The **X\_test.txt** was read as table, adding the column names from the
file **features.txt**.

``` r
test_col_names <- read.table("features.txt", header = FALSE)
col_names <- c(test_col_names[,2])
x_test_df <- read.table("X_test.txt", col.names = col_names, header = FALSE)
```

#### Subjects and Activities

The following code reads **subjects** (volunteers) from subject\_test
file

``` r
subject_test <- read.table("subject_test.txt", col.names = "subject", header = FALSE)
```

Read column **activity** using y\_test file:

``` r
activity_test <- read.table("y_test.txt", col.names = "activity", header = FALSE)
activity_labels_test <- read.table("activity_labels.txt", col.names = c("activity", "labels"), header = FALSE)
```

Merge the columns activity and subject to the dataset **x\_test\_df**:

``` r
x_test_df <- data.frame(x_test_df, subject_test)
x_test_df <- data.frame(x_test_df, activity_test)
```

#### Creating dataset for TRAINING volunteers

The steps taken are the same as for TEST volunteers:

``` r
train_col_names <- read.table("features.txt", header = FALSE)
col_names <- c(train_col_names[,2])
x_train_df <- read.table("X_train.txt", col.names = col_names, header = FALSE)

subject_train <- read.table("subject_train.txt", col.names = "subject", header = FALSE)

activity_train <- read.table("y_train.txt", col.names = "activity", header = FALSE)
activity_labels_train <- read.table("activity_labels.txt", col.names = c("activity", "labels"), header = FALSE)

x_train_df <- data.frame(x_train_df, subject_train)
x_train_df <- data.frame(x_train_df, activity_train)
```

#### Merging Test and Training datasets

The dataset *x\_train\_df* and *x\_test\_df* are merged to create one
single dataset with all volunteers.  
This correspond to the step 1:  
**1. Merges the training and the test sets to create one data set**.

``` r
train_test_df <- rbind(x_train_df, x_test_df)
train_test_df <- as_tibble(train_test_df)
```

#### Extraction of mean and standard deviation for each measurement

The criteria adopted to select the columns with mean and standard
deviation was to select all column names that could contain the word
*mean* or *std*, plus subject and activity.  
This step correspond to the step 2:  
**2.Extracts only the measurements on the mean and standard deviation
for each measurement**.

``` r
train_test_mean_std <- select(train_test_df, contains(c("subject", "activity", "mean", "std"), ignore.case = TRUE))
head(train_test_mean_std)
```

    ## # A tibble: 6 x 88
    ##   subject activity tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z
    ##     <int>    <int>             <dbl>             <dbl>             <dbl>
    ## 1       1        5             0.289           -0.0203            -0.133
    ## 2       1        5             0.278           -0.0164            -0.124
    ## 3       1        5             0.280           -0.0195            -0.113
    ## 4       1        5             0.279           -0.0262            -0.123
    ## 5       1        5             0.277           -0.0166            -0.115
    ## 6       1        5             0.277           -0.0101            -0.105
    ## # ... with 83 more variables: tGravityAcc.mean...X <dbl>,
    ## #   tGravityAcc.mean...Y <dbl>, tGravityAcc.mean...Z <dbl>,
    ## #   tBodyAccJerk.mean...X <dbl>, tBodyAccJerk.mean...Y <dbl>,
    ## #   tBodyAccJerk.mean...Z <dbl>, tBodyGyro.mean...X <dbl>,
    ## #   tBodyGyro.mean...Y <dbl>, tBodyGyro.mean...Z <dbl>,
    ## #   tBodyGyroJerk.mean...X <dbl>, tBodyGyroJerk.mean...Y <dbl>,
    ## #   tBodyGyroJerk.mean...Z <dbl>, tBodyAccMag.mean.. <dbl>,
    ## #   tGravityAccMag.mean.. <dbl>, tBodyAccJerkMag.mean.. <dbl>,
    ## #   tBodyGyroMag.mean.. <dbl>, tBodyGyroJerkMag.mean.. <dbl>,
    ## #   fBodyAcc.mean...X <dbl>, fBodyAcc.mean...Y <dbl>, fBodyAcc.mean...Z <dbl>,
    ## #   fBodyAcc.meanFreq...X <dbl>, fBodyAcc.meanFreq...Y <dbl>,
    ## #   fBodyAcc.meanFreq...Z <dbl>, fBodyAccJerk.mean...X <dbl>,
    ## #   fBodyAccJerk.mean...Y <dbl>, fBodyAccJerk.mean...Z <dbl>,
    ## #   fBodyAccJerk.meanFreq...X <dbl>, fBodyAccJerk.meanFreq...Y <dbl>,
    ## #   fBodyAccJerk.meanFreq...Z <dbl>, fBodyGyro.mean...X <dbl>,
    ## #   fBodyGyro.mean...Y <dbl>, fBodyGyro.mean...Z <dbl>,
    ## #   fBodyGyro.meanFreq...X <dbl>, fBodyGyro.meanFreq...Y <dbl>,
    ## #   fBodyGyro.meanFreq...Z <dbl>, fBodyAccMag.mean.. <dbl>,
    ## #   fBodyAccMag.meanFreq.. <dbl>, fBodyBodyAccJerkMag.mean.. <dbl>,
    ## #   fBodyBodyAccJerkMag.meanFreq.. <dbl>, fBodyBodyGyroMag.mean.. <dbl>,
    ## #   fBodyBodyGyroMag.meanFreq.. <dbl>, fBodyBodyGyroJerkMag.mean.. <dbl>,
    ## #   fBodyBodyGyroJerkMag.meanFreq.. <dbl>, angle.tBodyAccMean.gravity. <dbl>,
    ## #   angle.tBodyAccJerkMean..gravityMean. <dbl>,
    ## #   angle.tBodyGyroMean.gravityMean. <dbl>,
    ## #   angle.tBodyGyroJerkMean.gravityMean. <dbl>, angle.X.gravityMean. <dbl>,
    ## #   angle.Y.gravityMean. <dbl>, angle.Z.gravityMean. <dbl>,
    ## #   tBodyAcc.std...X <dbl>, tBodyAcc.std...Y <dbl>, tBodyAcc.std...Z <dbl>,
    ## #   tGravityAcc.std...X <dbl>, tGravityAcc.std...Y <dbl>,
    ## #   tGravityAcc.std...Z <dbl>, tBodyAccJerk.std...X <dbl>,
    ## #   tBodyAccJerk.std...Y <dbl>, tBodyAccJerk.std...Z <dbl>,
    ## #   tBodyGyro.std...X <dbl>, tBodyGyro.std...Y <dbl>, tBodyGyro.std...Z <dbl>,
    ## #   tBodyGyroJerk.std...X <dbl>, tBodyGyroJerk.std...Y <dbl>,
    ## #   tBodyGyroJerk.std...Z <dbl>, tBodyAccMag.std.. <dbl>,
    ## #   tGravityAccMag.std.. <dbl>, tBodyAccJerkMag.std.. <dbl>,
    ## #   tBodyGyroMag.std.. <dbl>, tBodyGyroJerkMag.std.. <dbl>,
    ## #   fBodyAcc.std...X <dbl>, fBodyAcc.std...Y <dbl>, fBodyAcc.std...Z <dbl>,
    ## #   fBodyAccJerk.std...X <dbl>, fBodyAccJerk.std...Y <dbl>,
    ## #   fBodyAccJerk.std...Z <dbl>, fBodyGyro.std...X <dbl>,
    ## #   fBodyGyro.std...Y <dbl>, fBodyGyro.std...Z <dbl>, fBodyAccMag.std.. <dbl>,
    ## #   fBodyBodyAccJerkMag.std.. <dbl>, fBodyBodyGyroMag.std.. <dbl>,
    ## #   fBodyBodyGyroJerkMag.std.. <dbl>

#### Rename activity numbers to names

This step correspond to the step 2:  
**3.Uses descriptive activity names to name the activities in the data
set**

``` r
train_test_mean_std$activity[train_test_mean_std$activity == "1"] <- activity_labels_test$labels[1] 
train_test_mean_std$activity[train_test_mean_std$activity == "2"] <- activity_labels_test$labels[2]
train_test_mean_std$activity[train_test_mean_std$activity == "3"] <- activity_labels_test$labels[3]
train_test_mean_std$activity[train_test_mean_std$activity == "4"] <- activity_labels_test$labels[4]
train_test_mean_std$activity[train_test_mean_std$activity == "5"] <- activity_labels_test$labels[5]
train_test_mean_std$activity[train_test_mean_std$activity == "6"] <- activity_labels_test$labels[6]
```

#### Avarage of each variable for activity and subject

First the data set was grouped by subject and activity

``` r
group_train_test <- group_by(train_test_mean_std, subject, activity)
```

Then a *result* dataset was created to calculate the mean by activity
and subject **5. From the data set in step 4, creates a second,
independent tidy data set with the average of each variable for each
activity and each subject.**

``` r
result <- aggregate(group_train_test[,3:38], list(subject = train_test_mean_std$subject, activity = train_test_mean_std$activity), mean)
result <- as_tibble(result)
result_arranged <- (arrange(result, subject))
head(result_arranged, 24)
```

    ## # A tibble: 24 x 38
    ##    subject activity         tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean..~
    ##      <int> <chr>                        <dbl>             <dbl>            <dbl>
    ##  1       1 LAYING                       0.222          -0.0405           -0.113 
    ##  2       1 SITTING                      0.261          -0.00131          -0.105 
    ##  3       1 STANDING                     0.279          -0.0161           -0.111 
    ##  4       1 WALKING                      0.277          -0.0174           -0.111 
    ##  5       1 WALKING_DOWNSTA~             0.289          -0.00992          -0.108 
    ##  6       1 WALKING_UPSTAIRS             0.255          -0.0240           -0.0973
    ##  7       2 LAYING                       0.281          -0.0182           -0.107 
    ##  8       2 SITTING                      0.277          -0.0157           -0.109 
    ##  9       2 STANDING                     0.278          -0.0184           -0.106 
    ## 10       2 WALKING                      0.276          -0.0186           -0.106 
    ## # ... with 14 more rows, and 33 more variables: tGravityAcc.mean...X <dbl>,
    ## #   tGravityAcc.mean...Y <dbl>, tGravityAcc.mean...Z <dbl>,
    ## #   tBodyAccJerk.mean...X <dbl>, tBodyAccJerk.mean...Y <dbl>,
    ## #   tBodyAccJerk.mean...Z <dbl>, tBodyGyro.mean...X <dbl>,
    ## #   tBodyGyro.mean...Y <dbl>, tBodyGyro.mean...Z <dbl>,
    ## #   tBodyGyroJerk.mean...X <dbl>, tBodyGyroJerk.mean...Y <dbl>,
    ## #   tBodyGyroJerk.mean...Z <dbl>, tBodyAccMag.mean.. <dbl>,
    ## #   tGravityAccMag.mean.. <dbl>, tBodyAccJerkMag.mean.. <dbl>,
    ## #   tBodyGyroMag.mean.. <dbl>, tBodyGyroJerkMag.mean.. <dbl>,
    ## #   fBodyAcc.mean...X <dbl>, fBodyAcc.mean...Y <dbl>, fBodyAcc.mean...Z <dbl>,
    ## #   fBodyAcc.meanFreq...X <dbl>, fBodyAcc.meanFreq...Y <dbl>,
    ## #   fBodyAcc.meanFreq...Z <dbl>, fBodyAccJerk.mean...X <dbl>,
    ## #   fBodyAccJerk.mean...Y <dbl>, fBodyAccJerk.mean...Z <dbl>,
    ## #   fBodyAccJerk.meanFreq...X <dbl>, fBodyAccJerk.meanFreq...Y <dbl>,
    ## #   fBodyAccJerk.meanFreq...Z <dbl>, fBodyGyro.mean...X <dbl>,
    ## #   fBodyGyro.mean...Y <dbl>, fBodyGyro.mean...Z <dbl>,
    ## #   fBodyGyro.meanFreq...X <dbl>
