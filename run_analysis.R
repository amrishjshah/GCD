#Getting and Cleaning Data Course Work

#Problem 1: Merges the training and the test sets to create one data set
#Algorithm
#1. Read the data files received from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into data frames
#2. Update data frames with appropriate headers
#3. Merge various training data sets into single data frame
#4. Repeat above steps for test data sets
#5. Merge Training and Test data sets into single set


#setting working directory to data files
setwd ('./RProg/CourseWork/UCI HAR Dataset/');

#read training data files
featuresList = read.table('./features.txt',header=FALSE);
activityName = read.table('./activity_labels.txt',header=FALSE);
subjectTrain = read.table('./train/subject_train.txt',header=FALSE);
xTrainingSet = read.table('./train/x_train.txt',header=FALSE);
xTrainingLabels = read.table('./train/y_train.txt',header=FALSE);

#Add column names
colnames(activityName)=c('activityId','activityType');
colnames(subjectTrain)="subjectId";
colnames(xTrainingSet)=featuresList[,2];
colnames(xTrainingLabels)="activityId";

#Merge training dataset into single file
trainingDataset = cbind(xTrainingLabels,subjectTrain,xTrainingSet);
#=========================================
#read test data files
subjectTest = read.table('./test/subject_test.txt',header=FALSE);
xTestSet = read.table('./test/x_test.txt',header=FALSE);
xTestLabels = read.table('./test/y_test.txt',header=FALSE);

#Add column names
colnames(subjectTest)="subjectId";
colnames(xTestSet)=featuresList[,2];
colnames(xTestLabels)="activityId";

#Merge test dataset into single file
testDataset = cbind(xTestLabels,subjectTest,xTestSet);
#=========================================
#Merge training and test data set into one dataset
trainingTestDataset = rbind(trainingDataset,testDataset);

#trainingTestDataset is single data set with merged output

#Problem 2: Extracts only the measurements on the mean and standard deviation for each measurement
#Algorithm
#1. Create a list of column names to derive mean and standard deviation
#2. Create a list of True values for ID, mean, and standard deviation and false for others
#3. Create a subset of final dataset (TrainingTestDataset) to include only the required columns along with the mean and standard deviation

columnNames = colnames (trainingTestDataset);
columnArray = (grepl("activity..",columnNames) | grepl("subject..",columnNames) | grepl("-mean..",columnNames) & !grepl("-meanFreq..",columnNames) & !grepl("mean..-",columnNames) | grepl("-std..",columnNames) & !grepl("-std()..-",columnNames));
trainingTestDataset = trainingTestDataset[columnArray==TRUE];


#Problem 3: Uses descriptive activity names to name the activities in the data set
#Algorithm
#1. Use the descriptive names available in activity labels file by merging the final dataset with the activity labels file on activityID key

trainingTestDataset = merge(trainingTestDataset,activityName,by='activityId',all.x=TRUE);



