#specify the file to load from your working directory
#download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#set path to directory with rds files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

s.v.scc <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE), ]$SCC
s.v.nei <- NEI[NEI$SCC %in% s.v.scc, ]

# Subset data with Baltimore fips and on-road
v.balti <- s.v.nei[s.v.nei$fips=="24510",]

# use ggplot2
library(ggplot2)

png("plot5.png", width=480, height=480,units="px",bg="transparent")
par(mar=c(5, 5, 4, 2) + 0.1) # adjust margins for labels

# fill by source
p <- ggplot(v.balti,aes(factor(year),Emissions/10^2)) +
    geom_bar(stat="identity",fill="red",width=0.8) +
    theme_bw() + 
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*~"emission("~10^{2}~"Tons)")) + 
    ggtitle(bquote(atop("Total PM"[2.5]*~"emission,", 
                        "Baltimore City from 1999-2008 by Motor Vehicle source")))

print(p)

dev.off()
