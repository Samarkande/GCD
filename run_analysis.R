
## The code is according to the "Getting and Cleaning Data" project of Coursera.
## This project is to read the data sets from the "Human Activity Recognition Using Smartphones"
## (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),
## to perform an analysis and to compute an output tidy data set. 

if(!dir.exists('./Data')){
  dir.create('./Data')
}

if(!file.exists('./Data/mydata.zip')){
fileUrl<- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl,destfile='./Data/mydata.zip',mode = 'wb')
unzip('./Data/mydata.zip')
}

if (!require('data.table')) {
  install.packages('data.table')
}

if (!require('reshape2')) {
  install.packages('reshape2')
}

require('data.table')
require('reshape2')

# Read Xtrain and Xtest
x_train<-read.table('./UCI HAR Dataset/train/X_train.txt')
x_test<-read.table('./UCI HAR Dataset/test/X_test.txt')
# Read features data
features<-read.table('./UCI HAR Dataset/features.txt')
# Assign the x_train and x_test column names 
colnames(x_train)<-colnames(x_test)<-features[,2]
# Search mean and std measurements 
Ch_features<-grepl('mean|std',features[,2])
# Choose mean and std measurements on x_train/test
x_train<-x_train[,Ch_features]
x_test<-x_test[,Ch_features]

# Read ytrain and ytest
y_train<-read.table('./UCI HAR Dataset/train/Y_train.txt')
y_test<-read.table('./UCI HAR Dataset/test/y_test.txt')
# Read activity labels data
activity_labels<-read.table('./UCI HAR Dataset/activity_labels.txt')
# Assign the corresponding activity ID<->Label
y_train<-cbind(y_train,activity_labels[y_train[,1],2])
y_test<-cbind(y_test,activity_labels[y_test[,1],2])
# Assign the index and labels activities column names
colnames(y_test)<-colnames(y_train)<-c('Activity_ID','Activity_Labels')

# Read subject_test data
subject_test<-read.table('./UCI HAR Dataset/test/subject_test.txt')
# Assign the subject_test column name
colnames(subject_test)<-'Subjects'
# Read subject_train data
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
# Assign the subject_train column name
colnames(subject_train) = 'Subjects'
# Train and Test data 
TRAIN<-cbind(subject_train,y_train,x_train)
TEST<-cbind(subject_test,y_test,x_test)

# Merge train and test data
DATA<-rbind(TRAIN,TEST)
Labels<-c('Subjects','Activity_ID','Activity_Labels')
#Take into account variables without the above labels 
Var<-setdiff(colnames(DATA),Labels)
#Melt the data
MELT<-melt(DATA,id=Labels,measure.vars=Var)
# Mean values according to subjects and activities
mytidydata<-dcast(MELT, Subjects+Activity_Labels ~ variable, mean)
# Write the result
write.table(mytidydata,row.names=F,quote=F,file = './mytidydata.txt')
