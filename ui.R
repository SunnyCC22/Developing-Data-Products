#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
install.packages("sourcetools")

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("By selecting the candidate, an interactive scattplot of mpg and candidate will be shown with the regression line."),
  
  # Sidebar with a slider input for number of bins 
  selectInput("variable", "Choose Variable:",
              c("Weight (1000 lbs)" = "wt",
                "Displacement (cu.in.) " = "disp",
                "1/4 mile time " = "qsec")),
  
  plotOutput("plot")
  
  
))


# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  
  output$plot<-renderPlot({
    regml<-lm(mtcars$mpg~mtcars[,input$variable])
    plot(mtcars$mpg~mtcars[,input$variable],
         main="Scatter Plot and Regression Line",
         xlab=input$variable,
         ylab="mpg")
    abline(regml,col="red",lwd=2)
    
  })
})

# Run the application 
shinyApp(ui = ui, server = server)

