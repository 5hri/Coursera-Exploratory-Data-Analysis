#specify the file to load from your working directory
#download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#set path to directory with rds files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

aggbyyear <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png", width=480, height=480,units="px",bg="transparent")
par(mar=c(5, 5, 4, 2) + 0.1) # adjust margins for labels
barplot(aggbyyear$Emissions/10^6, names.arg=aggbyyear$year,
     col="red", 
     main=expression('Total PM'[2.5]*' emissions at each year from all US sources'), 
     xlab="Year",
     ylab=expression("Total PM"[2.5]*~"emission("~10^{6}~"Tons)"))

dev.off()
