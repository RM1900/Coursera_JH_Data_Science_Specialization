q1 <- function() {
    # question 1
    # Create a logical vector that identifies the households on greater than 
    # 10 acres who sold more than $10,000 worth of agriculture products. Assign
    # that logical vector to the variable agricultureLogical. Apply the which()
    # function like this to identify the rows of the data frame where the
    # logical vector is TRUE. which(agricultureLogical) What are the first 3 
    # values that result?
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl, destfile = "./data/MicroData.csv", method = "curl")
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
    download.file(fileUrl, destfile = "./data/q1Cookbook.pdf", method = "curl")
    
    datafile <- read.csv(file="./data/MicroData.csv")
    
    # 10 acres who sold more than $10,000 worth of agriculture products.
    # from the cookbook the field for lot size is ACR and we need value of 3
    
    
    # sold more than $10,000 worth of agriculture products
    # from the cookbook the field we need is AGS and we need value of 6
    
    agriculteralLogical <- (datafile$ACR==3 & datafile$AGS==6)
    
    return(which(agriculteralLogical))
}

q2 <- function() {
    # question 2
    # Using the jpeg package read in the  picture of your instructor into R 
    # Use the parameter native=TRUE. What are the 30th and 80th quantiles of the 
    # resulting data? (some Linux systems may produce an answer 638 different 
    # for the 30th quantile)
    
    library(jpeg)
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    download.file(fileUrl, destfile = "./data/jeff.jpg", method = "curl", mode = "wb")
    
    datafile <- readJPEG("./data/jeff.jpg", native = TRUE)
    
    return(quantile(datafile, probs = c(.30,.80)))
}

q345 <- function() {
    # questions 3,4,5
    # Match the data based on the country shortcode. 
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
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
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
    download.file(fileUrl, destfile = "./data/fedstats.csv", method = "curl")
    
    # the data needs some cleanup
    # there is a header row
    # don't read the strings as factors
    datafileFED <- read.csv(file="./data/fedstats.csv", header = TRUE)
    
    ## question 3
    # How many of the IDs match?
    # Sort the data frame in descending order by GDP rank (so United States is
    # last). What is the 13th country in the resulting data frame? 
    
    # are all the countries in datafileGDP also in datafileFED?
    listGDP <- datafileGDP[,c(1)]
    listFED <- datafileFED[,c(1)]
    test <- setdiff(listGDP, listFED)
    
    mergeddata <- data.frame()
    if (length(test) > 0) {
        mergeddata <- merge(datafileGDP, datafileFED, all.x = TRUE, 
                            by.x = "CountryAbv", by.y = "CountryCode" )    
    }
    
    # sort the merged data by descending rank
    mergeddata <- mergeddata[with(mergeddata, order(-Rank)),]
    
    # return the count of matches and the 13th country
    print((c("# of Matches = ", (190-length(test)), c("13th lowest GDP Country = "),
              mergeddata[13,3])))
    
    ## question 4
    # What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
    meanGDPs <- sapply(split(mergeddata[2], mergeddata$Income.Group), function(x) apply(x,2,mean))
    print(meanGDPs[2:3])
    
    ## question 5
    # cut the GDP ranking into 5 separate quantile groups. Make a table versus
    # Income.Group. How many countries are Lower middle income but among the 38
    # nations with highest GDP?
    
    # add a column for the 5 quantiles
    mergeddata$Quant <- cut (mergeddata$Rank, breaks = quantile(mergeddata$Rank,
                     c(0, .2, .4, .6, .8, 1.0)),include.lowest = TRUE)
    # validated my use of a table by splitting the dataframe and looking up the
    # the value directly
    #    test <- split(mergeddata,mergeddata$Quant)
    #    test <- test[[1]][c(6,35)]
    #    test <- test[with(test, order(Income.Group)),]
    #    count <- test$Income.Group == c("Lower middle income")
    # print(c("LMI in High GDP quantile = ", sum(count)))
    
    # now do it with using a table as the question required
    table1 <- table(mergeddata$Income.Group, mergeddata$Quant)
    print(c("LMI in High GDP quantile = ", table1["Lower middle income",1]))
}
