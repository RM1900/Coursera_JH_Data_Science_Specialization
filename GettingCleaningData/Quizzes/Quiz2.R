q1 <- function () {
  # Question 1
  # Use this data to find the time that the datasharing repo was created. 
  # What time was it created?
  # Credentials you get from registering a new application
  client_id = ""
  client_secret = ""
  
  library(httr) 
  
  # 1. Find OAuth settings for github: 
  #    http://developer.github.com/v3/oauth/ 
  github <- oauth_endpoints("github") 
  
  # 2. Register an application at https://github.com/settings/applications; 
  #    Use any URL you would like for the homepage URL (http://github.com is fine) 
  #    and http://localhost:1410 as the callback url 
  # 
  #    Insert your client ID and secret below - if secret is omitted, it will 
  #    look it up in the GITHUB_CONSUMER_SECRET environmental variable. 
  myapp <- oauth_app(github, key = client_id, secret = client_secret) 
  
  # 3. Get OAuth credentials 
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp) 
  
  # 4. Use API 
  gtoken <- config(token = github_token) 
  req <- GET("https://api.github.com/users/jtleek/repos", gtoken) 
  stop_for_status(req) 
  
  # get the content out of the API and loop over the list of returned data to 
  # find the datasharing repository data
  i = 1
  data <- content(req)
  while (!(data[[i]]$url == "https://api.github.com/repos/jtleek/datasharing")){  
    i = i + 1
  }
  return(data[[i]]$created_at)
}

q2 <- function() {
    # question 2
    # select only the data for the probability weights pwgtp1 with ages less than 50?
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileUrl, destfile = "./data/AmericanCommunity.csv", method = "curl")
    datafile <- read.csv("./data/AmericanCommunity.csv")
    
    library(sqldf) 
    return(sqldf("select pwgtp1 from datafile where AGEP < 50"))
}

q3 <- function() {
    # question 3 # what is the equivalent function to unique(acs$AGEP)
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileUrl, destfile = "./data/AmericanCommunity.csv", method = "curl")
    datafile <- read.csv("./data/AmericanCommunity.csv")
    
    uniqueAGEP <- unique(datafile$AGEP)
    
    library(sqldf) 
    distinctAGEP <- sqldf("select distinct AGEP from datafile")
    return(uniqueAGEP == distinctAGEP$AGEP)
}

q4 <- function() {
    # How many characters are in the 10th, 20th, 30th and 100th lines of HTML 
    # from this page: http://biostat.jhsph.edu/~jleek/contact.html
    
    con = url("http://biostat.jhsph.edu/~jleek/contact.html ")
    htmlCode = readLines(con)
    close(con)
    return(nchar(htmlCode[c(10,20,30,100)]))   
}

q5 <- function() {
    # question 5
    # report the sum of the numbers in the fourth of the nine columns. 
    # https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
    if (!file.exists("data")) {
        dir.create("data")
    }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
    download.file(fileUrl, destfile = "./data/NOAA.for", method = "curl")
    
    # the file is fixed width fields as a seperator is not always used between 
    # the SST and SSTA field data
    # skip first four lines of heading information
    # the widths just need to count each position on a row of data and the count
    # should be for reaching the end of each value.
    # it doesn't matter where you split the count of spaces so long as all
    # positions are accounted for and you end at the correct position.
    datafile <- read.fwf(file="./data/NOAA.for", skip=4,
                         widths=c(12, 7,4, 9,4, 9,4, 9,4))
    
    return(sum(datafile[4]))
}