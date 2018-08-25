# Load the file
data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE)

# Transform the factors to char  
data[, c(1:8)] <- sapply(data[, c(1:8)], as.character)
# Tranform the chars to num
data[, c(3:8)] <- sapply(data[, c(3:8)], as.numeric)

# Convert the Date variable to Date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")
# Convert the Time variable to times class
library(chron)
data$Time <- times(data$Time)

# Filter the dataframe
library(dplyr)
dataFiltered <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

# Create a new column DateTime
dataFiltered$DateTime <- as.POSIXct(paste(dataFiltered$Date, dataFiltered$Time), format="%Y-%m-%d %H:%M:%S")

# Print the graphic and save it to a png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with (dataFiltered, {
plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(DateTime, Voltage, type = "l", ylab = "Voltage")
plot(DateTime, Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
points(DateTime, Sub_metering_2, col = "red", type = "l")
points(DateTime, Sub_metering_3, col = "blue", type = "l") 
legend("topright", col = c("black", "red", "blue"), lty = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty = 0)
plot(DateTime, Global_reactive_power, type = "l")
})
dev.off()