# Getting and Cleaning Data Course Project

This repository contains the R script needed to accomplish the tidying of the data from this article: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script performs the following steps:

1. If the data file doesn't exist, downloads and unzip the data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Loads the activities labels from the activity_labels.txt file
3. Loads the features labels from the features.txt file
4. Filters the features so that only the mean and standard deviation features are used
5. Loads the training and test data, merging them
6. Transforms the data applying a mean on the data, grouped by subject and activity
7. Renames the columns so they become more descriptive and less cryptic
8. Writes the resulting data to tidy_data.txt