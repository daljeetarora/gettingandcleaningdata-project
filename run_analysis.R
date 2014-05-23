

#C:\\Amdocs\\Big Data\\Coursera\\Getting and Cleaning Data\\Project\\UCI HAR Dataset\\test

# Step 1
#read test data
X_test  = ".\\UCI HAR Dataset\\test\\X_test.txt"
y_test  = ".\\UCI HAR Dataset\\test\\y_test.txt"
subject_test  = ".\\UCI HAR Dataset\\test\\subject_test.txt"

X_test_tb <- read.table(X_test)
y_test_tb <- read.table(y_test)
subject_test_tb <- read.table(subject_test)


#bind the test data - data (features), activity codes & subject
test_data <- cbind(subject_test_tb, y_test_tb, X_test_tb)


#read train data
X_train  = ".\\UCI HAR Dataset\\train\\X_train.txt"
y_train  = ".\\UCI HAR Dataset\\train\\y_train.txt"
subject_train  = ".\\UCI HAR Dataset\\train\\subject_train.txt"

X_train_tb <- read.table(X_train)
y_train_tb <- read.table(y_train)
subject_train_tb <- read.table(subject_train)

#bind the train data - data (features), activity codes & subject
train_data <- cbind(subject_train_tb, y_train_tb, X_train_tb)

# combine the test & train dataset
test_train_dataset <- rbind(test_data, train_data)


#add the col names (from features.txt file) to the merged dataset
features.txt.file = ".\\UCI HAR Dataset\\features.txt"
features.txt.file_tb <- read.table(features.txt.file)


#extract only the names i.e. second column
features_txt_names <- features.txt.file_tb[, 2]

features_txt_names_df <- as.data.frame(features_txt_names)

features_txt_names_df <- t(features_txt_names_df)


colnames(test_train_dataset)[3:563] <- features_txt_names_df
colnames(test_train_dataset)[1:2] <- c("subject", "activity")


#extract the colums for std & mean
std_cols <- grep("*std()*", colnames(test_train_dataset))
mean_cols <- grep("*mean()*", colnames(test_train_dataset))

std_mean_cols <- c(1, 2, mean_cols, std_cols)

step2DataSet <- test_train_dataset[std_mean_cols]

#step3 data set

activity_labels = ".\\UCI HAR Dataset\\activity_labels.txt"
activity_labels_tb <- read.table(activity_labels)

#function to replace read the activity lable given activity code

getActivityLabel <- function(activityCode) {
    position <- match(activityCode, activity_labels_tb[, 1])  
  
    label <- activity_labels_tb[position, 2]
  
    label <- as.vector(label)
  
    label
}

i <- 1
for(i in 1:nrow(step2DataSet)) {
    activityCode <- step2DataSet[i, 2]

    activityLabel <- getActivityLabel(activityCode)

    step2DataSet[i, 2] <- activityLabel

}
#print(colnames(t4))

#step 3 completed  

#as.data.frame(step2DataSet[, mean(step2DataSet[,81])], by = c(subject, activity))

# step 5 -
activity_index <- 1
subject_index <- 1

avgDataSet <- data.frame()

for(activity_index in 1:nrow(activity_labels_tb)) {
    for(subject_index in 1:30) {      
      
      act_label <- activity_labels_tb[activity_index, 2]
      act_label <- as.vector(act_label)
      
      
      avgCalcDF <- step2DataSet[step2DataSet$activity == act_label & step2DataSet$subject == subject_index, ]
      variableMeans <- colMeans(avgCalcDF[3:81])
      # variableMeans is not a df ..Its Named num ..Convert to df .. we will use
      # it to rbind to form the final data set

      variableMeansdf <- as.data.frame(variableMeans)

      # variableMeansdf contains rows & one col .. so transpose it

      variableMeansdf <- t(variableMeansdf)

      subject_act_df <- data.frame(subject = subject_index, activity = act_label)
  
      avgDataSet_row <- cbind(subject_act_df, variableMeansdf)

      avgDataSet <- rbind(avgDataSet, avgDataSet_row)  
  }
}

#got the final tidy dataset/ write it into csv file
opfile_csv <- ".\\op.csv"
write.csv(avgDataSet, opfile_csv, row.names = FALSE, quote = FALSE)

