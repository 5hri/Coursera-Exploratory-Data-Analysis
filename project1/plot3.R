#specify the file to load from your working directory
raw <- "~/R/exp_data_ana_coursera/project1/household_power_consumption.txt"
data <- read.table(raw, header=TRUE, sep=";",na.strings="?", stringsAsFactors=FALSE, dec=".")
s.data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

png("plot3.png", width=480, height=480)
s.data$Timestamp <-strptime(paste(s.data$Date, s.data$Time), "%d/%m/%Y %H:%M:%S")
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

dev.off()
