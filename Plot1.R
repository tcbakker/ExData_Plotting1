## FILENAME - Plot1.R
## AUTHOR - T Bakker

####################### PLEASE NOTICE ####################### 
## 1. First set the working directory to Source File Location (the current file)
## 2. The dataset is downloaded, extracted, used and then removed
## 3. I've used a SQL method to create a subset. See below for instructions.

####################### GET DATA AND STORE LOCALLY ####################### 

## set names of url and local files
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dirName <- "data"
zipName <- "data/household_power_consumption.zip"
fileName <- "data/household_power_consumption.txt"

## create directory if it does not exists
if(!file.exists(dirName)){
    dir.create(dirName)
}

## get data, extract and store locally
download.file(fileUrl, destfile = zipName, method="curl")
unzip(zipName, exdir=dirName)
list.files(dirName) # check if the files are present

####################### METHOD USED - Using SQL to extract dataset ####################### 
## based on https://class.coursera.org/exdata-002/forum/thread?thread_id=19
## comment by Syed Tariq

## Please note! Install the package sqldf in RStudio
require("sqldf") # require library sqldf

myFile <- fileName 
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'" # define SQL; only select 2 dates
DT1 <- read.csv2.sql(myFile,mySql) # execute; this will result in a subset; do not abort - it can take a while
head(DT1) # display first rows to check content visually


##################################### PLOTS ######################################
# The goal here is simply to examine how household energy usage 
# varies over a 2-day period in February, 2007.

#Plot 1 instructions

# construct a plot 
# save it to PNG
# 480x480 px
# create separate R code file - plot1.R (including reading the data and creating the PNG file)

##Plot 1
# Title = Global Active Power (bold)
# label x = Global Active Power (kilowatts); Label y = Frequency; 
# Type = Histogram
# Scale x = 0 - 6, steps 2; Scale y = 0 - 1200, steps 200
# Color = red
# Size = 480 x 480
# Format = png

## Open png device; create 'Plot1' in my working directory
png(filename = "Plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
## Create histogram and send to file (no hist appears on the screan)
with(DT1, hist(as.numeric(Global_active_power),
               main = "Global Active Power", 
               col = "red",
               xlab = "Global Active Power (kilowatts)"),
     xlim = c(0, 6)
)
## Close the png device
dev.off()
## Now you can view the file 'Plot1.png' on your computer

####################### DELETE DATASET ####################### 

## Wrap up: delete data directory with content
file.remove(zipName)
file.remove(fileName)
file.remove(dirName)



