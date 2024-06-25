library(shiny)
# library(magrittr)
# library(readxl)

ui <- shinyServer(fluidPage(
  titlePanel("Are the visitors' heights normally distributed? Contribute with your height!"),
  fluidRow(
    column(3,
           actionButton(inputId = "reload", label = "Reload data")
    ),
    column(5,
           sliderInput(inputId = "bins",
                       label = "Number of bins:",
                       min = 1,
                       max = 50,
                       value = 30))
  ),
    mainPanel(
      fluidRow(
        splitLayout(
          cellWidths = c("75%", "75%"),
          plotOutput(outputId = "adultPlot"),
          plotOutput(outputId = "childrenPlot"),
        )
      )
    )
  # )
))
