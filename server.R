library(shiny)
library(magrittr)
library(readxl)
library(googlesheets4)

# Modified from https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/

server <- shinyServer(function(input, output, session){
  gs4_deauth()
  data_heights <- reactiveVal(read_sheet("https://docs.google.com/spreadsheets/d/1TuGqU7fLzumpWgD-WyiQVLLULAmkZOzzGvZarbLyrek/edit?usp=sharing"))
  
  update_data <- function(){
    data_heights(read_sheet("https://docs.google.com/spreadsheets/d/1TuGqU7fLzumpWgD-WyiQVLLULAmkZOzzGvZarbLyrek/edit?usp=sharing"))
  }
  observeEvent(input$reload, {
    update_data()
  })
  
  output$adultPlot <- renderPlot({
    x    <- data_heights()$adults
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of adult heights (>16 years old)")
  })

  output$childrenPlot <- renderPlot({
    x    <- data_heights()$children
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of children heights (0-15 years old)")
  })
})