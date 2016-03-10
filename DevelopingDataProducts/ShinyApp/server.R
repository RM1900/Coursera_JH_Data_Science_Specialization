shinyServer( 
  function(input, output) { 
    output$myPlot <- renderPlot({ 
      upperBound <- as.numeric(input$iterations)
      set.seed(100)
      par(mfrow=c(2,1)) #, mar=c(4,2,6,2), mgp=c(3,1,0))
      sim1 <- data.frame(x = rexp(input$iterations, 0.2))
      m1 <- mean(sim1$x)
      sd1 <- sd(sim1$x)
      hist(sim1$x, density=20, breaks=20, prob=TRUE, 
           xlab=paste0("mean = ",round(m1,2)," and theoretical mean = 5", "\nvariance = ",
                       round(sd1^2,3)," and theoretical variance = 25"), ylim=c(0, 0.3),
           main=paste0("probability histogram of ", input$iterations, " exponentials"))
      curve(dnorm(x, mean=m1, sd=sd1), col="darkblue", lwd=2, add=TRUE, yaxt="n")
      abline(v=m1,col="red")
      
      sim2 <- data.frame(x = sapply(1:upperBound, function(x) {mean(rexp(input$iterations, 0.2))}))
      m2 <- mean(sim2$x)
      sd2 <- sd(sim2$x)
      hist(sim2$x, density=20, breaks=20, prob=TRUE, 
           xlab=paste0("mean = ", round(m2,3)," theoretical mean = 5", "\nvariance = ",
                       round(sd2^2,3)," and theoretical variance = ",
                       round(25/upperBound,3)), ylim=c(0, 2.5),
                       main=paste0("probability histogram of the mean of \n", input$iterations, " means of ", input$iterations, " exponentials"))
       curve(dnorm(x, mean=m2, sd=sd2), col="darkblue", lwd=2, add=TRUE, yaxt="n")
       abline(v=m2,col="red")
    }) 
    
  } 
) 
