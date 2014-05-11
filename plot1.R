source('fetch_data.R')

data <- fetch_data()

png(
  "plot1.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

hist(data$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global active power (kilowatts)")

dev.off()
