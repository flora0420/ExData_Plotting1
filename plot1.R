# plot1.R view the histogra of Global_active_power
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
par(bg = NA)
par(mar = c(5,4,3,2))
hist(data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()
