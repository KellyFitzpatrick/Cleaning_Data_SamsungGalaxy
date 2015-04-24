


###Set your working directory

setwd("C://Kelly/data/")
getwd()

###Load in the libraries that you need
library(plyr) # you must load plyr before dplyr
library(dplyr)
library(data.table)
library(tidyr)


###Load in General Informaion files

Activity<-read.table("activity_labels.txt",sep= " ", header=FALSE)
#V1 is the number 1 to 6 , V2 is the activity label


Measurements<-read.table("features.txt",sep= " ", header=FALSE)
#V1 is the number code , V2 is the feature label
# there are 561 different features


###Load in TEST INFORMATION

test_ID<-read.table("test/subject_test.txt",sep= " ", header=FALSE)
table(test_ID)  
#2,4,9,10,12,13,18,20,24 how are the train people  identified vector 1 to 2947
#there are 9 people in the train group
names(test_ID)<-"id" #rename column)#rename column

test_Activity<-read.table("test/y_test.txt",sep= " ", header=FALSE)
table(test_Activity)  
# 1 to 6 for the 6 activities vector 1 to 2947
names(test_Activity)<-"activity"   #rename column

test_dataset<-read.table("test/X_test.txt", header=FALSE)
dim(test_dataset)  # this is a 2947 rows and 561 columns 
names(test_dataset)<-Measurements[,2]

##############################TRAINING INFORMATION 

train_ID<-read.table("train/subject_train.txt",sep= " ", header=FALSE)
table(train_ID)  

#1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30
#how are the trained people identified 1 to 7352
# there are 21 people in the training group
names(train_ID)<-"id" #rename column

train_Activity<-read.table("train/y_train.txt",sep= " ", header=FALSE)
table(train_Activity)  
# 1 to 6 for the 6 activities vector 1 to 7352
names(train_Activity)<-"activity"  #rename column

train_dataset<-read.table("train/X_train.txt", header=FALSE)
dim(train_dataset) # this is 561 columns and 7352 rows
names(train_dataset)<-Measurements[,2]


##Edit the column names for test
names(test_dataset)<-sub("\\()-","",names(test_dataset))
names(test_dataset)<-sub("\\()","",names(test_dataset))
names(test_dataset)<-sub("\\,","",names(test_dataset))
names(test_dataset)<-sub("\\-","",names(test_dataset))
names(test_dataset)<-sub("\\(","",names(test_dataset))
names(test_dataset)<-sub("\\)","",names(test_dataset))
names(test_dataset)<-sub("\\)","",names(test_dataset))


names(test_dataset)<-tolower(names(test_dataset))

test_mean_vector<-grep("mean",names(test_dataset),value=TRUE)

test_mean_v<-grep("mean",names(test_dataset))
test_std_vector<-grep("std",names(test_dataset),value=TRUE)
test_std_v<-grep("std",names(test_dataset))
test_combo<-c(test_mean_v,test_std_v)

test_dataset<-test_dataset[,test_combo]



##Edit the column names for train
names(train_dataset)<-sub("\\()-","",names(train_dataset))
names(train_dataset)<-sub("\\()","",names(train_dataset))
names(train_dataset)<-sub("\\,","",names(train_dataset))
names(train_dataset)<-sub("\\-","",names(train_dataset))
names(train_dataset)<-sub("\\(","",names(train_dataset))
names(train_dataset)<-sub("\\)","",names(train_dataset))
names(train_dataset)<-sub("\\)","",names(train_dataset))

names(train_dataset)<-tolower(names(train_dataset))

mean_vector<-grep("mean",names(train_dataset),value=TRUE)

train_mean_v<-grep("mean",names(train_dataset))
train_std_vector<-grep("std",names(train_dataset),value=TRUE)
train_std_v<-grep("std",names(train_dataset))
train_combo<-c(train_mean_v,train_std_v)

train_dataset<-train_dataset[,train_combo]



###Start Merging the files and making a tidy dataset
##Merge Train Files

train_ID_DT<-data.table(x=c(1:7352),train_ID)
train_Activity_DT<-data.table(x=c(1:7352),train_Activity)
train_dataset_DT<-data.table(x=c(1:7352),train_dataset)
setkey(train_ID_DT,x);setkey(train_Activity_DT,x);setkey(train_dataset_DT,x)

TRAIN1<-merge(train_ID_DT,train_Activity_DT)

setkey(TRAIN1,x);setkey(train_dataset_DT,x)
TRAIN2<-merge(TRAIN1,train_dataset_DT)


##Merge Test Files

test_ID_DT<-data.table(x=c(1:2947),test_ID)
test_Activity_DT<-data.table(x=c(1:2947),test_Activity)
test_dataset_DT<-data.table(x=c(1:2947),test_dataset)
setkey(test_ID_DT,x);setkey(test_Activity_DT,x);setkey(test_dataset_DT,x)

TEST1<-merge(test_ID_DT,test_Activity_DT)

setkey(TEST1,x);setkey(test_dataset_DT,x)
TEST2<-merge(TEST1,test_dataset_DT)


##Final Merge Test and Train Files

Final_Merge<-rbind(TEST2,TRAIN2)
dim(Final_Merge)
names(Final_Merge)
head(Final_Merge)

#+2947+7352 = 10,299 final rows
# 89 columns

#write.csv(Final_Merge,"C://Kelly/Data/FinalMerge.csv")

###Formating the Final_Merged file-putting in the 6 Activity Names
#get rid if column x duplicate values
#Change Activities 1-6 to their names

Final_Merge<-select(Final_Merge,-x)#gets rid of the x column



#Order on activity in from 1 to 6 before you change the numbers to characters
Final_Merge_OrderA<-arrange(Final_Merge,activity)
vector_activity_numbers<-Final_Merge_OrderA$activity #getting vector of numbers
vector_activity_names<-Activity[,2]  # getting list of names
activitynames<-vector_activity_names[vector_activity_numbers]

Final_Merge_Activity<-cbind(activitynames,Final_Merge_OrderA)

Final_Merge_Activity<-select(Final_Merge_Activity,-activity) #delete duplicate columnns
dim(Final_Merge_Activity)
head(Final_Merge_Activity)

#formating the variables or columns so Measurements are in one column

Melted_Data<-gather(Final_Merge_Activity,measurement,value,tbodyaccmeanx:fbodybodygyrojerkmagstd)
Melted_Data<-Melted_Data%>% select(id,activitynames,measurement,value)%>%arrange(id)



###Average of each variable for each activity and each subject

Grouping<-Melted_Data%>%
   group_by(id,activitynames,measurement) %>%
  summarize(meanvalue= mean(value))%>% 
print

write.csv(Grouping,"C://Kelly/Data/Grouping.csv")
write.table(Grouping,"C://Kelly/Data/Grouping.txt",row.names=FALSE)