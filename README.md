## Contents of Getting and Cleaning Data Course Project repo
1. README.md - this file, explains the content of current repo
2. CodeBook.md - describes the variables, the data, and any transformations or work that scripts perform to clean up the data
3. run_analysis.R - the script, that performs transformation, described in CodeBook.md
4. tidy_data_set.txt - resulting data set

## Usage of script
1. Get data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip it contents to your working folder (you'll get the folder ```UCI HAR Dataset``` with data files in it)
3. Set working directory to the folder you created in step 2 (```UCI HAR Dataset```)
4. Run script ```source("run_analysis.R")```
5. The resulting file ```tidy_data_set.txt``` will apear in ```UCI HAR Dataset```

## Used libraries
- dplyr