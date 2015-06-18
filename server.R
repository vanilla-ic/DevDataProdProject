library(maps)
library(mapproj)
eclipse <- readRDS("data/eclipse.rds")

shinyServer(
        function(input, output) 
            {
              output$map <- renderPlot(
                   {
                       eclipseType <- input$var
                       min = as.numeric(input$range[1])
                       max = as.numeric(input$range[2])
                       
                       data <- eclipse[eclipse$year>= min & eclipse$year<= max, ]
                       data <- data[data$ecType == eclipseType, ]
                            
                output$documentation <- renderText({"The geographic latitude and longitude are given for the location where the Moon lies in the zenith at greatest eclipse for each eclipse. The zenith is where the greatest eclipse is directly overhead.
There is a dropdown where you can select which type of eclipse to view. The options are :Total, Partial, and Penumbral.
Once you have selected which type of eclipse please select the year period. You can move the slider from 1999 B.C to 3000 A.D.
The location for the Lunar Eclipse Zenith's will be displayed on the map to the right of the widgets."})
                
                       map("world")
                                                                     
                       points(x = data$long, y = data$lat, pch= 20, col="blue")
                   })
            }
)
