###
# file: plot1.R
# author: tony rossignol (tonyjrossignol@hotmail.com)
# date: 2015-01-08
#
# description: plot 1 - Global Active Power histogram
#       Explority Data Analysis - course project 1
#       https://class.coursera.org/exdata-010/
#       single script for the assignment
#        - read data (options for from web or from local file)
#        - create each plot and copy results to PNG
#
# notes: plot is based on data for 2007-02-01 & 2007-02-02
###


# load data from the web
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv2(unz(temp, "household_power_consumption.txt"),
                  na.strings = c("?","NA"), dec = ".")
unlink(temp)

# convert Date and Time columns into a new DateTime column
data$DateTime <- strptime(paste(data$Date,data$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

# convert Date column into a proper Date class
data$Date <- as.Date(data$DateTime)

# filter to disired range
trimmed <- data[data$Date >= "2007-02-01" & 
                        data$Date < "2007-02-03",]

hist(trimmed$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.copy(png,"plot1.png",width=480,height=480)
dev.off()
