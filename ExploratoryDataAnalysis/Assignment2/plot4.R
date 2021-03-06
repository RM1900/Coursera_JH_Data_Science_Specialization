plot4 <- function () {
    # question 4: Across the United States, how have emissions from coal 
    # combustion-related sources changed from 1999–2008?
    
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
    
    # need to search for coal in the following fields:
    # SCC.Level.Four, SCC.Level.Three, EI.Sector, and Short.Name
    # and for combustion in SCC.Level.One
    
    coal <- (grepl("coal", ClassificationFile$Short.Name, ignore.case = TRUE) & 
                 grepl("combustion", ClassificationFile$SCC.Level.One, ignore.case = TRUE)) |
        (grepl("coal", ClassificationFile$EI.Sector, ignore.case = TRUE) & 
             grepl("combustion", ClassificationFile$SCC.Level.One, ignore.case = TRUE)) |
        (grepl("coal", ClassificationFile$SCC.Level.Three, ignore.case = TRUE) &
             grepl("combustion", ClassificationFile$SCC.Level.One, ignore.case = TRUE)) |
        (grepl("coal", ClassificationFile$SCC.Level.Four, ignore.case = TRUE) &
             grepl("combustion", ClassificationFile$SCC.Level.One, ignore.case = TRUE))
    
    # and get the SCC codes for each of those rows
    CoalSCC <- ClassificationFile[coal, 'SCC']
    
    # and get the summary data for those SCC codes:
    CoalPM <- SummaryDataFile[SummaryDataFile$SCC %in% CoalSCC, ]
    
    # aggregate the data
    summed <- aggregate(Emissions ~ year, data = CoalPM, 
                        FUN = sum, na.RM=TRUE)
    
    # plot the data
    png(file = paste0(dataPath, c("/plot4.png")), width = 800, height = 600, units = "px")
    g <- ggplot(summed, aes(year, Emissions)) + geom_point(size = 3) + geom_smooth() 
    g <- g + labs (x = "Year", y = "PM2.5 Emissions in tons", 
                   title = c("Total PM2.5 Emissions in the USA \n from Coal Combustion-Related Sources"))
    
    print(g)
    devReturn <- dev.off()  
    
    # and show the plot
    g <- ggplot(summed, aes(year, Emissions)) + geom_point(size = 3) + geom_smooth() 
    g <- g + labs (x = "Year", y = "PM2.5 Emissions in tons", 
                   title = c("Total PM2.5 Emissions in the USA \n from Coal Combustion-Related Sources"))
    print(g)
}