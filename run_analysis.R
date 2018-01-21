#1) A tidy data set as described below
#2) A link to Github repository with your script for performing the analysis
#3) A code book that describes the variables, the data, and any transformations
#or work that you perfromed to clean up the data called "CodeBook.md"
#Also, include a README.md in the repo with your scripts. This repo explains
#how all of the scripts work and how they are connected.

#Preparing the downloaded file
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCIdata.zip"
dir <- "UCI HAR Dataset"

if(!file.exists(zipfile)){
	download.file(url,zipfile, mode="wb")
}

if(!file.exists(dir)){
	unzip(zipfile,files=NULL,exdir".")
}

#Read the data

subject_test <- read.table(paste(dir,"/test/subject_test.txt",sep=""))
subject_train <- read.table(paste(dir,"/train/subject_train.txt",sep=""))
x_test <- read.table(paste(dir,"/test/X_test.txt",sep=""))
y_test <- read.table(paste(dir,"/test/y_test.txt",sep=""))
x_train <- read.table(paste(dir,"/train/X_train.txt",sep=""))
y_train <- read.table(paste(dir,"/train/y_train.txt",sep=""))
activity_labels <- read.table(paste(dir,"/activity_labels.txt",sep=""))
features <- read.table(paste(dir,"/features.txt",sep=""))

#Make one R script called run_analysis.R that does the following:
#1) Merges the training and the test sets to create one data set
x_data <- rbind(x_train,x_test)
subject_data <- rbind(subject_train, subject_test)
y_data <- rbind(y_train,y_test)

#2) Extracts only the measurements on the mean and standard deviation for each 
#measurement
meanandstd<- grep("mean() |std()",features[,2])
x_data <- x_data[,meanandstd]

#3) and 4) Use descriptive activity names to name the activities in the data set and Appropriately labels the data set with descriptive variable names

featurenames <- sapply(features[,2],function(x){gsub("[()]","",x)})
names(x_data) <- featurenames[meanandstd]
names(subject_data) <- 'subject'
names(y_data)<- 'activity'

data <- cbind(subject_data,y_data,x_data)

act <- factor(data$activity)
levels(act) <- activity_labels[,2]
data$activity <- act

#5) From the data set in step 4, creates a second, independently tidy data set with the
#average of each variable for each activity and each subject

if(!"reshape2" %in%% installed.packages()){
	install.packages("reshape2")
}

library("reshape2")

MeltedData <- melt(data,(id.vars=c("subject","activity")))
SecondDataSet <- dcast(MeltedData, subject + activity ~ variable, mean)
names(SecondDataSet)[-c(1:2)] <- paste ("[mean of]", names(SecondDataSet)[-c(1:2)])
write.table(SecondDataSet,"tidy_data.txt",sep=",")
