## Download and unzip the dataset if it doesn't exist locally
dataset_zip_name <- "electric_power_consumption.zip"

if(!file.exists(dataset_zip_name)) {
  dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url=dataset_url, destfile = dataset_zip_name, method="curl" )
}

dataset_file_name <- "household_power_consumption.txt"
if(!file.exists(dataset_file_name)) {
  unzip(dataset_zip_name)
}

## Read the dataset in and convert the datatype of some columns
household_power <- read.table(dataset_file_name, sep=";", header=T, na.strings = c("NA", "?"))

household_power$DateTime <- strptime(paste(household_power$Date, household_power$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Subset the dataset to only the specific dates
household_power_subset <- household_power[which(household_power$DateTime>="2007-02-01" & household_power$DateTime<"2007-02-03"),]

## Make the plot
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
## Upper Left quadrant
plot(household_power_subset$DateTime, household_power_subset$Global_active_power, type='n', main="", xlab="", ylab="Global Active Power")
lines(household_power_subset$DateTime, household_power_subset$Global_active_power, type='l', col="black")

## Upper right quadrant
plot(household_power_subset$DateTime, household_power_subset$Voltage, type='n', main="", xlab="datetime", ylab="Voltage")
lines(household_power_subset$DateTime, household_power_subset$Voltage, type='l', col="black")

## Lower left quadrant
plot(rep(household_power_subset$DateTime,3), c(household_power_subset$Sub_metering_1, household_power_subset$Sub_metering_2, household_power_subset$Sub_metering_3), type='n', main="", xlab="", ylab="Energy sub metering")
lines(household_power_subset$DateTime, household_power_subset$Sub_metering_1, type='l', col="black")
lines(household_power_subset$DateTime, household_power_subset$Sub_metering_2, type='l', col="red")
lines(household_power_subset$DateTime, household_power_subset$Sub_metering_3, type='l', col="blue")
legend("topright", legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lwd=1, col = c("black", "red", "blue"), bty='n')

## Lower right quadrant
plot(household_power_subset$DateTime, household_power_subset$Global_reactive_power, type='n', main="", xlab="datetime", ylab="Global_reactive_power")
lines(household_power_subset$DateTime, household_power_subset$Global_reactive_power, type='l', col="black")
dev.off()