# Coursera Plot 1 -  Exploratory Data Analysis
# Saranga Ram - 02/18/2018

# File plot1.R

# Things To Do -
# Load the source data
# Subset on specified Date Range - 2007-02-01 and 2007-02-02
# set output to a png
# Plot 
# Reset the device

filePath <- "~/RProjects/ExploratoryDataAnalysis"

# Read in the data 
hPc     <- read.table(paste(filePath, '/household_power_consumption.txt', sep=""), header=TRUE,sep=";", stringsAsFactors=FALSE, dec=".",na.strings="?") 
hPcSub <- hPc[hPc$Date %in% c("1/2/2007","2/2/2007"),]

png("~/RProjects/ExploratoryDataAnalysis/plot1.png")

hist(as.numeric(hPcSub$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
