rm(list=ls())
library(data.table)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
elec <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)
x<-grep("^[12]/2/2007",elec$Date)
y<- elec[x, ]

y$Date<-as.character(y$Date)
y$Date<- as.Date(y$Date, "%d/%m/%Y")
y$Da<- as.POSIXct(paste(y$Date, y$Time), format="%Y-%m-%d %H:%M:%S")

y$Sub_metering_1<- as.character(y$Sub_metering_1)
y$Sub_metering_1<-as.numeric(y$Sub_metering_1)
y$Sub_metering_2<- as.character(y$Sub_metering_2)
y$Sub_metering_2<-as.numeric(y$Sub_metering_2)
y$Sub_metering_3<- as.character(y$Sub_metering_3)
y$Sub_metering_3<-as.numeric(y$Sub_metering_3)

y$Voltage<- as.character(y$Voltage)
y$Voltage<-as.numeric(y$Voltage)
y$Global_reactive_power<- as.character(y$Global_reactive_power)
y$Global_reactive_power<-as.numeric(y$Global_reactive_power)

windows()

par(mfrow = c(2, 2), mar = c(5, 5, 5, 5))
plot(y$Da, y$Global_active_power, pch=26, ylab = "Global Active Power (kilowatts)", xlab = "")
lines(y$Da, y$Global_active_power)

plot(y$Da, y$Voltage, pch=26, ylab = "Voltage", xlab = "datetime")
lines(y$Da, y$Voltage)

with(y, plot(Da, Sub_metering_1, ylab ="Energy sub metering", xlab = "", type = "n"))
with(y, points(Da, Sub_metering_1, pch=26))
with(y, lines(Da, Sub_metering_1))
with(y, points(Da, Sub_metering_2, pch=26))
with(y, lines(Da, Sub_metering_2, col="red"))
with(y, points(Da, Sub_metering_3, pch=26))
with(y, lines(Da, Sub_metering_3, col="blue"))
legend("topright",lwd=2, cex = 0.7, inset=c(0.01,0), col = c("black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(y$Da, y$Global_reactive_power, pch=26, ylab = "Voltage", xlab = "datetime")
lines(y$Da, y$Global_reactive_power)
dev.copy(png, file = "plot4.png", width=480,height=480)
dev.off()
