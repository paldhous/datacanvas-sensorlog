library(dplyr)
library(ggplot2)
library(scales)
library(readr)

shinyServer(function(input, output) {
  
  # Create a Progress object
  progress <- shiny::Progress$new()
  # Make sure it closes, even if there's an error
  on.exit(progress$close())
  
  progress$set(message = "Loading data. This may take a while!")
 
  # Get the data
  sensor_data <- read.csv("http://peteraldhous.com/datacanvas/sensor_data.csv", header = TRUE)
  
  # Process the data
  sensor_data <- select(sensor_data, timestamp, airquality_raw, dust, humidity, light, sound, temperature, uv) %>%
    mutate(timestamp=as.POSIXct(strptime(timestamp, "%Y-%m-%d %H:%M:%S"))) %>%
    filter(timestamp > "2015-05-01 00:00:00")
  
  # Render the plot
  output$plot <- renderPlot({
    
    # Input from sensor select control
    measure <- switch(input$var, 
                   "Temperature" = sensor_data$temperature,
                   "Humidity" = sensor_data$humidity,                   
                   "Light" = sensor_data$light,                   
                   "Sound" = sensor_data$sound,                   
                   "Air quality" = sensor_data$airquality_raw,                   
                   "Dust" = sensor_data$dust
    )
    
    # Input from date range select control
    start <- as.POSIXct(input$dates[1])
    end <- as.POSIXct(input$dates[2])
    
    # Function to draw the plot
    plotfunc <- function(sensor_data, measure, start, end){
      .e <- environment()
      ggplot(sensor_data, aes(x = timestamp, y = measure), environment = .e) + 
        xlab("") + ylab("") + 
        geom_line(color="#606060", size=0.5) + 
        scale_y_continuous(labels = comma) + 
        xlim(c(start, end)) + 
        theme(plot.background = element_rect(fill = "#f8f8f8"), axis.ticks = element_blank())
    }
    
    # Draw the plot
    plotfunc(sensor_data, measure, start, end)
  
  }) 
  
})


