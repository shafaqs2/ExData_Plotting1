rm(list=ls())
library(data.table)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
elec <- read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)
x<-grep("^[12]/2/2007",elec$Date)
y<- elec[x, ]

## Plot 1
y$Global_active_power<- as.character(y$Global_active_power)
y$Global_active_power<-as.numeric(y$Global_active_power)
hist(y$Global_active_power, xlab = "Global Active Power (kilowatts)", col="Red", main = "Globa Active Power")
dev.copy(png, file = "plot1.png", width=480,height=480)
dev.off()