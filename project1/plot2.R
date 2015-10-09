#specify the file to load from your working directory
raw <- "~/R/exp_data_ana_coursera/project1/household_power_consumption.txt"
data <- read.table(raw, header=TRUE, sep=";",na.strings="?", stringsAsFactors=FALSE, dec=".")
s.data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

png("plot2.png", width=480, height=480)
s.data$Timestamp <-strptime(paste(s.data$Date, s.data$Time), "%d/%m/%Y %H:%M:%S")
with(s.data, 
     plot(Timestamp, as.numeric(Global_active_power), 
          type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
)
dev.off()