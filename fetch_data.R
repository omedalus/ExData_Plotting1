# Retrieves a data table from the zipfile and presents it to us in
# a usable format.

fetch_data <- function() {
  datafilename <- 'household_power_consumption.txt'
  
  if (!file.exists(datafilename)) {
    # Download and unzip the file, and open a connection to it.
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
                  'household_power_consumption.zip')
    unzip('household_power_consumption.zip')
  }
  
  filecon <- file(datafilename, 'rt')
  
  # We don't want to read the whole file at once because it's huge,
  # but we can read it in 10,000-line increments, and only keep the
  # rows we like.
  
  # First let's read the header, though.
  header <- read.delim(filecon, sep=";", stringsAsFactors = F, nrows = 1)
  

  data <- NULL
  hadKept <- F
  while (T) {
    dataChunk <- read.delim(filecon, sep=";", header = F, stringsAsFactors = F, 
                            nrows = 10000)
    if (nrow(dataChunk) == 0) {
      break
    }
    names(dataChunk) <- names(header)
    
    dataChunk$datetime <- strptime(paste(dataChunk$Date, dataChunk$Time, sep=" "), format="%d/%m/%Y %X")
    dataChunkToKeep <- dataChunk[as.Date(dataChunk$datetime) >= as.Date("2007/02/01") & as.Date(dataChunk$datetime) <= as.Date("2007/02/02"), ]
    
    if (nrow(dataChunkToKeep) > 0) {
      hadKept <- T
    }
    if (hadKept & nrow(dataChunkToKeep) == 0) {
      break
    }

    data <- rbind(data, dataChunkToKeep)
  }

  # Return data.
  data$Time <- strptime(data$Time, format="%H:%M:%S")
  data$Global_active_power <- as.numeric(data$Global_active_power)
  data
}
