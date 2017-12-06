# Exploratory Data Analysis
# Course Project 1
# R Script to produce plot1
# Author : Asier Abreu

# Read in data , only read the required data (skip + nrows)
data<-read.csv(file = "household_power_consumption.txt", header=TRUE,sep = ";",skip = 66637,nrows = 2881)
colnames(data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity", 
                  "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# open device for plotting
png(filename = "plot1.png",width = 480,height = 480,units = "px")

hist(data$Global_active_power,breaks = 25,
     main = "Global Active (Is it Green?) Power",xlab = "Global Active Power (Kilowatts)",
     xlim = c(0,6),
     ylab = "Frequency",col = "dark green")

text(x = 3,y=1200,labels = "... I'm daltonic")
dev.off()
message(" --> created file : plot1.png") 