rm(list=ls())
library(data.table)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
elec <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)
x<-grep("^[12]/2/2007",elec$Date)
y<- elec[x, ]

## Plot 2
y$Date<-as.character(y$Date)
y$Date<- as.Date(y$Date, "%d/%m/%Y")
y$Da<- as.POSIXct(paste(y$Date, y$Time), format="%Y-%m-%d %H:%M:%S")
plot(y$Da, y$Global_active_power, pch=26, ylab = "Global Active Power (kilowatts)", xlab = "")
lines(y$Da, y$Global_active_power)
dev.copy(png, file = "plot2.png", width=480,height=480)
dev.off()
