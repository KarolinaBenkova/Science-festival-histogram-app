library(shiny)
library(magrittr)
library(readxl)

ui <- shinyServer(fluidPage(
  titlePanel("Heights of Edinburgh Science Festival participants"),
  sidebarLayout(
    sidebarPanel(
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput(outputId = "adultPlot"),
      plotOutput(outputId = "childrenPlot"),
    )
  )
))