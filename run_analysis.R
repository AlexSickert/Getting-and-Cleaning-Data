

# first we add the header to the data set. For doing this we read the table that contains the column names

columnNamesAll <-read.table("features.txt", header = FALSE )
colnames(columnNamesAll) <-c("id", "colName")

# as we do not want all columns we extract the relevant columns
# select sql/like relevant columns

library(sqldf) 

# we create two datasets - one that contains only the names and the other one that contains only the indexes of the columns
columnNamesIdsFiltered = sqldf('select id from columnNamesAll where colName like "%mean()%" or colName like "%std()%" ')
columnNamesFiltered = sqldf('select colName from columnNamesAll where colName like "%mean()%" or colName like "%std()%" ')

# then we load the observation data
dataTest <-read.table("X_test.txt", header = FALSE )
dataTrain <-read.table("X_train.txt", header = FALSE )

# we subset from the data the relevant columns as we want only mean and std
dataTestFiltered <- dataTest[, unlist(columnNamesIdsFiltered) ]
dataTrainFiltered <- dataTrain[, unlist(columnNamesIdsFiltered) ]

# to the filtered data we add the column headers
colnames(dataTestFiltered) <-unlist(columnNamesFiltered)
colnames(dataTrainFiltered) <-unlist(columnNamesFiltered)

# then we add the additional column that contains the subject who carried out the activity
subjectTest <-read.table("subject_test.txt", header = FALSE )
subjectTrain <-read.table("subject_train.txt", header = FALSE )

# give a column name
colnames(subjectTest) <-c("subject")
colnames(subjectTrain) <-c("subject")


# we merge the columns to the datasets
dataTestWithSubject <-  cbind(subjectTest, dataTestFiltered) 
dataTraintWithSubject <-  cbind(subjectTrain, dataTrainFiltered) 

# now we add the column that contain the type of the activity
activityTest <-read.table("y_test.txt", header = FALSE )
activiyTrain <-read.table("y_train.txt", header = FALSE )

# give a column name
colnames(activityTest) <-c("activity")
colnames(activiyTrain) <-c("activity")

# again we merge the two datasets
dataTestWithSubjectAndActivity <-  cbind(activityTest, dataTestWithSubject) 
dataTraintWithSubjectAndActivity <-  cbind(activiyTrain, dataTraintWithSubject) 

# now we merge the two big data sets test and training
mergedData <- rbind(dataTestWithSubjectAndActivity, dataTraintWithSubjectAndActivity) 

# now we need to convert the activity ids into real text labels
# add the activity names
activiyLabels <-read.table("activity_labels.txt", header = FALSE )

#set column names
colnames(activiyLabels) <-c("activity", "ActivityName")

# match activity labels with data set
completeData <- merge(activiyLabels, mergedData, by.x="activity", by.y="activity", all=TRUE)

# there is a unnecessary column and therefore we drop it
drops <- c("activity")
completeDataDoppedColumns <- completeData[,!(names(completeData) %in% drops)]

# now we create the mean on all columns except the first two columns as they contain the activity and subject - we group by activity and subject
x <- ncol(completeDataDoppedColumns)
averagesDataset <- aggregate(x = completeDataDoppedColumns[3:x], by = list(completeDataDoppedColumns$ActivityName, completeDataDoppedColumns$subject), FUN = "mean", simplify = TRUE)

# we need to re-name the first two columns as they changed there name from grouping
names(averagesDataset)[1]<-paste("Activity")
names(averagesDataset)[2]<-paste("Subject")

# data does not look so beautiful so we sort our output
averagesDatasetSorted <- averagesDataset[order(averagesDataset$Activity, averagesDataset$Subject), ]

#finally we write the output to a file
write.table(averagesDatasetSorted,"result.txt",row.names=F,col.names=T,sep=", ") 
  
