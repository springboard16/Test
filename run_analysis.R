

## Reading the data from source

x_test<-read.table("~/samsung/samsung/samsung/test/X_test.txt", quote="\"", comment.char="")

y_test<- read.table("~/samsung/samsung/samsung/test/y_test.txt", quote="\"", comment.char="")

x_train<-read.table("~/samsung/samsung/samsung/train/X_train.txt", quote="\"", comment.char="")

y_train<-read.table("~/samsung/samsung/samsung/train/y_train.txt", quote="\"", comment.char="")

subject_test<-read.table("~/samsung/samsung/samsung/test/subject_test.txt", quote="\"", comment.char="")

subject_train<-read.table("~/samsung/samsung/samsung/train/subject_train.txt", quote="\"", comment.char="")

features<-read.table("~/samsung/samsung/samsung/features.txt", quote="\"", comment.char="")

activity_labels <- read.table("~/samsung/samsung/samsung/activity_labels.txt", quote="\"", comment.char="")
names(activity_labels) <- c("ActivityLabel", "ActivityName")

Subject_merged<-rbind(subject_test, subject_train)
names(Subject_merged)<- c("subject")

X_merged<-rbind(x_test, x_train )
names(X_merged) <- make.names(features$V2, unique = TRUE, allow_ = TRUE )

y_merged<-rbind(y_test, y_train)
names(y_merged)<- c("ActivityLabel")

##1.Merge the training and the test sets to create one data set
merged_data <- cbind(Subject_merged, y_merged) %>%
  left_join(activity_labels) %>%
  cbind(X_merged)

##2. Extract columns containing mean and standard deviation for each measurement
mean_stdn <- merged_data %>% select(contains("mean"), contains("std"))


##3. Create Varibales ActivityLabel and ActivityName that label 
## all observations with the corresponding activity labels 
## and names respectively.
names(activity_labels) <- c("ActivityLabel", "ActivityName")
merged_data <- cbind(Subject_merged, y_merged) %>%
  left_join(activity_labels) %>%
  cbind(X_merged)

##4.From the  previous data set in step 3, creates a second, independent 
## tidy data set with the average of each variable for each activity 
## and each subject.

tidy_data <-merged_data %>% 
  group_by(subject,ActivityName) %>% 
  summarise_each(funs(mean))

