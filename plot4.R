data <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
                   na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time),
                       format="%Y-%m-%d %H:%M:%S")

gap <- as.numeric(subset_data$Global_active_power)
grp <- as.numeric(subset_data$Global_reactive_power)
volt <- as.numeric(subset_data$Voltage)
sm1 <- as.numeric(subset_data$Sub_metering_1)
sm2 <- as.numeric(subset_data$Sub_metering_2)
sm3 <- as.numeric(subset_data$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))


plot(datetime, gap, type="l", xlab="", ylab="Global Active Power", xaxt="n")
axis.POSIXct(1, at=seq(from=min(datetime), to=max(datetime)+86400, by="day"), format="%a")


plot(datetime, volt, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
axis.POSIXct(1, at=seq(from=min(datetime), to=max(datetime)+86400, by="day"), format="%a")

plot(datetime, sm1, type="l", xlab="", ylab="Energy sub metering", col="black", xaxt="n")
lines(datetime, sm2, col="red")
lines(datetime, sm3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, bty="n")
axis.POSIXct(1, at=seq(from=min(datetime), to=max(datetime)+86400, by="day"), format="%a")

plot(datetime, grp, type="l", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis.POSIXct(1, at=seq(from=min(datetime), to=max(datetime)+86400, by="day"), format="%a")

dev.off()
