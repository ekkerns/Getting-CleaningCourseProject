# Getting-CleaningCourseProject
Data Science Specialization Course 3 Project

This is the course project for the Getting and Cleaning Data Coursera course. 
The R script, run_analysis.R, does the following:

Download the dataset at this url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Loads the training and test sets, pieces them together, and merges the two 
Loads the features and labels for the datasets and applys them to the merged set
Limits the merged dataset to just columns involving mean or std
Converts the activity and subject columns into factors
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt.

The codebook details the resulting variables in tidy.txt
