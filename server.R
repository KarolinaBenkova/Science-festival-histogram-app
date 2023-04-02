library(shiny)
library(magrittr)
library(readxl)
# Modified from https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/

server <- shinyServer(function(input, output, session){
  data_heights <<- read_excel("heights_data2.xlsx")
  update_data <- function(){
    data_heights <<- read_excel("heights_data2.xlsx")
  }
  output$adultPlot <- renderPlot({
    print("Render")
    print(Sys.time())
    invalidateLater(5000, session) # refresh every 5 sec
    update_data()
    # print(data_heights$adults[data_heights$adults>0])
    
    x    <- data_heights$adults
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of adult heights (16 years old or older")
  })
  
  output$childrenPlot <- renderPlot({
    invalidateLater(5000, session) # refresh every 5 sec
    update_data()
    
    x    <- data_heights$children
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of children heights (0-15 years old)")
  })
})