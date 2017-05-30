# plot4.R four plots:
# 1. Global_active_power
# 2. Voltage
# 3. Energy sub metering
# 4. Global_reactive_power

###################
## load data     ##
###################
tmp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tmp)
data <- read.table(unz(tmp, "household_power_consumption.txt"),
                   sep = ";", header = T, as.is = T)
unlink(tmp)

###################
## format data   ##
###################
data$Date <- as.Date(strptime(data$Date, "%d/%m/%Y"))
data <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]
data[, 3:8] <- sapply(data[, 3:8], function(x){as.numeric(x)})


###################
## plot          ##
###################
par(bg = NA, mar = c(1,1,1,1), mfrow = c(2,2))
## top left
par(mar = c(4,4,3,2))
plot(data$Global_active_power, type = "l",
     xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = NA)
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

## top right
plot(data$Voltage, type = "l",
     xaxt = "n", ylab = "Voltage", xlab = "datetime")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

## bottom left
par(mar = c(4,4,4,2))
plot(data$Sub_metering_1, type = "l",
     xaxt = "n", ylab = "Energy sub metering", xlab = NA)
lines(data$Sub_metering_2, col = "red")
lines(data$Sub_metering_3, col = "blue")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", col = c("black", "red", "blue"),
       legend = paste0("Sub_metering_", 1:3), lty = 1,
       lwd = 2, y.intersp = .4, cex = 1, bty = "n", inset = c(-.02, -.06))
## bottom right
plot(data$Global_reactive_power, type = "l",
     xaxt = "n", xlab = "datetime")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, file = "plot4.png")
dev.off()
