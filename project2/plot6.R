#specify the file to load from your working directory
#download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#set path to directory with rds files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

s.v.scc <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE), ]$SCC
s.v.nei <- NEI[NEI$SCC %in% s.v.scc, ]

# Subset data with Baltimore fips and on-road
v.balti.la <- s.v.nei[s.v.nei$fips=="24510" | s.v.nei$fips=="06037",]

# name city
v.balti.la[which(v.balti.la$fips=="24510"),]$fips <- "Baltimore City"
v.balti.la[which(v.balti.la$fips=="06037"),]$fips <- "Los Angeles County"

# use ggplot2
library(ggplot2)

png("plot6.png", width=480, height=480,units="px",bg="transparent")
par(mar=c(5, 5, 4, 2) + 0.1) # adjust margins for labels

# fill by source
p <- ggplot(v.balti.la,aes(factor(year),Emissions/10^3)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(.~fips,scales="free", space="free" ) +
    theme_bw() + 
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*~"emission("~10^{3}~"Tons)")) + 
    ggtitle(bquote(atop("Total PM"[2.5]*~"emission from 1999-2008,", 
                        "From Motor vehicle in Baltimore City vs Los Angeles County")))
print(p)

dev.off()
