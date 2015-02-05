# load required libraries
library(jsonlite)
library(dplyr)
library(ggplot2)

sequence <- seq(0, 500000, by=1000)

# retrieve records at max rate of 1000 at a time, store them in a list of data frames
url <- "https://localdata-sensors.herokuapp.com/api/sources/[Your-ID]/entries?&count=1000&sort=desc"
pages <- list()

for(i in sequence){
  sensor_data <- flatten(as.data.frame(fromJSON(url)), recursive = TRUE)
  if(is.na(sensor_data)) break
  message("Retrieving records from: ", i)
  url <- as.character(sensor_data$links.next[1])
  pages[[i+1]] <- sensor_data
}

# combine the list into a single data frame
sensor_data_all <- rbind.pages(pages)

# process the data
sensor_data <- rename(sensor_data_all, timestamp=data.timestamp, airquality_raw=data.data.airquality_raw, dust=data.data.dust, humidity=data.data.humidity, light=data.data.light, sound=data.data.sound, temperature=data.data.temperature, uv=data.data.uv) %>%
  select(timestamp, temperature, humidity, light, sound, airquality_raw, dust, uv) %>%
  mutate(timestamp=as.POSIXct(strptime(timestamp, "%Y-%m-%dT%H:%M:%S.000Z"))) %>%
  filter(timestamp>"2015-01-17 00:00:00")

# write to CSV file
write.csv(sensor_data, file="[Path-to-file]/sensor_data.csv", row.names=FALSE, quote=FALSE)



