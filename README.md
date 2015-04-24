# Cleaning_Data_SamsungGalaxy
This is my R code, README file and code book for the Coursera Cleaning Data Project

This will walk you through the process of how I went from the origianl data files to the finalized product of tidy data.

All three main objectives of tidy data analysis were met.
#1) Each variable forms a column
#2) Each observation forms a row
#3) Each type of observational unit forms a table

Additional reading can be found at:http://vita.had.co.nz/papers/tidy-data.pdf


Process and Method of the code:
1. The inital stage lets the user set the working directory
2. The libraries are loaded that R will need

3a. The general information files are uploaded.
3b. The first file is the activity_labels.txt file containg all codes and names 1 to 6 
3c. The second file is the features.txt file that contains all the measurements 1 to 561

4a. The training files are uploaded and new column names are added 
4b. To get the participants ids test/subject_test.txt is loaded
4c. To get the participants activity test/y_test.txt is loaded
4d. To get the participants data results test/X_test.txt is loaded

5a. The test files are uploaded and new column names are added 
5b. To get the participants ids train/subject_test.txt is loaded
5c. To get the participants activity train/y_test.txt is loaded
5d. To get the participants data results train/X_test.txt is loaded

6a. The mean and std columns are selected for review (86 results)
6b. The column names are edited to comply with the rules

7. The three final data tables are merged for the training data the final dataset is called TRAIN2
8. The three final data tables are merged for the test data the final dataset is called TEST2

9. The Final_Merge dataset combines the test and training data using the rbind function in R
    The Final_Merge dataset has 10,299 rows and 89 columns
    The columns start with the x,id,activity, 86 measrements
    The rows are 7,352 from the train dataset and 2,947 from the test dataset
    
    All commands relating to the test data are labeled test_
    All commands relating to the train data are labeled train_
    There are also alot of notations/comments in the R code to clearify the steps in the code.
    
10. The Final_Merge dataset contains all of the test and training data
10a. This dataset is formated to replace the Activity Codes 1-6 with the Activity Names listed in the file

11. To comply with the rules of tidy data the Measurement/Feature fields are melted
11a. I used the gather function in R to melt the 86 Columns into 2 columns
11b. The 2 columns/variables created were measurements and value

12. The final data set titles Melted_Data has 4 coulmns which are discussed in detail in the code book

13. Analysis was performed on the Melted_Data set so that we group by id, activity and measurement, the average value was derived

14. The final Analysis was presented in long form with 15,480 rows and 4 columns

Read below for further information.






==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 


The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.
 Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
