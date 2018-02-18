# Coursera Plot 4 -  Exploratory Data Analysis
# Saranga Ram - 02/18/2018

# File plot4.R

# Things To Do -
# Load the source data
# Subset on specified Date Range - 2007-02-01 and 2007-02-02
# set output to a png
# Plot 
# Reset the device

filePath <- "~/RProjects/ExploratoryDataAnalysis"

# Read in the data 
hPc     <- read.table(paste(filePath, '/household_power_consumption.txt', sep=""), header=TRUE,sep=";", stringsAsFactors=FALSE, dec=".",na.strings="?") 
hPc <- hPc[hPc$Date %in% c("1/2/2007","2/2/2007"),]

datetime <- strptime(paste(hPc$Date, hPc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
gAp <- as.numeric(hPc$Global_active_power)
sM1 <- as.numeric(hPc$Sub_metering_1)
sM2 <- as.numeric(hPc$Sub_metering_2)
sM3 <- as.numeric(hPc$Sub_metering_3)
gRP <- as.numeric(hPc$Global_reactive_power)
voltage <- as.numeric(hPc$Voltage)

png("~/RProjects/ExploratoryDataAnalysis/plot4.png")

par(mfrow = c(2, 2)) 

plot(datetime, gAp, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, sM1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sM2, type="l", col="red")
lines(datetime, sM3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(datetime, gRP, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()