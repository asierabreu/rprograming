# Exploratory Data Analysis
# Course Project 1
# R Script to produce plot2
# Author : Asier Abreu

# Read in data , only read the required data (skip + nrows)
data<-read.csv(file = "household_power_consumption.txt", header=TRUE,sep = ";",skip = 66637,nrows = 2881)
colnames(data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity", 
                  "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# open device for plotting
png(filename = "plot2.png",width = 480,height = 480,units = "px")

# create an extra column with combined date + time
data$Z <-paste(data$Date,data$Time,sep='-')

plot(x = strptime(data$Z, format='%d/%m/%Y-%H:%M:%S'),
     y = data$Global_active_power,
     xlab = "Week Day",
     ylab = "Global Active Power (Kilowatts)",col = "dark green",
     type = "l")

dev.off()
message(" --> created file : plot2.png") 