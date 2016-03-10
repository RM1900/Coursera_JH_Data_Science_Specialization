best <- function(state, outcome) {
    if(!is.element(toupper(state), state.abb)) 
        stop("invalid state")
    list_Outcomes <- c("heart attack", "heart failure", "pneumonia")
    if(!is.element(outcome, list_Outcomes)) stop("invalid outcome") 
    datafile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    datafile <- datafile[datafile$State == state, ] 
    
    options( warn = -1 )
    
    if (outcome == "heart attack") {
        sub_data <- datafile[order(as.numeric(datafile[,11]), datafile[,2]), ]
    }
    else if (outcome == "heart failure") {
        sub_data <- datafile[order(as.numeric(datafile[,17]), datafile[,2]), ]
    }
    else {
        sub_data <- datafile[order(as.numeric(datafile[,23]), datafile[,2]), ]
    }
    options( warn = 0 )
    return(sub_data[1,2])
}