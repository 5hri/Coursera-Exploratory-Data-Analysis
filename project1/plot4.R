data <- read.table(raw, header=TRUE, sep=";",na.strings="?", stringsAsFactors=FALSE, dec=".")
s.data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
s.data$Timestamp <-strptime(paste(s.data$Date, s.data$Time), "%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

#plot 1
with(s.data, 
     plot(Timestamp, as.numeric(Global_active_power), 
          xlab = "", ylab = "Global Active Power",type = "l")
)

#plot 2
with(s.data, 
     plot(Timestamp, as.numeric(Voltage), 
          xlab = "", ylab = "Voltage",type = "l")
)

#plot 3
with(s.data, 
     plot(Timestamp, as.numeric(Sub_metering_1), 
          xlab = "", ylab = "Energy Submetering",type = "l")
)

with(s.data,     
     lines(Timestamp, as.numeric(s.data$Sub_metering_2), type = "l", col = "red")
)

with(s.data,     
     lines(Timestamp, as.numeric(s.data$Sub_metering_3), type = "l", col = "blue")
)

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

#plot 4
with(s.data, 
     plot(Timestamp, as.numeric(Global_reactive_power), 
          xlab = "", ylab = "Global_reactive_power",type = "l")
)

dev.off()
