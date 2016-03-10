rankall <- function(outcome, num="best") {
    list_Outcomes <- c("heart attack", "heart failure", "pneumonia")
    if(!is.element(outcome, list_Outcomes)) stop("invalid outcome") 
    if(!is.numeric(num) && num != "best" && num != "worst") stop("invalid ranking")
    
    datafile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    lookup <- function(sub_data) {
        if (num == "best") return (sub_data[1,2])
        else if (num == "worst") return (tail(sub_data[,2],1))
        else if(num > nrow(sub_data)) return(NA)
        else return(sub_data[num,2])
    }
    
    options( warn = -1 )
    if (outcome == "heart attack") {
        sorteddata <- datafile[order(as.numeric(datafile[,11]), datafile[,2], na.last=NA), ]
    }
    else if (outcome == "heart failure") {
        sorteddata <- datafile[order(as.numeric(datafile[,17]), datafile[,2], na.last=NA), ]
    }
    else {
        sorteddata <- datafile[order(as.numeric(datafile[,23]), datafile[,2], na.last=NA), ]
    }
    options( warn = 0 )
    
    splitdata <- split(sorteddata, sorteddata[,7])
    
    output <- data.frame(hospital = character(), state = character())
    for (i in state.abb) {
        statedata <- splitdata[[i]] 
        #        print(i)
        answer <-lookup(statedata)
        #        print(answer)
        output <- rbind(output,data.frame(hospital = answer[1], state = i))
    }
    output <- output[order(output[2],output[1]),]
#    names(output)[1] <- ""
    return(output)
}