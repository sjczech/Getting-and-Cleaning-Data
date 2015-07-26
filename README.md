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

1.  The script loads plyr
2.  assigns "uci_har.zip" to a variable named file
3.  assigned "UCI HAR Dataset" to a variable named path
4.  defines functions for retrieveTable and retrieveDataset, which retrieve columns and values from the data in the zip files.
5.  downloads and unzips data
6.  creates column names from features.txt using retrieveTable function
7.  loads data for test and train datasets using retrieveDataset function
8.  merges the test and train datasets using rbind
9.  arranges the data in the merged dataset using id
10. applies desccriptive labels for activities
11. creates dataset_std_mean, which contains only the measurements for standard deviation and mean
12. writes dataset_std_mean to text file
13. creates dataset_avg, which only contains measurements of each variable for each activity and subject
14. appends column names in dataset_avg with _avg
15. writes dataset_std_mean to text file

dataset_std_mean will have 81 columns and 10,299 rows
dataset_avg will have 81 columns and 180 rows


