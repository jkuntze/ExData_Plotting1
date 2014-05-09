library(data.table)
file <- "./household_power_consumption.txt"
DT <- fread(file, sep =";", na.strings = "?")
DT2 <- subset(DT, DT$Date == "1/2/2007" | DT$Date == "2/2/2007")
DT2 <- transform(DT2, Date = as.Date(Date, "%d/%m/%y"), 
                 Time = as.ITime(Time, format = "%H:%M:%S"), 
                 Global_active_power = as.double(Global_active_power), 
                 Global_reactive_power = as.double(Global_reactive_power), 
                 Voltage = as.double(Voltage), 
                 Global_intensity = as.double(Global_intensity), 
                 Sub_metering_1 = as.double(Sub_metering_1), 
                 Sub_metering_2 = as.double(Sub_metering_2), 
                 Sub_metering_3 = as.double(Sub_metering_3))
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot.ts(DT2$Sub_metering_1, xlab = "", 
        ylab = "Energy sub metering", axes = FALSE)
lines(DT2$Sub_metering_2, col= "red")
lines(DT2$Sub_metering_3, col= "blue")
axis(1, at = c(0, which(DT2$Time==as.ITime("23:59:00"))), 
     labels = c("Thu","Fri","Sat"))
axis(2)
box()
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"),
       col=c("black","red","blue"), 
       lwd = 1)
dev.off()