#specify the file to load from your working directory
#download data from https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

raw <- "~/R/exp_data_ana_coursera/project1/household_power_consumption.txt"
data <- read.table(raw, header=TRUE, sep=";",na.strings="?", stringsAsFactors=FALSE, dec=".")
s.data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

png("plot1.png", width=480, height=480)
hist(as.numeric(s.data$Global_active_power), 
     col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
