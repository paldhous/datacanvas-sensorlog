# datacanvas-sensorlog

I am taking part in [Data Canvas: Sense Your City](http://datacanvas.org/sense-your-city/), a project to build a network of 100 sensors in seven cities around the world: San Francisco, Boston, Rio de Janeiro, Geneva, Bangalore, Singapore and Shanghai.

This app displays the output from a single sensor node. You can view it live [here](https://paldhous.shinyapps.io/datacanvas-sensor/), displaying data from my sensor node in San Francisco.

See [here](http://datacanvas.org/wp-content/uploads/2015/01/Data-Canvas-Sense-Your-City-Node-instructions.pdf) and [here](http://vimeo.com/116127882) for details on the sensors and the node assembly.

### To deploy this app for your sensor node

- Install [R](http://www.r-project.org/) and [RStudio](http://www.rstudio.com/). In R Studio, install/update the packages on which the R scripts depend: [jsonlite](http://cran.r-project.org/web/packages/jsonlite/index.html), [dplyr](http://cran.r-project.org/web/packages/dplyr/index.html), [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html), [scales](http://cran.r-project.org/web/packages/scales/index.html), [shiny](http://cran.r-project.org/web/packages/shiny/index.html), [markdown](http://cran.r-project.org/web/packages/markdown/index.html) and [BH](http://cran.r-project.org/web/packages/BH/index.html). [Here](http://dss.princeton.edu/training/RStudio101.pdf) is an introduction to working with RStudio, including how to install packages.

- `get_data.R` retrieves your sensor node data. You will need to replace `[Your-ID]` with the ID for your own sensor node before running the script, and `[Path-to-file]` to the location on your computer where the data file will be saved.

- Upload the resulting file `sensor_data.csv` to a webserver that allows you to run [cron jobs](http://en.wikipedia.org/wiki/Cron).

- `update_data.php` updates the file `sensor_data.csv`. Again, replace `[Your-ID]` with the ID for your own sensor, then upload the script to your webserver in the same folder as the data file. Set a cron job to run this script at the top of each hour. (Your webhosting service should provide instructions on how to do this, [for example](https://my.bluehost.com/cgi/help/411).)

- The web app is made with [Shiny](http://shiny.rstudio.com/), and depends on three files: `ui.R`, `server.R` and `include.md`. Place these in a folder with an appropriate name for your app. In `server.R`, you will need to replace `[URL]` with the web address for the folder containing your `sensor_data.csv` file. `include.md` is a [Markdown](http://en.wikipedia.org/wiki/Markdown) file that is converted into the HTML of the app's title and intro text. Feel free to edit this text, however please retain the link to this code repository on GitHub. (If you are not familiar with Markdown, [Haroopad](http://pad.haroopress.com/) provides a nice UI for editing Markdown documents.)

- You can deploy the app with a free account at [shinyapps.io](https://www.shinyapps.io/). Sign up and then follow [these instructions](http://shiny.rstudio.com/articles/shinyapps.html).


