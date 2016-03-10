plot1 <- function () {
    # question 1: Have total emissions from PM2.5 decreased in the United States
    # from 1999 to 2008? Using the base plotting system, make a plot showing the
    # total PM2.5 emission from all sources for each of the years 1999, 2002, 
    # 2005, and 2008.
    
    # Relative Path from your working directory to where the .zip file is located
    # if you use a different relative path, this variable needs to be updated
    dataPath <- paste0(getwd(), "/data")
    
    # name of the course provided zip file containing the data files without
    # .zip extension
    dataFile <- "exdata-data-NEI_data"
    
    # full path to the zip file
    dataFilePath <- paste0(dataPath, "/", dataFile)
    
    # full path including file extension
    zipFilePath <- paste0(dataPath, "/", dataFile, ".zip")
    
    # URL to the zipped data file we need to download for this assignment
    # note on some machines curl might not be installed or https may fail as a protocol
    # for downloading files
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    
    # there are 2 data files we need from the zip file
    fileList <- matrix(c(paste0(dataPath, "/summarySCC_PM25.rds"),
                         paste0(dataPath, "/Source_Classification_Code.rds")),
                       nrow = 1, ncol = 2,
                       dimnames = list(c("File"), 
                                       c("SummaryDataFile",
                                         "ClassificationFile")))
    
    # to save time, only download the zip file if one of the data files does
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
        
        # and unzip the content to the dataPath directory, note as the zip file
        # only contains two files and no directories, the data files we need
        # are unzipped with this command to the dataPath directory
        unzip(zipFilePath, exdir = dataPath)
    }    
    
    # read the data files
    SummaryDataFile <- readRDS(fileList[1])
    ClassificationFile <- readRDS(fileList[2])
    
    # aggregate the data by year and type of emission
    summed <- aggregate(Emissions ~ type+year, data = SummaryDataFile, 
                        FUN = sum, na.RM=TRUE)
    
    # reshape the data so it can be plotted as a barplot which requires a matrix
    z <- reshape(summed, timevar = "year", idvar = "type", direction = "wide")
    rownames(z) <- z$type
    z$type <- NULL
    
    # create a plot of the total emissions as a stacked bar chart for each type
    # save the plot to a PNG file
    png(file = paste0(dataPath, c("/plot1.png")), width = 800, height = 600, units = "px")
    barplot(as.matrix(z), names.arg = c("1999", "2002", "2005", "2008"), 
            legend=T, xlab = "Year", ylab = "PM2.5 Emissions in tons", 
            main= "Total PM2.5 Emissions in the USA (by type of emission)", 
            col = c("blue", "red", "green", "purple"))
    devReturn <- dev.off()  
    
    # and show the plot
    barplot(as.matrix(z), names.arg = c("1999", "2002", "2005", "2008"), 
            legend=T, xlab = "Year", ylab = "PM2.5 Emissions in tons", 
            main= "Total PM2.5 Emissions in the USA (by type of emission)", 
            col = c("blue", "red", "green", "purple"))
}