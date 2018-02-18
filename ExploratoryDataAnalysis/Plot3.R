# Coursera Plot 3 -  Exploratory Data Analysis
# Saranga Ram - 02/18/2018

# File plot3.R

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
#gAp <- as.numeric(hPc$Global_active_power)
sM1 <- as.numeric(hPc$Sub_metering_1)
sM2 <- as.numeric(hPc$Sub_metering_2)
sM3 <- as.numeric(hPc$Sub_metering_3)

png("~/RProjects/ExploratoryDataAnalysis/plot3.png")

plot(datetime, sM1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sM2, type="l", col="red")
lines(datetime, sM3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()
