#specify the file to load from your working directory
#download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#set path to directory with rds files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use Baltimore's fip to subset NEI data 
baltinei <- NEI[NEI$fips=="24510",]

# Baltimore data by year
balti.aggbyyear <- aggregate(Emissions ~ year,baltinei, sum)

png("plot2.png", width=480, height=480,units="px",bg="transparent")
par(mar=c(5, 5, 4, 2) + 0.1) # adjust margins for labels
barplot(balti.aggbyyear$Emissions/10^3, names.arg=balti.aggbyyear$year,
        col="red", 
        main=expression('Total PM'[2.5]*' emissions at each year from Baltimore'), 
        xlab="Year",
        ylab=expression("Total PM"[2.5]*~"emission("~10^{3}~"Tons)"))

dev.off()
