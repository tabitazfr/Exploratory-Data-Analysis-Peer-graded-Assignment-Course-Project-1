data <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
                   na.strings="?", stringsAsFactors=FALSE)

# Format Date & subset
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time),
                       format="%Y-%m-%d %H:%M:%S")

sm1 <- as.numeric(subset_data$Sub_metering_1)
sm2 <- as.numeric(subset_data$Sub_metering_2)
sm3 <- as.numeric(subset_data$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, sm1, type="l", col="black", xlab="", ylab="Energy sub metering", xaxt="n")
lines(datetime, sm2, col="red")
lines(datetime, sm3, col="blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

axis.POSIXct(1,
             at = seq(from = as.POSIXct("2007-02-01"),
                      to   = as.POSIXct("2007-02-03"),
                      by   = "day"),
             format = "%a")
dev.off()
