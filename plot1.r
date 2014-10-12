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



#Plot 1
hist(
        x=df$Global_active_power, 
        breaks=12,
        col="Red", 
        ylim=c(0,1200),
        xlab="Global Active Power (kilowatts)",
        ylab = "Frequency",
        main= "Global Active Power"     
)
axis(side=1, at=seq(0,6, 2))
axis(side=2, at=seq(0,1200, 200))

## Saving Plot 1 to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()