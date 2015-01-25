# Getting and Cleaning Data Course Project
This repository contains code for the [Coursera Getting and Cleaning Data Course](https://class.coursera.org/getdata-010) Project.

  The goal of the project was to prepare a preprocessed tidy dataset from the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) dataset.

Our task was to create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The provided run_analysis.R script, assumes that the [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for the project has been downloaded and unzipped into the project root directory. 
The code also assumes that the current working directory is the project root directory.

The resulting tidy dataset is saved in the tidy_dataset.txt file, in a simple space-separated format.
One can load the dataset with the following `tidy_dataset <- read.table("tidy_dataset.txt", header = T)` R code.

The `run_analysis.R` script first loads the descriptive feature names from the `features.txt` file in the UCI HAR Dataset directory. Then the feature matrices, activity types and subject id are loaded and merged into a train and test dataframes. The feature matrices are filtered in such a way, that they only contain mean and standard deviation for each measurement (only features with names containing "mean" or "std" are selected. According to `features_info.txt` this should filter all means and standart deviations). 

The code further assignes human-readable activity labels from `activity_labels.txt` file, by adjusting the levels of the corresponding factor.

The final tidy dataset is constructed by aggregating each activity-subject combination and calculating the mean of the observations in a given group. The data is stored in a, so-called, long format.

