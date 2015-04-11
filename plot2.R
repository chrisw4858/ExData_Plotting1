# read in data file, converting numerical data
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                    na.strings = "?", stringsAsFactors = FALSE,
                    colClasses = c( "character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))    

# convert Date column and filter to reduce down to the requested date range
power$Date <- as.Date(power$Date, "%d/%m/%Y")
powerPlotData <- power[(power$Date >= "2007-02-01") & (power$Date <= "2007-02-02"),]

# create a date-time column for time series charting
powerPlotData$DateTime =  strptime(paste0(powerPlotData$Date," ",powerPlotData$Time), 
                                    "%Y-%m-%d %H:%M:%S")


# create a time series chart of Global Active Power
png("plot2.png", width=480, height=480)
plot(powerPlotData$DateTime,powerPlotData$Global_active_power, 
     ylab="Global Active Power (kilowatts)",
     xlab="",
     main="",
     type="n")
lines(powerPlotData$DateTime,powerPlotData$Global_active_power)
dev.off()
