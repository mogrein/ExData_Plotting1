data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_zip_name <- "exdata_data_household_power_consumption.zip"
data_file_name <- "household_power_consumption.txt"

# Download file if not exists.
if (!file.exists(data_zip_name)){
    if (.Platform$OS.type == "windows") {
        library(downloader);
        downloader::download(data_url, data_zip_name);
    } else {
        #can also use downloader::download
        download.file(data_url, data_zip_name, method="curl");
    }
}

data_file <- unz(data_zip_name, data_file_name);
##I've enough ram. Sqldf doesn't work with unz and grep is not installed on all systems
##Don't want to unzip file
data <- read.csv2(data_file, header = TRUE, na.strings = "?", dec=".",
                  colClasses = c(rep("character", 2), rep("numeric", 7)));
data <- data[(data$Date == "1/2/2007")|(data$Date == "2/2/2007"),]
data$TimeStamp <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

#This line needed to get english names of weekdays on plot
Sys.setlocale("LC_TIME", "C")

png(filename="plot3.png", width=480, height=480, bg = NA)
with(data, plot(TimeStamp, data$Sub_metering_1 , type = "l", main = "",
                ylab = "Energy sub metering", xlab="", col = "black"))
lines(data$TimeStamp, data$Sub_metering_2, col = "red")
lines(data$TimeStamp, data$Sub_metering_3, col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), 
       col=c("black","red","blue")) # gives the legend lines 
dev.off()
