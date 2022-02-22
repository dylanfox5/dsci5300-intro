#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Central Limit Theroem"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1000,
                     max = 100000,
                     value = 50000)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # Roll the dice
       die.rolls <- sample(x=1:6, size= input$bins, replace=TRUE)
      
      # draw the histogram distribution
      hist(die.rolls, main = "6 Sided iid Dice", xlab= "Die Value")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

