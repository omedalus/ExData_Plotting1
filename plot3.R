source('fetch_data.R')

data <- fetch_data()

png(
  "plot3.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

plot(data$datetime, data[, 'Sub_metering_1'], type="n",
     ylab="Energy sub metering")

lines(data$datetime, data[, 'Sub_metering_1'], col="black")
lines(data$datetime, data[, 'Sub_metering_2'], col="red")
lines(data$datetime, data[, 'Sub_metering_3'], col="#4100ff")

legend("topright", 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c("black", "red", "#4100ff"), 
       lty = rep(1, 3))

dev.off()

