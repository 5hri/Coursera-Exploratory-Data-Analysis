#specify the file to load from your working directory
#download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#set path to directory with rds files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? 
baltinei <- NEI[NEI$fips=="24510",]

# Baltimore data by year
balti.aggbyyear <- aggregate(Emissions ~ year,baltinei, sum)

# use ggplot2
library(ggplot2)

png("plot3.png", width=480, height=480,units="px",bg="transparent")
par(mar=c(5, 5, 4, 2) + 0.1) # adjust margins for labels

# fill by source
p <- ggplot(baltinei,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="Year", y=expression("Total PM"[2.5]*~"emission (Tons)")) + 
    labs(title=expression('Total PM'[2.5]*' emissions, Baltimore City 1999-2008 by source type'))

print(p)

dev.off()
