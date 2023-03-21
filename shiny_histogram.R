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
    invalidateLater(5000, session)
    update_adult()
    print(adult_heights)
    
    x    <- adult_heights$heights
    x    <- na.omit(x)
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Height [cm]",
         main = "Histogram of adult heights")
  })
})

shinyApp(ui=ui,server=server)