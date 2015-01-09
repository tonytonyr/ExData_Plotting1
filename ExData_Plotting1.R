###
# file: ExData_Plotting1.R
# author: tony rossignol (tonyjrossignol@hotmail.com)
# date: 2015-01-08
#
# description:  
#       Explority Data Analysis - course project 1
#       https://class.coursera.org/exdata-010/
#       single script for the assignment
#        - read data (options for from web or from local file)
#        - functions to create each plot
#        - execution of plot functions for each plot
#
# notes: all plots are based on data for 2007-02-01 & 2007-02-02
###

# load data from the web
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv2(unz(temp, "household_power_consumption.txt"),
                  na.strings = c("?","NA"), dec = ".")
unlink(temp)


# load the data from local copy of data
data <- read.csv2(file = "data/household_power_consumption.txt", 
                  na.strings = c("?","NA"), dec = '.')

# convert Date and Time columns into a new DateTime column
data$DateTime <- strptime(paste(data$Date,data$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

# convert Date column into a proper Date class
data$Date <- as.Date(data$DateTime)

# filter to disired range 2007-02-01 & 2007-02-02
trimmed <- data[data$Date >= "2007-02-01" & 
                        data$Date < "2007-02-03",]

# plot 1 - Global Active Power histogram
plot1 <- function() {
        hist(trimmed$Global_active_power, 
             col = "red",
             main = "Global Active Power",
             xlab = "Global Active Power (kilowatts)")
}

# plot 2 - Global Active Power graph
plot2 <- function(...) {
        plot(trimmed$DateTime, trimmed$Global_active_power, 
             type = "l", xlab = "", ...)
}

# plot 3 - Sub metering comparision graph
plot3 <- function(...) {
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
               col = c("black","red","blue"), pch = "_", ...)
}

# produce the plots & save PNG files
plot1()
dev.copy(png,"plot1_.png",width=480,height=480)
dev.off()

plot2(ylab = "Global Active Power (kilowatts)")
dev.copy(png,"plot2_.png",width=480,height=480)
dev.off()

plot3()
dev.copy(png,"plot3_.png",width=480,height=480)
dev.off()

# combo plot
# 1- Global Active Power graph
# 2- Voltage graph
# 3- Energy Sub Metering comparision graph
# 4- Global Reactive Power graph
#
opar <- par(c("mfrow","mar")) # used to preserve graphing params

par(mfrow = c(2,2), mar = c(4.5,4.5,2,2))
plot2(ylab = "Global Active Power")
with(trimmed, plot(DateTime, Voltage, type = "l"))
plot3(bty = "n")
with(trimmed, plot(DateTime, Global_reactive_power, type = "l"))
dev.copy(png,"plot4_.png",width=480,height=480)
dev.off()

par(opar) # restores graphing params

