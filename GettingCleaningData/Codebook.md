Codebook for Getting and Cleaning Data class assignment
-------------------------------------------------------
This is the codebook for the class assignment and covers:

    A)  Information about the variables
    B)  Information about the choices I made
    C)  Information about the study design I used

Study design
------------
The data set was provided as part of the course assignment and is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones is:

"<i>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the README.txt file for further details about this dataset. </i>"

From the README.txt file is additional information on the measurements:

"<i>Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

Triaxial Angular velocity from the gyroscope.

A 561-feature vector with time and frequency domain variables.

Its activity label.

An identifier of the subject who carried out the experiment.</i>"

Files in the Data Set
---------------------
The following files are in the data set and a subset where used in this assignment:

<table><tr><td><p><b>File</b></p></td><td><p><b>Used or Not</b></p></td></tr>
<tr><td><p>/features.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/features_info.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/README.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/test/X_test.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/test/Y_test.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/test/subject_test.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/test/Inertial Signals/</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/body_acc_x_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/body_acc_y_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/body_acc_z_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/body_gyro_x_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/body_gyro_y_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/body_gyro_z_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/total_acc_x_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/total_acc_y_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/test/Inertial Signals/total_acc_z_test.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/X_train.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/train/Y_train.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/train/subject_train.txt</p></td><td><p>Yes</p></td></tr>
<tr><td><p>/train/Inertial Signals/</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/body_acc_x_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/body_acc_y_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/body_acc_z_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/body_gyro_x_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/body_gyro_y_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/body_gyro_z_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/total_acc_x_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/total_acc_y_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/train/Inertial Signals/total_acc_z_train.txt</p></td><td><p>No</p></td></tr>
<tr><td><p>/activity_labels.txt</p></td><td><p>Yes</p></td></tr></table>


Code book
---------
These are the steps I took to create the tiny data set from the original data set.  

I merged the training and the test data sets to create one data set in the following sequence:
    a)  added the test labels to the test data by column with the labels as the first variable
    b)  added the test subjects to the test data by column with the subject as the first variable
    c)  added the training labels to the training data by column with the labels as the first variable
    d)  added the train subjects to the  to Train Data by column with the subject as the first variable
    e)  added the test data to the training data by row as the variables were the same
    f)  added the variable names as follows:
      1)  the subject variable was renamed personidentifier
      2)  the label variable was renamed activity
      3)  the measurement variable names were pulled from the data file features.txt
      3a)  and all the variable names were cast to lower case
    g)  Converted the activity variable to a factor variable
      
The features.txt file contains the name of the the 561 variables in the data set.  For this assignment I was to extract only the measurements on the mean and standard deviation for each measurement.  When I extracted the columns, I extracted all the columns whose name included the text "mean()" or "std()" which extracted 66 columns or variables. There were a few other variables that contained data from calculating the angle between two vectors that used a mean or STD measurement as input which I did not include as the data in the variable was not a mean or STD.  I extracted both the time and frequeny mean and std variables as insights from the analysis or improvements in the next iteration of the project could come from analyzing either set of data.

From the data set features_info.txt file is information on how the variables were orginally named:
"<i>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag"</i>

I then changed parts of the variable names in the follow order and manner:

<table><tr><td><p><b>original part of variable name     </b></p></td><td><p><b>new part of variable name</b></p></td></tr>
<tr><td><p>bodybody</p></td><td><p>body</p></td>
</tr><tr><td><p>tgravityacc</p></td><td><p>timegravityacceleration</p></td></tr>
<tr><td><p>tbodyacc</p></td><td><p>timelinearacceleration</p></td></tr>
<tr><td><p>tbodygyro</p></td><td><p>timeangularacceleration</p></td></tr>
<tr><td><p>tbodyacc</p></td><td><p>timebodyacceleration</p></td></tr>
<tr><td><p>freq()</p></td><td><p>()</p></td></tr>
<tr><td><p>fgravityacc</p></td><td><p>frequencygravityacceleration</p></td></tr>
<tr><td><p>fbodyacc</p></td><td><p>frequencylinearacceleration</p></td></tr>
<tr><td><p>fbodygyro</p></td><td><p>frequencyangularacceleration</p></td></tr>
<tr><td><p>mag</p></td><td><p>magnitude</p></td></tr>
<tr><td><p>jerk</p></td><td><p>jerk</p></td></tr></table>

I then converted the personidentifier variable to a factor variable.

I then calculated the mean of each variable (with NAs removed) by the two factors: personidentifier and activity.

I then removed the variables that were the mean of the personidentifier and activity as a mean of those fields does not make sense. 

I then updated the variable names as follows:

  1)  the subject variable was renamed personidentifier
  2)  the label variable was renamed activity
  3)  the mean of the measurement variables were prefixed with "avg(" and suffixed with ")"

And finally to write the data set to disk I wrote it as a table without row names and used a tab as a seperator to make it easy to reload into R or other program.

Robert