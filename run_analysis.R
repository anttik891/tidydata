library(dplyr)
library(tidyr)

if(!file.exists("projectData.ZIP")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url = fileurl,destfile = "projectData.ZIP") 
        print("Zip file downloaded")
        datedownloaded <- date()
}
if (!file.exists("UCI HAR Dataset")){
        unzip("projectData.ZIP",exdir = getwd())
}


features <- readLines("./UCI HAR Dataset/features.txt")
test_x <- readLines("./UCI HAR Dataset/test/X_test.txt")
test_activities <- readLines("./UCI HAR Dataset/test/Y_test.txt")
test_subject <- readLines("./UCI HAR Dataset/test/subject_test.txt")

train_x <- readLines(".//UCI HAR Dataset/train/X_train.txt")
train_activities <- readLines(".//UCI HAR Dataset/train/Y_train.txt")
train_subject <- readLines("./UCI HAR Dataset/train/subject_train.txt")

allsubjects <- c(as.numeric(test_subject),as.numeric(train_subject))

#convert activities to strings
allactivities <- c(test_activities,train_activities)
allactivities <- sub("1","walking",allactivities)
allactivities <- sub("2","walkingupstairs",allactivities)
allactivities <- sub("3","walkingdownstairs",allactivities)
allactivities <- sub("4","sitting",allactivities)
allactivities <- sub("5","standing",allactivities)
allactivities <- sub("6","laying",allactivities)

#function to loop trough every line and turn a strings
#into a numeric data.frame
clean <- function(x){
        x <-sapply(x, strsplit, split =" ")
        dframe  <- NULL
        for (i in x){
                good <-i[]!=""
                if(is.null(dframe)){
                        dframe <- data.frame()
                }
                dframe <- rbind(dframe,as.numeric(i[good]))
        }
     dframe       
}


test_x <- clean(test_x)
train_x <- clean(train_x)
colnames(test_x) <- features
colnames(train_x) <- features
data <- rbind(test_x,train_x)

wantedcolumns <- sort(c(grep("mean",features),grep("std",features)))
datasubset <- data[,colnames(data)[wantedcolumns]]
datasubset <- mutate(datasubset,subject = allsubjects)
datasubset <- mutate(datasubset,activity = allactivities)

datasubset <- tbl_df(datasubset)
frequencies <- grep(pattern = "Freq",x = colnames(datasubset))
datasubset <- select(datasubset,choices = -(frequencies))

colnames(datasubset) <- tolower(colnames(datasubset))
# for loop to remove all numbers from variable naes
for(i in 1:3){
colnames(datasubset) <- sub(" ", "", colnames(datasubset))
colnames(datasubset) <- sub("0", "", colnames(datasubset))
colnames(datasubset) <- sub("1", "", colnames(datasubset))
colnames(datasubset) <- sub("2", "", colnames(datasubset))
colnames(datasubset) <- sub("3", "", colnames(datasubset))
colnames(datasubset) <- sub("4", "", colnames(datasubset))
colnames(datasubset) <- sub("5", "", colnames(datasubset))
colnames(datasubset) <- sub("6", "", colnames(datasubset))
colnames(datasubset) <- sub("7", "", colnames(datasubset))
colnames(datasubset) <- sub("8", "", colnames(datasubset))
colnames(datasubset) <- sub("9", "", colnames(datasubset))
colnames(datasubset) <- sub("\\(", "", colnames(datasubset))
colnames(datasubset) <- sub("\\)", "", colnames(datasubset))
}


## step 5 of the project, the smaller dataset
by_activity <- split(datasubset, datasubset$activity)

finalset <- data.frame()
for(act in by_activity){
        by_subject <- split(act, act$subject)
        
        activitydf <- data.frame()
        #suppress splits of data into singe rows
        for(sub in by_subject){
                activename <- sub[1,"activity"]
                values <- select(sub, -activity)
                columns <- colnames(values)
                valuerow <- colMeans(values)               
                activitydf <- rbind(activitydf, valuerow)
                colnames(activitydf) <- columns
        }
        activitydf <- mutate(activitydf, activity = activename)
      finalset <- rbind(finalset, activitydf)
}

#return the final tidy dataset
finalset




