library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Demonstration of the Central Limit Theorem (CLT)"),
  fluidRow(
      column(6,
             helpText("The purpose of this Shiny application is to demonstrate the Central Limit Theorem."),
             sliderInput("iterations","Select the number of iterations to run:", min = 100, max = 1000, value = 100, step = 100),
             includeMarkdown("CLT.Rmd")
             ),
      column(6,
             plotOutput("myPlot", height = 1000, width = 500)
      )
  )
))