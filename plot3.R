downloadData <- function() {
    targetFile = "household_power_consumption.txt"

    if (!file.exists(targetFile)) {
        remoteFile = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        localFile = "hpc.zip"

        download.file(remoteFile, localFile)
        unzip(localFile, overwrite = TRUE)
    }

    hpc <<- read.delim(targetFile, header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c("?"))
    hpc$DateTime <<- strptime(paste(hpc$Date, hpc$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
    ds <<- subset(hpc, DateTime >= "2007/02/01" & DateTime < "2007/02/03")
}

main <- function() {
    downloadData()

    png("plot3.png")
    plot(ds$DateTime, ds$Sub_metering_1, col = "black", type = "s", xlab = "", ylab = "Energy sub metering")
    points(ds$DateTime, ds$Sub_metering_2, col = "red", type = "s")
    points(ds$DateTime, ds$Sub_metering_3, col = "blue", type = "s")
    legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
    dev.off()
}
