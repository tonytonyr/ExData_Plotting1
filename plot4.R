###
# file: plot4.R
# author: tony rossignol (tonyjrossignol@hotmail.com)
# date: 2015-01-08
#
# description:  
#       combo plot
#       1- Global Active Power graph
#       2- Voltage graph
#       3- Energy Sub Metering comparision graph
#       4- Global Reactive Power graph
#
#       Explority Data Analysis - course project 1
#       https://class.coursera.org/exdata-010/
#       single script for the assignment
#        - read data (options for from web or from local file)
#        - create each plot and copy results to PNG
#
# notes: plot is based on data for 2007-02-01 & 2007-02-02
###

# load the data from local copy of data
data <- read.csv2(file = "data/household_power_consumption.txt", 
                  na.strings = c("?","NA"), dec = '.')

# convert Date and Time columns into a new DateTime column
data$DateTime <- strptime(paste(data$Date,data$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

# convert Date column into a proper Date class
data$Date <- as.Date(data$DateTime)

# filter to disired range
trimmed <- data[data$Date >= "2007-02-01" & 
                        data$Date < "2007-02-03",]


opar <- par(c("mfrow","mar")) # used to preserve graphing params
par(mfrow = c(2,2), mar = c(4.5,4.5,2,2))

plot(trimmed$DateTime, trimmed$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power")

with(trimmed, plot(DateTime, Voltage, type = "l"))

plot(trimmed$DateTime, trimmed$Sub_metering_1, 
     col = "black", type = "l", 
     xlab = "", ylab = "Energy sub metering")

lines(trimmed$DateTime, trimmed$Sub_metering_2, 
      col = "red", type = "l")

lines(trimmed$DateTime, trimmed$Sub_metering_3, 
      col = "blue", type = "l")

legend("topright", legend = c("Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"), 
       col = c("black","red","blue"), pch = "_", 
       bty = "n")

with(trimmed, plot(DateTime, Global_reactive_power, type = "l"))

dev.copy(png,"plot4.png",width=480,height=480)
dev.off()

par(opar) # resets the graphics parameters that where changed
