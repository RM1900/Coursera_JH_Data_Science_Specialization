plot3 <- function() {
    # function to create the third plot in assignment 1 of Exploratory Data Analysis
    
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
    png(file = "./plot3.png", width = 480, height = 480, units = "px")
 
    # create the plot
    with(sub_data, {
        plot(sub_data$DateTime, sub_data$Sub_metering_1
             , type="l", ylab = "Energy sub metering", xlab = "", col = "black")
        lines(sub_data$DateTime, sub_data$Sub_metering_2, type="l", col = "red")
        lines(sub_data$DateTime, sub_data$Sub_metering_3, type="l", col = "blue")
        legend("topright", lwd = 1, col = c("black", "red", "blue")
               , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    })
    devReturn <- dev.off()    
}
