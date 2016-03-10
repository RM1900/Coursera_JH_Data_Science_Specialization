q1 <- function() {
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
    download.file(fileUrl, destfile = "./data/MicroData.csv", method = "curl")
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
    download.file(fileUrl, destfile = "./data/q1Cookbook.pdf", method = "curl")
    
    datafile <- read.csv(file="./data/MicroData.csv")
    
    # Apply strsplit() to split all the names of the data frame on the 
    # characters "wgtp". What is the value of the 123 element of the resulting list? 
    splitnames <- strsplit(names(datafile), "wgtp")
    
    return(print(c("question 1: ", splitnames[123])))
}

q2 <- function() {
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
    download.file(fileUrl, destfile = "./data/GDP.csv", method = "curl")
    
    # the data needs some cleanup
    # the first five lines are information about the file or blank so skip them
    # no header as we're skipping row
    # need rank to be read as a numeric not as a factor
    # data goes through row 195 (195 - 5 = 190 rows of data to read)
    datafileGDP <- read.csv(file="./data/GDP.csv", skip = 5, header = FALSE,
                            stringsAsFactors = FALSE, nrows = 190)
    
    # now have 10 variables, of which 1,2,4,5 have useful data, keep only those
    datafileGDP <- datafileGDP[,c(1,2,4,5)]
    
    # column names are not meaningful, set them
    colnames(datafileGDP) <- c("CountryAbv", "Rank", "Country", "GDP")
    
    # Remove the commas from the GDP numbers in millions of dollars and average
    # them. What is the average?
    datafileGDP$GDP <- as.numeric(gsub(",", "", datafileGDP$GDP))
    return(print(c("question 2: ", mean(datafileGDP$GDP))))
}

q3 <- function() {
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
    download.file(fileUrl, destfile = "./data/GDP.csv", method = "curl")
    
    # the data needs some cleanup
    # the first five lines are information about the file or blank so skip them
    # no header as we're skipping row
    # need rank to be read as a numeric not as a factor
    # data goes through row 195 (195 - 5 = 190 rows of data to read)
    datafileGDP <- read.csv(file="./data/GDP.csv", skip = 5, header = FALSE,
                            stringsAsFactors = FALSE, nrows = 190)
    
    # now have 10 variables, of which 1,2,4,5 have useful data, keep only those
    datafileGDP <- datafileGDP[,c(1,2,4,5)]
    
    # column names are not meaningful, set them
    colnames(datafileGDP) <- c("CountryAbv", "Rank", "Country", "GDP")
    
    # question 3
    # In the data set from Question 2 what is a regular expression that would
    # allow you to count the number of countries whose name begins with "United"? 
    # Assume that the variable with the country names in it is named 
    # countryNames. How many countries begin with United?
    
    # Country values 99 and 186 can't be processed by grep due to the \ character
    # strip it out first
    # 1: In grep("United", datafileGDP$Country) :
    #    input string 99 is invalid in this locale
    # datafileGDP$Country[99]
    # [1] "C\xf4te d'Ivoire"
    
    # 2: In grep("United", datafileGDP$Country) :
    #    input string 186 is invalid in this locale
    # > datafileGDP$Country[186]
    # [1] "S\xe3o Tom\xe9 and Principe"
    return(print(c("question 3: ^United ", sum(grepl("^United", datafileGDP$Country)))))
}
q4 <- function () {
    # questions 4
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
    download.file(fileUrl, destfile = "./data/GDP.csv", method = "curl")
    
    # the data needs some cleanup
    # the first five lines are information about the file or blank so skip them
    # no header as we're skipping row
    # need rank to be read as a numeric not as a factor
    # data goes through row 195 (195 - 5 = 190 rows of data to read)
    datafileGDP <- read.csv(file="./data/GDP.csv", skip = 5, header = FALSE,
                            stringsAsFactors = FALSE, nrows = 190)
    
    # now have 10 variables, of which 1,2,4,5 have useful data, keep only those
    datafileGDP <- datafileGDP[,c(1,2,4,5)]
    
    # column names are not meaningful, set them
    colnames(datafileGDP) <- c("CountryAbv", "Rank", "Country", "GDP")
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(fileUrl, destfile = "./data/fedstats.csv", method = "curl")
    
    # the data needs some cleanup
    # there is a header row
    datafileFED <- read.csv(file="./data/fedstats.csv", header = TRUE)
    
    # Match the data based on the country shortcode. Of the countries for which
    # the end of the fiscal year is available, how many end in June? 
    
    # merge based on CountryCode
    mergeddata <- data.frame()
    mergeddata <- merge(datafileGDP, datafileFED, all.x = TRUE, 
                        by.x = "CountryAbv", by.y = "CountryCode" )    
    
    # fiscal year end information is in the variable, Special.Notes and an
    # example is : "Fiscal year end: June 30;"
    return(print(c("question 4: ",sum(grepl("^Fiscal year end: June", mergeddata$Special.Notes)))))
}

q5 <- function () {
    # You can use the quantmod (http://www.quantmod.com/) package to get 
    # historical stock prices for publicly traded companies on the NASDAQ and 
    # NYSE. Use the following code to download data on Amazon's stock price and
    # get the times the data was sampled.
    # How many values were collected in 2012?
    # How many values were collected on Mondays in 2012?
    library(quantmod)
    amzn = getSymbols("AMZN",auto.assign=FALSE)
    sampleTimes = index(amzn) 
    return(print(c("question 5: ", sum(grepl("2012", sampleTimes)), "and",
                   length(intersect((grep("Monday",weekdays(sampleTimes))),grep("2012",sampleTimes))))))
}