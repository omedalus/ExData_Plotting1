source('fetch_data.R')

data <- fetch_data()

png(
  "plot2.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

plot(data$datetime, 
     data$Global_active_power, 
     type="l", 
     lty=1, 
     xlab="", 
     ylab="Global active power (kilowatts)")

dev.off()
