README for Course_Coursera_Get_Data repository
==============================================
References

    1)  The course material https://github.com/rdpeng/courses.git in the file courses/03_GettingData/
    2)  The tidy data paper http://vita.had.co.nz/papers/tidy-data.pdf
    3)  The TA's discussion forum topic: https://class.coursera.org/getdata-009/forum/thread?thread_id=58
    
This repository is for my work for the Coursera course "Getting and Cleaning Data".  In the main directory is the script run_analsys.R and the directory Quizzes.  run_analysis.R is the script for the class assignment and is detailed below.  In the Quizes directory are scripts for each of the weekly quizzes that I created to improve my skill at writing functions and debugging.  They are not part of the class assignment.  They are included in this repository as this repository is for all script work required to complete the course.

The run_analysis.R script contains one function, <i>assignment</i> which is called without parameters and will do the following:

1)  Checks to see if the data files exist.
2)  If the files do not exist, downloads the source data zip file and unzips it.
3)  Reads in the data files.
4)  Merges the training and the test data sets to create one data set in the following sequence:
    a)  add the test labels to the test data
    b)  add the test subjects to the test data
    c)  add the training labels to the training data
    d)  add the train subjects to the  to Train Data
    e)  add the test data to the training data
    f)  update the column names
5)  Extracts only the measurements on the mean and standard deviation for each measurement.  When I extracted the columns, I extracted all the columns that referred to the mean() or std() functions: 

    <i>ExtractedData <- cbind(ExtractedData, CombinedData[,grepl("mean\\(\\)|std\\(\\)", colnames(CombinedData))])</i>

There were a few other variables that contained data from calculating the angle between two vectors that used a mean or STD measurement as input which I did not include as the data in the variable was not a mean or STD.  I extracted both the time and frequeny mean and std variables as insights from the analysis or improvements in the next iteration of the project could come from analyzing either set of data.

6) Names the activities in the data set.
7) Updates the column names with descriptive variable names:

    a)  Are all lower case
    b)  Are descriptive
    c)  Are not duplicated
    d)  Do not have underscores or dots or white spaces
    e)  Variables containing character data were made into factor variables
     <p></p>  
    To which I added:
 
    e)  Expands abbreviations
    f)  Removes redundant information
    g)  Be specific as to what type of acceleration was being measured
    
8) Generates a tidy data set with the average of each variable for each activity and each subject.
9) Writes the tidy data set to a text file:

    a)  Each variable forms a column
    b)  Each observation forms a row
    c)  Each table/file stores data about one kind of observation
    d)  Tab delimited for easy importing into R or other program
    
Running the script
------------------
If you chose to run the script you may choose to change where the data files will be located or the name of the downloaded and unzipped directory of data files.  Those variables are at the top of the script:

    Relative Path from your working directory to where the .zip file is located
    if you use a different relative path, this variable needs to be updated
    dataPath <- paste0(getwd(), "/data")
    
    name of the downloaded zip file containing the data files.
    if you used a different file name, this variable needs to be updated
    dataFile <- "UCI Har Dataset"
 
To run the script without modification:

    1)  Open run_analysis.R
    2)  Select all the text and code
    3)  Select Run
    4)  Call the function assignment()
