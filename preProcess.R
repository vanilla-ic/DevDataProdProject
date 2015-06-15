download.file("http://eclipse.gsfc.nasa.gov/5MCLE/5MKLEcatalog.txt",destfile="eclipse5MCLE.csv",method="curl")

eclipse <- read.csv('eclipse5mCLE.csv', head=F, sep="", skip=13)
colnames(eclipse) <- c("num", "year", "month","day", "climax", "td", "lunaNum", "sarosNum", "ecType", "qse", "gamma", "penMag", "umMag", "pen",
                    "par", "total", "lat", "long")

#Check for NA's. fyi, NASA data is usually complete.
sum(is.na(eclipse))

library(maps)
library(Hmisc)
library(shiny)

#changing the S & W to -ve
southLat <- grep("S", x = eclipse$lat, value = F, ignore.case = T)
eclipse$lat <- gsub("N|S", replace = "", x = eclipse$lat, ignore.case = T)
eclipse$lat <- as.numeric(eclipse$lat)
eclipse$lat[southLat] <- -1 * eclipse$lat[southLat]

westLong <- grep("W", x = eclipse$long, value = F, ignore.case = T)
eclipse$long <- gsub("E|W", replace = "", x = eclipse$long, ignore.case = T)
eclipse$long <- as.numeric(eclipse$long)
eclipse$long[westLong] <- -1 * eclipse$long[westLong]

#group by total, partial and penumbral.
eclipse$ecType <- gsub("T\\+|T-|T", replace = "Total", x = eclipse$ecType, ignore.case = T)
eclipse$ecType <- gsub("P", replace = "Partial", x = eclipse$ecType, ignore.case = T)
eclipse$ecType <- gsub("N|Nb|Ne|Nx", replace = "Penumbral", x = eclipse$ecType, ignore.case = T)

#Just take the 20th Century. Do this if shiny has a problem with the large data set.
#eclipse <- eclipse[eclipse$year>=1901 & eclipse$year<=2000,]

#Keep just necessary columns specific to this app.
eclipse <- eclipse[,c(2,9,17,18)]

table(eclipse$ecType)

# mapping, to test if the data looks about right.
map("world")
points(eclipse$long,eclipse$lat,pch=20,col="blue")


saveRDS(eclipse,file="eclipse.rds")
eclipse <- readRDS("eclipse.rds")
file.remove("eclipse5MCLE.csv")

