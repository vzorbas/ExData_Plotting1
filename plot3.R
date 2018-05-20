# Author: vzorbas 
# Created: 20/5/2018 

library(dplyr)

# The script assumes that the required dataset is already downloaded and unziped to the current  
# working directory with filename = "household_power_consumption.txt" 

# This is done with the following commands (uncomment if needed)
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_data.zip")
#unzip("household_data.zip")

# load data from dataset, Convert to Date and time, and subset required days 
d <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";", as.is=TRUE)
d <- mutate(d, Date = as.Date(Date,"%d/%m/%Y"), Time =as.POSIXct(strptime(paste(d$Date, d$Time),"%d/%m/%Y %H:%M:%S")))
d <- filter (d, Date %in% c(as.Date("2007-02-01","%Y-%m-%d"), as.Date("2007-02-02","%Y-%m-%d")))

# Create plot1.png using the base ploting system 
png(filename = "plot3.png", width = 480, height = 480 )

plot (d$Time, d$Sub_metering_1, ylab="Energy sub metering", xlab=NA, type = "n")
lines ( d$Time, d$Sub_metering_1, type ="l")
lines ( d$Time, d$Sub_metering_2, type ="l", col="red")
lines ( d$Time, d$Sub_metering_3, type ="l", col="blue")
legend (x="topright", lwd =1 , col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

dev.off()

