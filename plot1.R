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

data <- read.csv(file);
rm(data)
