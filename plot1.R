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

# Print the histogram and save it to a png file
png(filename = "plot1.png", width = 480, height = 480)
with(dataFiltered, hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))
dev.off()