####### Exploratory Data Analysis - Project 1 ########

library(dplyr)   ###Load in libraries
options(scipen=999, digits = 0)

###Download and read in file
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file.url, "EDAP1.zip")
unzip("EDAP1.zip", exdir="~/EDAP")

#Read in Data
data <- read.table("household_power_consumption.txt", 
                   sep=";", 
                   stringsAsFactors=F,
                   header=T,
                   na.strings = "?")

#Filter for correct dates
df <- filter(data, Date == "1/2/2007" | Date =="2/2/2007")

#add datetime field
df$datetime <- paste(df$Date, df$Time) %>% 
        strptime("%d/%m/%Y %H:%M:%S")



#Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,0,0)) 
#1st
plot(
        x=df$datetime, 
        y=df$Global_active_power,
        type="n",
        xlab = "",
        ylab = "Global Active Power (kilowatts)")
lines(x=df$datetime, 
      y=df$Global_active_power)

#2nd
plot(
        x=df$datetime,
        y=df$Voltage,
        type="l",
        xlab="datetime",
        ylab="Voltage (volt)"
)

#3rd
plot(   
        x=df$datetime, 
        y=df$Sub_metering_1,
        type="l",
        xlab = "",
        ylab = "Global Active Power (kilowatts)")
lines(x=df$datetime,  y=df$Sub_metering_2, col="Red")
lines(x=df$datetime,  y=df$Sub_metering_3, col="Blue") 
legend("topright", col=c("Black", "Red", "Blue"), lty=1, lwd=2, bty="n", cex=.5,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4th
plot(
        x=df$datetime,
        y=df$Global_reactive_power,
        type="l",
        xlab="datetime",
        ylab="Global_reactive_power (kilowatts)"
)


## Saving Plot 4 to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

