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

    png("plot4.png")
    par(mfrow=c(2, 2))
    plot(ds$DateTime, ds$Global_active_power, xlab = "", ylab = "Global Active Power", type = "s")

    plot(ds$DateTime, ds$Voltage, ylab = "Voltage", xlab = "datetime", type = "s", yaxt = "n")
    axis(2, at = c(234, 236, 238, 240, 242, 244, 246), labels = FALSE)
    axis(2, at = c(234, 238, 242, 246), labels = c("234", "238", "242", "246"))

    plot(ds$DateTime, ds$Sub_metering_1, col = "black", type = "s", xlab = "", ylab = "Energy sub metering")
    points(ds$DateTime, ds$Sub_metering_2, col = "red", type = "s")
    points(ds$DateTime, ds$Sub_metering_3, col = "blue", type = "s")
    legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

    plot(ds$DateTime, ds$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "s")

    dev.off()
}
