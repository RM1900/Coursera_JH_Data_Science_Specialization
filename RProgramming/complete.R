complete <- function(directory, id = 1:332) {
    files_list <- list.files(directory, full.names=TRUE) #creates a list of files 
    dat <- data.frame() #creates an empty data frame
    results <- data.frame()
    for (i in id) { 
        dat <- read.csv(files_list[i])
        dat_cases <- complete.cases(dat)
        results <- rbind(results, c(i, sum(dat_cases)))
    }
    names(results) <- c("ID","nobs")
    return(results)
}
