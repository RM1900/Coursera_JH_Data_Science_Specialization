plot2 <- function() {
    # function to create the second plot in assignment 1 of Exploratory Data Analysis
    
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
    
    # copy the Date and Time fields to a new field DateTime
    DateTime <- paste(sub_data$Date, sub_data$Time)
    sub_data$DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")
    
    # create the plot using the required paramaters
    png(file = "./plot2.png", width = 480, height = 480, units = "px")
    plot(sub_data$DateTime, sub_data$Global_active_power,
         type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
    devReturn <- dev.off()    
}
