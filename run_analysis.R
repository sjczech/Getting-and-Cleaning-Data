library(plyr)

file <- "uci_har.zip"
path <- "UCI HAR Dataset"

#functions
#read table from file and apply columns
retrieveTable <- function(filename, cols = NULL) {
  data <- data.frame()
  x <- unz(file, paste(path, filename, sep="/"))
  if(is.null(cols)){
    data <- read.table(x, sep = "", stringsAsFactors = FALSE)
  }
  else{
    data <- read.table(x, sep = "", stringsAsFactors = FALSE, col.names = cols)
  }
  data
}

#read dataset from file
retrieveDataset <- function(type, features){
    subject_data <- retrieveTable(paste(type,"/","subject_",type,".txt",sep=""),"id")
    y_data <- retrieveTable(paste(type,"/","y_",type,".txt",sep=""),"activity")    
    x_data <- retrieveTable(paste(type,"/","X_",type,".txt",sep=""),features$V2) 
    
    return (cbind(subject_data,y_data,x_data)) 
  } 

#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file, mode= "wb")
unzip(file)

#create column names for train and test datasets from features.txt
features <- retrieveTable("features.txt")

#load test and train datasets
train <- retrieveDataset("train",features)
test <- retrieveDataset("test",features)

#merge train and test datasets
merged_data <- rbind(train, test)

#rearrange the data using id
merged_data <- arrange(merged_data, id)

#assign labels for activities
activity_labels <- retrieveTable("activity_labels.txt")
merged_data$activity <- factor(merged_data$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#extract only the measurements on the mean and standard deviation 
dataset_std_mean <- merged_data[,c(1,2,grep("std", colnames(merged_data)), grep("mean", colnames(merged_data)))]

#save first dataset
write.table(dataset_std_mean, "dataset_std_mean.txt", row.names = FALSE)

#create a second dataset with the average of each variable for each activity and subject 
dataset_avg <- ddply(dataset_std_mean, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })

#append "_avg" to column names
colnames(dataset_avg)[-c(1:2)] <- paste(colnames(dataset_avg)[-c(1:2)], "_avg", sep="")

#save second dataset
write.table(dataset_avg, "dataset_avg.txt", row.names = FALSE)



