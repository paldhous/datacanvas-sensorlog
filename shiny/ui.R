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
                  choices = list("Temperature", "Humidity", "Light", "Sound", "Air quality", "Dust"),
                  selected = "Temperature"
                  ),
 
      dateRangeInput("dates", 
                  label = h4("Date range:"), 
                  start = Sys.Date()-30, 
                  end = Sys.Date()+2, 
                  min = "2015-06-01", 
                  max = NULL, 
                  format = "yyyy-mm-dd", 
                  startview = "month", 
                  weekstart = 0, 
                  language = "en", 
                  separator = " to "
                  ),
      
      p("(Times UTC; data refreshed hourly.)")
            
    ),
    
    mainPanel(
      
      plotOutput("plot")
      
    )
  
  )

))
