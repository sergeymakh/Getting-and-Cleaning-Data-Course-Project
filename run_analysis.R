library(dplyr) 
############### 1 ###############
# 1. Merges the training and the test sets to create one data set.

# getting data from files
X_train <- read.table("train\\X_train.txt")
Y_train <- read.table("train\\Y_train.txt")
subject_train <- read.table("train\\subject_train.txt")
X_test <- read.table("test\\X_test.txt")
Y_test <- read.table("test\\Y_test.txt")
subject_test <- read.table("test\\subject_test.txt")

# changing names for Y and subject cols datasets
names(Y_train)[1] = "activity"
names(subject_train)[1] = "subject"
names(Y_test)[1] = "activity"
names(subject_test)[1] = "subject"

# bind columns from subject, Y and X
train <- cbind(subject_train, Y_train, X_train)
test <- cbind(subject_test, Y_test, X_test)

# bind rows from train and test to make one dataset
full_dataset <- rbind(train, test)

############### 2 ###############
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# getting feature names
features <- read.table("features.txt")

# filter mean and std cols
filtered_features = features%>%filter(grepl("mean|std", V2))%>%mutate(ds_col_names = paste("V", V1, sep = ""))
ds_col_names <- unlist(filtered_features%>%select(ds_col_names))
ds_col_names <- c("subject", "activity", ds_col_names)
filtered_ds <- full_dataset[,ds_col_names]

############### 3 ###############
# 3. Uses descriptive activity names to name the activities in the data set

# getting activity names
activity_labels <- read.table("activity_labels.txt")
# renaming columns before merging with filtered_ds
names(activity_labels)[1] = "activity"
names(activity_labels)[2] = "activity_name"

# merge acivity labels with filtered dataset to get activity_names
filtered_ds <- merge(filtered_ds, activity_labels, by.x = "activity", by.y = "activity")

############### 4 ###############
# 4. Appropriately labels the data set with descriptive variable names.

# activity and subject cols are allready named,
# so naming feature cols
col_names <- names(filtered_ds)

# for every name of our dataset ...
for (i in 1:length(col_names))
{
  # ... looking for name by column code (by V1... Vn)
  new_name <- as.character(unlist(filtered_features%>%filter(ds_col_names == col_names[i])%>%select(V2)))
  # ... slightly clean name
  new_name <- gsub("[-()]", "", new_name)
  # ... changing names only for feature columns
  if (length(new_name) != 0)
    names(filtered_ds)[i] <- new_name
}

############### 5 ###############
# 5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

# creating summarised data set
tidy_data_set <- as.data.frame(filtered_ds%>%group_by(subject, activity, activity_name)%>%summarise_each(funs(mean)))

# writing tidy data set in file
write.table(tidy_data_set, file = "tidy_data_set.txt")