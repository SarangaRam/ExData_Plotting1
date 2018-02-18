# Coursera Plot 2 -  Exploratory Data Analysis
# Saranga Ram - 02/18/2018

# File plot2.R

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
png("~/RProjects/ExploratoryDataAnalysis/plot2.png")
plot(datetime, gAp, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()