## Selects the file via the read.csv.sql function, only the rows between 
## 1/2/2007 and 2/2/2007 are selected

library(sqldf)

data  <- read.csv.sql("household_power_consumption.csv", sql = "SELECT * from file WHERE 
                      Date IN ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## converts the characters in the Date and Time columns to the class "POSIXlt" and "POSIXt" creating 
## a complex time variable with d/m/y H/M/S that is pasted in data$TD

data$TD <- strptime(paste(data$Date, data$Time, sep = ","), format ="%d/%m/%Y,%H:%M:%S")

## creates the required plot 2 and prints it as a png file

png(file = "plot2.png")

plot(data$TD, data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (Kilowatts)")

dev.off()