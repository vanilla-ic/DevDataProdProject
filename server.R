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
                                              
                       map("world")
                                                                     
                       points(x = data$long, y = data$lat, pch= 20, col="blue")
                   })
            }
)
