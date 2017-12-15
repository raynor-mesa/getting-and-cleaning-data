# Getting and Cleaning Data Course Project - Tidy Data
## Breakdown of "run_analysis.r" script

### 1. Merges the training and the test sets to create one data set.
The "run_analysis.r" script is placed within the "UCI HAR Dataset" directory, and is thus assumed
to be able to read all relevant .txt files from their default placement. The script begins by reading
into R the "subject" and "y" .txt files from both the "train" and "test" folders, to use as observation
identifiers in the datasets. The "x" .txt files which contain the observations of the two datasets are 
then read into R, with the "features.txt" file providing headers for each variable in the dataset. With 
each .txt file properly read into R, these are all combined into a single dataset containing all observations 
and variables.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
The script then extracts the mean and standard deviation of each measurement into a new, smaller table.
The subject and activity identifier columns are preserved entirely and extracted first. The script then
uses a for loop to iterate across the variable columns. The "features.txt" file indicates that the mean
and standard deviations of each measurement are recorded as separate variables marked by "mean()" and
"std()", respectively. The for loop then simply checks each variable's name for those strings, and copies
the appropriate variables into the new table.

### 3. Uses descriptive activity names to name the activities in the data set.
The "activity_labels.txt" file contains a table matching the numerical activity identifiers to a string label.
Thus, the file is read into R, and a simple for loop reads down the ACTIVITY column and replaces all numbers 
with their matching label.

### 4. Appropriately labels the data set with descriptive variable names.
The "features_info.txt" file describes the measurements recorded in the dataset, which are abbreviated in 
the vector contained in the "features.txt" file which provides the dataset's header. These abbreviations 
are expanded for clarity's sake; a for loop passes through each column name and replaces each abbreviation 
with a full word to more completely describe the variable. A full list of expanded abbreviations and their 
meanings is contained in the "CODEBOOK.md" file.

### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The relabeled dataset is reshaped and simplified using the R library "reshape2," making use of the melt()
and dcast() functions. The dataset is passed into the melt() function, again keeping SUBJECT and ACTIVITY 
as the identifiers. The melted dataset is then reshaped by dcast(), simply finding the mean of every variable
for each combination of subject and activity, written into a tidy dataset named "tidied_data.txt".

### Conclusion
Given the original data files, containing two separate datasets representing over 10,000 observations of 561
variables, "run_analysis.r" cleans and simplifies the sets into a table of 180 observations over 66 variables: 
30 subjects performing 6 different activities, recording the averages of the mean and standard deviation of
several observations of 33 different measurements.
