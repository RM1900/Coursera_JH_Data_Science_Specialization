
setwd("~/Documents/Get_Data_Course")

getcsv <- function() {
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl, destfile = "./data/2006MicrodataSurvey.csv", method = "curl")
    datafile <- read.csv("./data/2006MicrodataSurvey.csv")
    valued <- datafile$VAL == 24
    return(sum(valued,na.rm=TRUE))
}

getExcel <- function() {
    library(xlsx)
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
    download.file(fileUrl, destfile = "./data/NaturalGas.xlsx", method="curl")
    colIndex <- 7:15
    rowIndex <- 18:23
    datafile <- read.xlsx("./data/NaturalGas.xlsx", sheetIndex=1, header=TRUE, colIndex=colIndex,rowIndex=rowIndex)
    return(sum(datafile$Zip*datafile$Ext,na.rm=T))
}

getXMLZip <- function() {
    library(XML)
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
    download.file(fileUrl, destfile = "./data/Restaurants.xml", method = "curl")
    doc <-xmlParse(fileUrl)
    zipCodes <- xpathSApply(doc, "/response/row/row/zipcode", xmlValue)
    return(sum(zipCodes=="21231",na.rm=TRUE))
}

getSurvey <- function() {
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
    download.file(fileUrl, destfile = "./data/2006MicrodataSurvey2.csv", method = "curl")
    return (read.csv("./data/2006MicrodataSurvey2.csv"))
}

timeTrial <-function () {
    print("sapply(split(DT$pwgtp15,DT$SEX),mean)")
    sapply(split(DT$pwgtp15,DT$SEX),mean)
    print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
    
    print("tapply(DT$pwgtp15,DT$SEX,mean))")
    tapply(DT$pwgtp15,DT$SEX,mean)
    print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
    
    print("mean(DT[DT$SEX==1,]$pwgtp15) + (mean(DT[DT$SEX==2,]$pwgtp15))")
    mean(DT[DT$SEX==1,]$pwgtp15)
    mean(DT[DT$SEX==2,]$pwgtp15)
    print(system.time(mean(DT[DT$SEX==1,]$pwgtp15) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))))
    
    print("DT[,mean(pwgtp15),by=SEX])")
    DT[,mean(pwgtp15),by=SEX]
    print(system.time(DT[,mean(pwgtp15),by=SEX]))
    
    print("mean(DT$pwgtp15,by=DT$SEX))")
    mean(DT$pwgtp15,by=DT$SEX)
    print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
    
    print("rowMeans(DT)[DT$SEX==1]) + (rowMeans(DT)[DT$SEX==2])")
    print(system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2]))
}



