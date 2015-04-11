# read in data file, converting numerical data
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                    na.strings = "?", stringsAsFactors = FALSE,
                    colClasses = c( "character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))    

# convert Date column and filter to reduce down to the requested date range
power$Date <- as.Date(power$Date, "%d/%m/%Y")
powerPlotData <- power[(power$Date >= "2007-02-01") & (power$Date <= "2007-02-02"),]


# create histogram of Global Active Power, saving as PNG file
png("plot1.png", width=480, height=480)
hist(powerPlotData$Global_active_power,
     col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power"
)
dev.off()

