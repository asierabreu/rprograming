# Exploratory Data Analysis
# Course Project 1
# R Script to produce plot3
# Author : Asier Abreu

# Read in data , only read the required data (skip + nrows)
data<-read.csv(file = "household_power_consumption.txt", header=TRUE,sep = ";",skip = 66637,nrows = 2881)
colnames(data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity", 
                  "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# open device for plotting
png(filename = "plot3.png",width = 480,height = 480,units = "px")

# create an extra column with combined date + time
data$Z <-paste(data$Date,data$Time,sep='-')

plot(x = strptime(data$Z, format='%d/%m/%Y-%H:%M:%S'),
     y = data$Sub_metering_1,
     xlab = "Week Day",
     ylab = "Energy sub metering",
     col = "black",
     type = "l"
     )

lines(x = strptime(data$Z, format='%d/%m/%Y-%H:%M:%S'),
      y = data$Sub_metering_2,
      col = "red",
      type = "l"
      )

lines(x = strptime(data$Z, format='%d/%m/%Y-%H:%M:%S'),
      y = data$Sub_metering_3,
      col = "blue",
      type = "l"
)


legend(
      strptime('2/2/2007-06:00:00',format='%d/%m/%Y-%H:%M:%S'),40,       # location
      c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), # text
      lty=c(1,1), # symbols (lines)
      lwd=c(2.5,2.5), # width
      col=c('black','red','blue') # color
      ) 


dev.off()
message(" --> created file : plot3.png") 