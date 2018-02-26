setwd("U:/General/Data_Scientist_Course/Course3/Project")

#Download and unzip
file<-"data.zip"
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, file)
unzip(file,unzip="internal")

#Load and put together training and test sets
        #train
        trainx <- read.table("UCI HAR Dataset/train/X_train.txt")
        trainy <- read.table("UCI HAR Dataset/train/Y_train.txt")
        trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
        train<-cbind(cbind(trainx,trainy),trainsubject)
        #test
        testx <- read.table("UCI HAR Dataset/test/X_test.txt")
        testy <- read.table("UCI HAR Dataset/test/Y_test.txt")
        testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
        test<-cbind(cbind(testx,testy),testsubject)
#Merges the training and the test sets to create one data set.
        mergedset<-rbind(train,test)
#Extracts only the measurements on the mean and standard deviation for each measurement.
        #import Features
        features<-read.table("UCI HAR Dataset/features.txt")
        #convert names to char 
        features[,2]<-as.character(features[,2])
        #add features as col names
        #add names of subject and activity to names listed in features
        allnames<-rbind(rbind(features,c(562,"Subject")),c(563,"ActivityID"))[,2]
        #attach to data set
        names(mergedset)<-allnames
        #Limit features to those with mean or std
        limitedset<-mergedset[,grepl("mean|std|Subject|ActivityID",names(mergedset))]
#Uses descriptive activity names to name the activities in the data set
        #import labels
        labels<-read.table("UCI HAR Dataset/activity_labels.txt")
        #convert names to char
        labels[,2]<-as.character(labels[,2])
        #use labels to factor activities
        limitedset$Activity<-factor(limitedset$ActivityID, levels=labels[,1],labels=labels[,2])
#Appropriately labels the data set with descriptive variable names.
        #make names valid
        names(limitedset)<-make.names(names(limitedset))
        #replace "..." with "."
        names(limitedset)<-gsub("*\\.\\.\\.*","\\.",names(limitedset))
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        library(plyr)
        #factor subject for melting on
        limitedset$Subject<-as.factor(limitedset$Subject)
        #get mean by subject and activity
        meanset<-ddply(limitedset, c("Subject","Activity"), numcolwise(mean))
        