# this is the source file for the course assignment
assignment <- function () {
    # requirements:
    # 1) The code should have a file run_analysis.R in the main directory 
    # 2) that can be run as long as the Samsung data is in your working directory
    # 3) The output should be the tidy data set you submitted for part 1
    
    # Relative Path from your working directory to where the .zip file is located
    # if you use a different relative path, this variable needs to be updated
    dataPath <- paste0(getwd(), "/data")
    
    # name of the downloaded zip file containing the data files.
    # if you used a different file name, this variable needs to be updated
    dataFile <- "UCI Har Dataset"
    
    dataFilePath <- paste0(dataPath, "/", dataFile)
    zipFilePath <- paste0(dataPath, "/", dataFile, ".zip")
    
    # URL to the zipped data files we need to download for this assignment
    # note on some machines curl might not be installed or https may fail as a protocol
    # for downloading files
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    # there are 8 data files we need
    fileList <- matrix(c(paste0(dataFilePath, "/test/X_test.txt"),
                         paste0(dataFilePath, "/test/Y_test.txt"), 
                         paste0(dataFilePath, "/test/subject_test.txt"),
                         paste0(dataFilePath, "/train/X_train.txt"), 
                         paste0(dataFilePath, "/train/Y_train.txt"),
                         paste0(dataFilePath, "/train/subject_train.txt"), 
                         paste0(dataFilePath, "/activity_labels.txt"),
                         paste0(dataFilePath, "/features.txt")),
                       nrow = 1, ncol = 8,
                       dimnames = list(c("PathToFile"), 
                                     c("xTestData", "yTestData", "TestSubjects",
                                       "xTrainData", "yTrainData", 
                                       "TrainSubjects", "activity_labels", 
                                       "features")))
    
    # to save time, only download the zip file if one of the data files do
    # not exist
    filesExist <- TRUE
    for (i in length(fileList)) {
        if (!file.exists(fileList[i])) {
            filesExist <- FALSE
        } 
    }
    
    # if a data file doens't exist...
    if (!filesExist) {
        # if the relative path to the data file doesn't exist create it
        if (!file.exists(dataPath)) {
            dir.create(dataPath)
        }    
        
        # download the zipped data files
        download.file(fileUrl, destfile = zipFilePath, method = "curl")  
        # and unzip the content
        unzip(zipFilePath, exdir = dataPath)
    }    
    
    # read the data files
    xTestData <- read.table(fileList[1])
    yTestData <- read.table(fileList[2])
    TestSubjects <- read.table(fileList[3])
    xTrainData <- read.table(fileList[4])
    yTrainData <- read.table(fileList[5])
    TrainSubjects <- read.table(fileList[6])
    activity_labels <- read.table(fileList[7])
    features <- read.table(fileList[8])

    # 5 steps:
    # 1) Merge the training and the test sets to create one data set
    # add the test lables to the test data
    TestData <- cbind(yTestData, xTestData)
    
    # add the Test Subjects to the Test Data
    TestData <- cbind(TestSubjects, TestData)
    
    # add the training labels to the training data
    TrainData <- cbind(yTrainData, xTrainData)
    
    # add the train subjects to the  to Train Data
    TrainData <- cbind(TrainSubjects, TrainData)
    
    # add the Test data to the Training data
    CombinedData <- rbind(TestData, TrainData)
    
    # update the column names
    # guidance was that variable names should be all lower case
    names(CombinedData) <- paste(tolower(c("personidentifier", "activity",
                                           as.character(features$V2))))
    
    # 2) Extracts only the measurements on the mean and standard deviation for 
    # each measurement. 
    ExtractedData <- CombinedData[,1:2]
    ExtractedData <- cbind(ExtractedData, 
                           CombinedData[,grepl("mean\\(\\)|std\\(\\)", colnames(CombinedData))])
    
    # 3) Uses descriptive activity names to name the activities in the data set
    # guidance on variables with character values
    # Should usually be made into factor variables (depends on application)
    # Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female versus 0/1 or M/F)
    
    # change the activity column into a factor and label the activities
    ExtractedData$activity <- factor(ExtractedData$activity, 
                                     labels = activity_labels$V2)
   
    # 4) Appropriately labels the data set with descriptive variable names.
    # guidance on variable names from: 
    # courses/03_GettingData/04_01_editingTextVariables/index.html#16
    
    # All lower case when possible
    # Descriptive (Diagnosis versus Dx)
    # Not duplicated
    # Not have underscores or dots or white spaces
    # expand abbreviations
    # be specific as to what type of acceleration (when possible)
    # remove redundant information
    names(ExtractedData) <- gsub("bodybody", "body", names(ExtractedData))
    names(ExtractedData) <- gsub("tgravityacc", "timegravityacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("tbodyacc", "timelinearacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("tbodygyro", "timeangularacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("tbodyacc", "timebodyacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("freq\\(\\)", "()", names(ExtractedData))
    names(ExtractedData) <- gsub("fgravityacc", "frequencygravityacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("fbodyacc", "frequencylinearacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("fbodygyro", "frequencyangularacceleration", names(ExtractedData))
    names(ExtractedData) <- gsub("mag", "magnitude", names(ExtractedData))
    names(ExtractedData) <- gsub("jerk", "jerk", names(ExtractedData))
    
    # 5) From the data set in step 4, creates a second, independent tidy data 
    # set with the average of each variable for each activity and each subject.
    # make subject a factor
    ExtractedData$personidentifier <- fctor(ExtractedData$personidentifier)
    
    # requirements for tiny data:
    # Each variable forms a column
    # Each observation forms a row
    # Each table/file stores data about one kind of observation
    averages <-aggregate(ExtractedData, by=list(ExtractedData$personidentifier,
                                                ExtractedData$activity), 
                         FUN=mean, na.rm=TRUE)
    
    # remove the old ID and activity columns which are now full of NAs and
    # update the variable names
    averages[3:4] <- list(NULL)
    colnames(averages) <- paste0("avg(", colnames(averages), ")")
    names(averages) <- c("personidentifier", "activity",
                         colnames(averages[3:68]))
    write.table(averages, file=paste0(dataPath,"/tidydata.txt"), row.names = FALSE, quote = FALSE, sep="\t")
     
}