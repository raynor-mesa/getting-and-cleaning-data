## Merges test and training data sets  together, extracts the mean and
## standard deviations of each measurement, then creates tidy data sets from
## the relevant measurements


## Combines subject and activity identifiers for both sets into a single table
s1 <- read.table("train/subject_train.txt", col.names = c("SUBJECT"))
y1 <- read.table("train/y_train.txt", col.names = c("ACTIVITY"))
trainObs <- cbind(s1, y1)

s2 <- read.table("test/subject_test.txt", col.names = c("SUBJECT"))
y2 <- read.table("test/y_test.txt", col.names = c("ACTIVITY"))
testObs <- cbind(s2, y2)

## Reads in feature descriptors and uses it as a header for the datasets
features <- read.table("features.txt")
x1 <- read.table("train/X_train.txt", col.names = features[,2])
x2 <- read.table("test/X_test.txt", col.names = features[,2])


## 1. Adds the table of identifiers to the datasets, and unites them into one table
trainObs <- cbind(trainObs, x1)
testObs <- cbind(testObs, x2)
set <- rbind(trainObs, testObs)


## 2. Creates a new table that extracts only the mean and standard deviation
## measurements from the complete table
extracted <- set[,1:2]
vars <- names(set)
for (i in 3:563) { #loops through the table for desired measurements
        if (grepl("\\.mean\\.\\.|\\.std\\.\\.", vars[i])) {
                extracted <- cbind(extracted, colName = set[,i])
                k <- dim(extracted)
                colnames(extracted)[k[2]] <- vars[i]
        }
}


## 3. Replaces numerical activity identifiers with labels
activities <- read.table("activity_labels.txt")
activities$V2 <- as.character(activities$V2)
extracted$ACTIVITY <- as.character(extracted$ACTIVITY)
for (i in 1:6) {
        extracted$ACTIVITY <- gsub(i, activities$V2[i], extracted$ACTIVITY)
}


## 4. Assigns descriptive labels to the variables, by analyzing and clarifying
## current name
vars2 <- names(extracted)
for (i in 3:68) {
        label <- vector(mode = "character") #placeholder for new label
        
        if (grepl("^t", vars2[i])) { #distinguish between variables starting with t or f
                label <- paste(label, "Time", sep = "")
        } else label <- paste(label, "Frequency", sep = "") #Time and Frequency are mutually exclusive
        
        if (grepl("Body", vars2[i])) { #distinguish between body and gravity acceleration
                label <- paste(label, "Body")
        } else label <- paste(label, "Gravity") #Body and Gravity are mutually exclusive
        
        if (grepl("Acc", vars2[i])) { #distinguish between accelerometer and gyroscope signal
                label <- paste(label, "Accelerometer")
        } else label <- paste(label, "Gyroscope") #Accelerometer and Gyroscope are mutually exclusive
        
        if (grepl("Jerk", vars2[i])) {
                label <- paste(label, "Jerk")
        }
        if (grepl("Mag", vars2[i])) {
                label <- paste(label, "Magnitude")
        }
        
        if (grepl("\\.mean\\.\\.", vars2[i])) { #distinguish between mean and std measurements
                label <- paste(label, "Mean")
        } else label <- paste(label, "Standard Deviation") #Mean and Standard Deviation are mutually exclusive
        
        if (grepl("X$", vars2[i])) { #indicates axis for revant measurements
                label <- paste(label, "(X)")
        } else if (grepl("Y$", vars2[i])) {
                label <- paste(label, "(Y)")
        } else if (grepl("Z$", vars2[i])) {
                label <- paste(label, "(Z)")
        }
        
        names(extracted)[i] <- label
}


## 5. Creates a new, tidy dataset containing the average of each variable for
## each activity and subject
library(reshape2) #uses reshape2 to melt and reshape the dataset
melted <- melt(extracted, id = c("SUBJECT", "ACTIVITY"), measure.vars = names(extracted)[3:68])
tidy <- dcast(melted, SUBJECT + ACTIVITY ~ variable, mean)
write.table(tidy, file = "tidied_data.txt", row.names = FALSE)
