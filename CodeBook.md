## Transformation steps of the script 
#### 1. Step 1. Merges the training and the test sets to create one data set.

1.1 Get data from files:
- ```X_train.txt```
- ```Y_train.txt```
- ```subject_train.txt```
- ```X_test.txt```
- ```Y_test.txt```
- ```subject_test.txt```

1.2 Change names for Y and subject dataset:

- Y is _activity_
- subject is _subject_

1.3 Bind columns of X, Y and subject datasets for Train and Test data

1.4 Finally bind rows of Train and Test datasets. Save the result in **full_dataset**.

#### 2. Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

2.1 Get feature names from ```features.txt``` into dataset **features**.

2.2 Filter only features, that have "mean" or "std" in there names and save it in dataset **filtered_features** 
While creating dataset **filtered_features** add a field named "ds_col_names" with the value equal to "V" + "id of feature".
This field will be used to filter fields in **full_dataset**.

2.3 Create vector "ds_col_names" with names of columns, which we want to extract from full_dataset.
It includes fields "subject", "activity" and all values of "ds_col_names" vector (thats how we get only "mean" and "std" features from our dataset).

2.4 Subset **full_dataset** by selecting only columns from "ds_col_names" vector.
Save the result in **filtered_ds**.

#### 3. Step 3. Uses descriptive activity names to name the activities in the data set

3.1 Get activities from ```activity_labels.txt``` into dataset **activity_labels**.

3.2 Rename columns in **activity_labels** to "activity" and "activity_name" for more comfortable usage.

3.3. Merge **filtered_ds** with **activity_labels** by "activity" column. Reassign the result to **filtered_ds**.
We will get our filtered dataset with extra column called "activity_name" and values of activity labels.

#### 4. Step 4.Appropriately labels the data set with descriptive variable names.

4.1 Our dataset already have clear names for subject and activity, so we must rename all feature columns.
So we make the loop over names of **filtered_ds**, lookup for every name its value in **filtered_features**
(we created this dataset in step 2.2 and used it to filter columns in our full dataset) 
and change the name of **filtered_ds**. We change only feature columns, because **filtered_features** has only its codes.

#### 5. Step 5. From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.

5.1 Group **filtered_ds** by columns "subject", "activity" and "activity_name" and calculate "mean" for every feature column
Save the result in data set **tidy_data_set**

5.2. Finally write this data set in file ```tidy_data_set.txt```