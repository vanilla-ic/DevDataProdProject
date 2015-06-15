
shinyUI(fluidPage(
        titlePanel("The location of 5,000 years of Lunar Eclipses"),
        
        sidebarLayout(
                sidebarPanel(
                        helpText("In the 5,000 year period from 1999 B.C. to 3000 A.D there are 12,064 Lunar Eclipses.
                                This application indicates the location of each Lunar Eclipse's Zenith at greatest eclipse. The three types 
                                of eclipses are mapped; Total, Partial, and Penumbral."),
                        
                        selectInput("var", 
                                    label = "Select the type of Lunar Eclipse",
                                    choices = c("Total", "Partial", "Penumbral"),
                                    selected = "Total"),
                        
                        sliderInput("range", 
                                    label = "Select the year period",
                                    min = -1999, max = 3000, value = c(1500,2000))
                        ),
                
                mainPanel(plotOutput("map"),
                h6("This data has been provided by Fred Espenak of NASA's GSFC. The full data set 
                   is from 1999 B.C to 3000 A.D..", align ="center"))
        )
))