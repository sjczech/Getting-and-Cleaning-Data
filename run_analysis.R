library(plyr)

file <- "uci_har.zip"
path <- "UCI HAR Dataset"

#functions
#read data from file and apply columns
f1 <- function(filename, cols = NULL) {
  data <- data.frame()
  a <- unz(file, paste(path, filename, sep="/"))
  if(is.null(cols)){
    data <- read.table(a, sep = "", stringsAsFactors = FALSE)
  }
  else{
    data <- read.table(a, sep = "", stringsAsFactors = FALSE, col.names = cols)
  }
  data
}

#read dataset from file
f2 <- function(type, features){
    subject <- f1(paste(type,"/","subject_",type,".txt",sep=""),"id")
    y <- f1(paste(type,"/","y_",type,".txt",sep=""),"activity")    
    x <- f1(paste(type,"/","X_",type,".txt",sep=""),features$V2) 
    
    return (cbind(subject, y, x)) 
  } 

#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file, mode= "wb")
unzip(file)

#create column names for train and test datasets from features.txt
features <- f1("features.txt")

#load and merge test and train datasets
train <- f2("train",features)
test <- f2("test",features)
merged_data <- rbind(train, test)

#rearrange the data using id
merged_data <- arrange(merged_data, id)

#assign labels for activities
activity_labels <- f1("activity_labels.txt")
merged_data$activity <- factor(merged_data$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#subset the measurements on the mean and standard deviation 
dataset_std_mean <- merged_data[,c(1,2,grep("std", colnames(merged_data)), grep("mean", colnames(merged_data)))]

#create a second dataset with the average of each variable for each activity and subject 
dataset_avg <- ddply(dataset_std_mean, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })

#append "_avg" to column names
colnames(dataset_avg)[-c(1:2)] <- paste(colnames(dataset_avg)[-c(1:2)], "_avg", sep="")

#save both datasets to text
write.table(dataset_std_mean, "dataset_std_mean.txt", row.names = FALSE)
write.table(dataset_avg, "dataset_avg.txt", row.names = FALSE)
