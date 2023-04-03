library(shiny)
library(magrittr)
library(readxl)
# Modified from https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/

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

server <- shinyServer(function(input, output, session){
  data_heights <<- read_excel("heights_data.xlsx")
  update_data <- function(){
    data_heights <<- read_excel("heights_data.xlsx")
  }
  output$adultPlot <- renderPlot({
    print("Render")
    print(Sys.time())
    invalidateLater(10000, session) # refresh every 10 sec
    update_data()
    
    x    <- data_heights$adults
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of adult heights (>16 years old)")
  })
  
  output$childrenPlot <- renderPlot({
    invalidateLater(10000, session) # refresh every 10 sec
    update_data()
    
    x    <- as.numeric(data_heights$children)
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    print(x)
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of children heights (0-15 years old)")
  })
})

shinyApp(ui=ui,server=server)
