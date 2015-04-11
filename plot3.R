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





# chart time series of sub metering
# Setting the y-axis limit to 0-40 results in a larger gap between the top 
# of the sub metering 1 spikes and the top of the chart
# -- it looks like the y-axis max was adjusted to around 38-39
png("plot3.png", width=480, height=480)

plot(powerPlotData$DateTime,powerPlotData$Global_active_power, 
     ylab="Energy sub metering",
     xlab="",
     yaxp=c(0,30,3),
     ylim=c(0,38),
     main="",
     type="n")
lines(powerPlotData$DateTime,powerPlotData$Sub_metering_1)
lines(powerPlotData$DateTime,powerPlotData$Sub_metering_2, col="red")
lines(powerPlotData$DateTime,powerPlotData$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
