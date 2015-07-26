# Getting-and-Cleaning-Data

The purpose of this project is to create a script that cleans up untidy data from an experiment regarding human activity recognition by smartphones. The original, untidy data can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The zip file includes folders for test and train datasets

run_analysis.R accomplishes the following:

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each 	subject.


To generate the two datasets,run the script run_analysis.R
Package plyr is required to run the script successfully.

1.  loads plyr package
2.  assigns "uci_har.zip" to a variable named file
3.  assigns "UCI HAR Dataset" to a variable named path
4.  defines f1 function, which reads data and applies columns
5.  defines f2 function, which reads datasets from the file
6.  downloads and unzips data
7.  creates column names from features.txt 
8.  loads data for test and train datasets and merges them
9.  arranges the data in the merged dataset using id
10. applies desccriptive labels for activities
11. creates dataset_std_mean, which contains only the measurements for standard deviation and mean
12. creates dataset_avg, which only contains measurements of each variable for each activity and subject, from dataset_std_mean and modifies column names
13. writes dataset_std_mean and dataset_avg to text files

dataset_std_mean will have 81 columns and 10,299 rows

dataset_avg will have 81 columns and 180 rows


