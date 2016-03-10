plot1 <- function() {
    # function to create the first plot in assignment 1 of Exploratory Data Analysis
    
    # URL to the file to download, note using https as the protocol will fail
    # to successfully download
    fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    # as the file is a zip file, need to unzip it and will use a temporary
    # file to hold the zipped data
    tempFile <- tempfile()
    download.file(fileUrl, tempFile)
    
    # unzip the data and read it into a data frame
    datafile <- read.csv(unz(tempFile, "household_power_consumption.txt"),
                     ,header = TRUE
                     ,sep = ";"
                     ,na.strings = "?"
    )  
    
    # release the temporary file
    unlink(tempFile)
    
    # subset the data to the dates needed 
    sub_data <- subset(datafile, (Date %in% c("1/2/2007","2/2/2007")))
    
    # create the plot using the required paramaters
    png(file = "./plot1.png", width = 480, height = 480, units = "px")
    hist(sub_data$Global_active_power, col= "red", main = "Global Active Power"
         , xlab = "Global Active Power (kilowatts)", ylim=c(0,1200))
    devReturn <- dev.off()  
}
