plot5 <- function () {
    # question 5: How have emissions from motor vehicle sources changed from 
    # 1999–2008 in Baltimore City?  Baltimore City, Maryland is fips == "24510"
    # from the EPA http://www.epa.gov/ttn/chief/trends/procedures/neiproc_99.pdf
    # need to search for the OnRoad vehicle category
    
    # load ggplot2
    library(ggplot2)
    
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

    # subset to Baltimore and ON-ROAD
    BaltimoreData <- subset(SummaryDataFile, SummaryDataFile$fips == "24510" & 
                                SummaryDataFile$type == "ON-ROAD")
    
    # aggregate the data
    summed <- aggregate(Emissions ~ year, data = BaltimoreData, 
                        FUN = sum, na.RM=TRUE)
    
    # save the plot
    png(file = paste0(dataPath, c("/plot5.png")), width = 800, height = 600, units = "px")
    g <- ggplot(summed, aes(year, Emissions)) + geom_point(size = 3) + geom_smooth() 
    g <- g + labs (x = "Year", y = "PM2.5 Emissions in tons", 
                   title = c("Total PM2.5 Emissions in Baltimore City, Maryland (fips = 24510) \n from Motor Vehicles (ON-ROAD) sources"))
    print(g)
    devReturn <- dev.off()  
    
    # and show the plot
    g <- ggplot(summed, aes(year, Emissions)) + geom_point(size = 3) + geom_smooth() 
    g <- g + labs (x = "Year", y = "PM2.5 Emissions in tons", 
                   title = c("Total PM2.5 Emissions in Baltimore City, Maryland (fips = 24510) \n from Motor Vehicles (ON-ROAD) sources"))
    print(g) 
}