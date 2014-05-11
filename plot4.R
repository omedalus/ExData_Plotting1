source('fetch_data.R')

data <- fetch_data()

png(
  "plot4.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

layout(matrix(c(1,2,3,4), nrow=2, ncol=2))

###########
# Plot upper left.

hist(data$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global active power (kilowatts)")

###########
# Plot lower left.

plot(data$datetime, data[, 'Sub_metering_1'], type="n",
     ylab="Energy sub metering")

lines(data$datetime, data[, 'Sub_metering_1'], col="black")
lines(data$datetime, data[, 'Sub_metering_2'], col="red")
lines(data$datetime, data[, 'Sub_metering_3'], col="#4100ff")

legend("topright", 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c("black", "red", "#4100ff"), 
       lty = rep(1, 3),
       bty = "n")

###########
# Plot upper right.

plot(data$datetime, data$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

###########
# Plot lower right.

plot(data$datetime, data$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
