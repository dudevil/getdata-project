# Steps 1, 2, 4
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# I've decided to combine these steps, because it will result in a cleaner and more readable code 

# read feature names
feature.names <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors = F)[, 2]

# load training set components: features, subject, and activity with appropriate labels
train.subject <- read.table("UCI HAR Dataset//train/subject_train.txt", col.names = c("Subject"))
train.activity <- read.table("UCI HAR Dataset//train/y_train.txt", col.names = c("Activity"))
train.features <- read.table("UCI HAR Dataset//train/X_train.txt", col.names = feature.names)

# The following line only selects measurements of mean and standart deviation
# I've chosen not to include the last 6 features, as they represent the angle between some 
# measurement and gravity mean (see last section of features_info.txt).
train.features <- train.features[,grep("mean|std",colnames(train.features))]


# do the same for the test set
test.subject <- read.table("UCI HAR Dataset//test/subject_test.txt", col.names = c("Subject"))
test.activity <- read.table("UCI HAR Dataset//test/y_test.txt", col.names = c("Activity"))
test.features <- read.table("UCI HAR Dataset//test/X_test.txt", col.names = feature.names) 
test.features <- test.features[,grep("mean|std",colnames(test.features))]

# merge the resulting dataframes, first column-wise to obtain merged train and test sets
# then row-wise to merge the two sets
merged.dataset <- rbind(cbind(train.features, train.subject, train.activity), 
                        cbind(test.features, test.subject, test.activity))


# Step 3 
# Uses descriptive activity names to name the activities in the data set

# read the activity labels
activities = read.table("UCI HAR Dataset/activity_labels.txt")

# cast activity column to a factor with the appropriate levels and labels
merged.dataset[,"Activity"] <- factor(merged.dataset$Activity, 
                                      levels=activities$V1, 
                                      labels=activities$V2)

# Step 5
# From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

tidy.dataset <- aggregate(. ~ Activity + Subject, merged.dataset, FUN=mean)

write.table(tidy.dataset, "tidy_dataset.txt", row.name = FALSE)
