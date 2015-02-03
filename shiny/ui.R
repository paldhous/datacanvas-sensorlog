library(shiny)
library(markdown)
library(BH)

shinyUI(fluidPage(

  titlePanel(NULL),
  
  fluidRow(
    column(12,
           includeMarkdown("include.md")
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("var", 
                  label = h4("Choose sensor:"),
                  choices = list("Temperature", "Humidity", "Light", "Sound", "Air quality", "Dust", "UV"),
                  selected = "Temperature"
                  ),
 
      dateRangeInput("dates", 
                  label = h4("Date range:"), 
                  start = "2015-01-17", 
                  end = Sys.Date()+2, 
                  min = "2015-01-17", 
                  max = NULL, 
                  format = "yyyy-mm-dd", 
                  startview = "month", 
                  weekstart = 0, 
                  language = "en", 
                  separator = " to "
                  ),
      
      p("(Times UTC; data refreshed hourly)")
            
    ),
    
    mainPanel(
      
      plotOutput("plot")
      
    )
  
  )

))
