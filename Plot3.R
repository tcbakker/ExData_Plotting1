## FILENAME - Plot3.R
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

##Plot 3

## First convert Date & Time to new variable: DateTime to be used in the plot
## See for reference https://class.coursera.org/exdata-002/forum/thread?thread_id=77

# Date column should be of type Date with correct format, 
# Time column is character, then you combine them into single variable of type POSIXct. 
# Then you use this new variable as x for plotting.

DT1$DateTime <- as.POSIXct(paste(DT1$Date,DT1$Time),format='%d/%m/%Y %H:%M:%S') # Create new variable
head(DT1) # display first rows to check content visually

# Set Locale to Englisch to create scale in Thu, Fri, Sat
Sys.setlocale("LC_TIME", "C")

# construct a plot 
# save it to PNG
# 480x480 px
# create separate R code file - plot2.R (including reading the data and creating the PNG file)

##Plot 3
# Title = empty
# label x = empty; 
# label y = Energy sub metering
# Type = plot
# Scale x = Thu, Fri, Sat; Scale y = 0 - 30, steps 10
# Color = Sub_metering_1 = black, Sub_metering_2 = red, Sub_metering_3 = blue
# Size = 480 x 480
# Format = png
# Legend = TRUE

## Open png device; create 'Plot3' in my working directory
png(filename = "Plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
## Create plot and send to file (no plot appears on the screan)
with(DT1, {
plot(DateTime, Sub_metering_1,
               type = "l",
               main = "", 
               ylab = "Energy sub metering",
               xlab = "")
lines(DateTime, Sub_metering_2,col="red")
lines(DateTime, Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), col=c("black","red","blue"))
})
## Close the png device
dev.off()
## Now you can view the file 'Plot3.png' on your computer

####################### DELETE DATASET ####################### 

## Wrap up: delete data directory with content
file.remove(zipName)
file.remove(fileName)
file.remove(dirName)