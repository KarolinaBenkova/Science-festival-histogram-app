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
    )
  )
))

server <- shinyServer(function(input, output, session){
  adult_heights <<- read_excel("heights_data.xlsx")
  update_adult <- function(){
    adult_heights <<- read_excel("heights_data.xlsx")
  }
  output$adultPlot <- renderPlot({
    print("Render")
    print(Sys.time())
    invalidateLater(5000, session) # refresh every 5 sec
    update_adult()
    print(adult_heights$heights[adult_heights$heights>0])
    
    x    <- adult_heights$heights
    x    <- na.omit(x) # ignore invalid entries
    x    <- x[x>0] # ignore zero heights
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of adult heights")
  })
})

shinyApp(ui=ui,server=server)
