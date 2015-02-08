## Selects the file via the read.csv.sql function, only the rows between 
## 1/2/2007 and 2/2/2007 are selected

library(sqldf)

data  <- read.csv.sql("household_power_consumption.csv", sql = "SELECT * from file WHERE 
                      Date IN ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## converts the characters in the Date and Time columns to the class "POSIXlt" and "POSIXt" creating 
## a complex time variable with d/m/y H/M/S that is pasted in data$TD

data$TD <- strptime(paste(data$Date, data$Time, sep = ","), format ="%d/%m/%Y,%H:%M:%S")

## creates the required plot 4 and prints it as a png file

png(file = "plot4")

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0, 0, 2, 0))

with(data, {
      plot(data$TD, data$Global_active_power,
           type = "l",
           xlab = "",
           ylab = "Global Active Power")
      
      plot(data$TD, data$Voltage,
           type = "l",
           xlab = "datetime",
           ylab = "Voltage")
      
      with(data, plot(data$TD, data$Sub_metering_1,
                      type = "n",
                      xlab = "",
                      ylab = "Energy sub metering",
                      yaxt = "n",))
            axis(2, at = c(0, 10, 20, 30))
            with(data, lines(data$TD, data$Sub_metering_1, col = "black"))
            with(data, lines(data$TD, data$Sub_metering_2, col = "red")) 
            with(data, lines(data$TD, data$Sub_metering_3, col = "blue"))
            legend("topright", lwd = "1", 
                   col = c("black", "red", "blue"), 
                   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                   bty = "n")
      
      plot(data$TD, data$Global_reactive_power,
           type = "l",
           xlab = "",
           ylab = "Global_reactive_power")
})

dev.off()
