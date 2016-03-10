rankhospital <- function(state, outcome, ranking) {
    if(!is.element(toupper(state), state.abb)) 
        stop("invalid state")
    
    list_Outcomes <- c("heart attack", "heart failure", "pneumonia")
    if(!is.element(outcome, list_Outcomes)) stop("invalid outcome") 
    if(!is.numeric(ranking) && ranking != "best" && ranking != "worst") stop("invalid ranking")
    
    datafile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    datafile <- datafile[datafile$State == state, ] 
    
    options( warn = -1 )
    
    if (outcome == "heart attack") {
        sub_data <- datafile[order(as.numeric(datafile[,11]), datafile[,2], na.last=NA), ]
    }
    else if (outcome == "heart failure") {
        sub_data <- datafile[order(as.numeric(datafile[,17]), datafile[,2], na.last=NA), ]
    }
    else {
        sub_data <- datafile[order(as.numeric(datafile[,23]), datafile[,2], na.last=NA), ]
    }
    options( warn = 0 )
    
    if (ranking == "best") return (sub_data[1,2])
    else if (ranking == "worst") return (tail(sub_data[,2],1))
    else if(ranking > nrow(sub_data)) return(NA)
    else return(sub_data[ranking,2])
}