#all needed files are located in the SAME working directory that must be setup by calling setwd() properly
#Load col names
col_names <- read.table(file = "features.txt")

#Load TEST files

x_test <- read.table(file = "X_test.txt")       #main TEST set
y_test <- read.table(file = "Y_test.txt")       #activity TEST set
s_test <- read.table(file = "subject_test.txt") #subject TEST set

#set column names
names(x_test) <- col_names[,2]
names(y_test) <- c("activity")
names(s_test) <- c("subject")

#create new dataset adding activity and Subject columns to X TEST data
final_test <- x_test
final_test <- cbind(y_test, final_test)
final_test <- cbind(s_test, final_test)
#At this point the X test set contains 2 additional columns: activity and subject

#remove not needed columns: keep only -> subject, activity and any column with name std or mean. (DELIVERABLE #2)
toMatch <- "subject|activity|mean[(][)]|std[(][)]"
reduced_test <- final_test[,grepl(toMatch, colnames(final_test))]
#At this point reduced set contains the columns and rows needed

#Load TRAIN files

x_train <- read.table(file = "X_train.txt")       #main TRAIN set
y_train <- read.table(file = "Y_train.txt")       #activity TRAIN set
s_train <- read.table(file = "subject_train.txt") #subject TRAIN set

#set column names
names(x_train) <- col_names[,2]
names(y_train) <- c("activity")
names(s_train) <- c("subject")

#create new dataset adding activity and Subject columns to X TRAIN data
final_train <- x_train
final_train <- cbind(y_train, final_train)
final_train <- cbind(s_train, final_train)
#At this point the X train set contains 2 additional columns: activity and subject

#remove not needed columns: keep only -> subject, activity and any column with name std or mean. (DELIVERABLE #2)
reduced_train <- final_train[,grepl(toMatch, colnames(final_train))]
#At this point reduced set contains the columns and rows needed

#Merge the two datasets to a new one (DELIVERABLE #1)
combined_set <- rbind(reduced_test, reduced_train)

#replace activity codes with descriptive names (DELIVERABLE #3)
activities <- read.table(file = "activity_labels.txt")
names(activities) <- c("id", "description")

for (i in 1:nrow(combined_set))
{
  myID <- combined_set[i, 2]
  activityRow <- activities[which(activities$id == myID), ]
  combined_set[i, 2] <- activityRow[1,2]
}

#format column headers properly to display clean names (DELIVERABLE #4)
for (i in 1:ncol(combined_set)){
  colnames(combined_set)[i] <- gsub("-", "\\.", colnames(combined_set)[i])
  colnames(combined_set)[i] <- gsub("\\()", "", colnames(combined_set)[i])
  colnames(combined_set)[i] <- sub("^t", "time", colnames(combined_set)[i])
  colnames(combined_set)[i] <- sub("^f", "frequency", colnames(combined_set)[i])
}

#now combined_set is the final clean "raw" data (DELIVERABLE #1,2,3,4)
#group data by subject and activity and calculate average for each column (DELIVERABLE #5)

library(dplyr)

avg_set <- combined_set
avg_set <- avg_set %>% 
  group_by(subject, activity) %>% 
  summarize_all(mean)
#now avg_set contains a second, independent tidy data set with the average of each variable for each activity and each subject.