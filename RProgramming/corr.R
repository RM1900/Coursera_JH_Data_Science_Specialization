corr <- function(directory, threshold = 0) {
    files_list <- list.files(directory, full.names=TRUE) 
    dat <- data.frame()
    results <- data.frame()
    count = 0
    for (i in 1:length(files_list)) { 
        dat <- read.csv(files_list[i])
        if (sum(complete.cases(dat)) > threshold) {
            results <- rbind(results, cor(dat$nitrate,dat$sulfate, use = "complete.obs"))  
            count = count +1
        }
    }
    if (count == 0) {
        return(numeric())
    }
    else {
        return(as.vector(results[,1]))
    }
}