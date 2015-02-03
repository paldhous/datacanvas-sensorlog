# load required libraries
library(jsonlite)
library(dplyr)
library(ggplot2)

sequence <- seq(0, 500000, by=1000)

# retrieve records at max rate of 1000 at a time, store them in a list of data frames
baseurl <- "https://localdata-sensors.herokuapp.com/api/sources/[Your-ID]/entries?startIndex="
pages <- list()
for(i in sequence){
  sensor_data <- fromJSON(paste0(baseurl, i, "&count=1000&sort=desc"))
  if(is.na(sensor_data)) break
  message("Retrieving records from: ", i)
  pages[[i+1]] <- sensor_data
}

# combine the list into a single data frame
sensor_data_all <- rbind.pages(pages)

# process data
sensor_data <- flatten(sensor_data_all, recursive = TRUE) %>%
  rename(airquality=data.airquality, airquality_raw=data.airquality_raw, dust=data.dust, humidity=data.humidity, light=data.light, sound=data.sound, temperature=data.temperature, uv=data.uv) %>%
  select(timestamp, airquality_raw, dust, humidity, light, sound, temperature, uv) %>%
  mutate(timestamp=as.POSIXct(strptime(timestamp, "%Y-%m-%dT%H:%M:%S.000Z"))) %>%
  filter(timestamp>"2015-01-17 00:00:00")

# write to CSV file
write.csv(sensor_data, file="[Path-to-file]/sensor_data.csv", row.names=FALSE, quote=FALSE)







