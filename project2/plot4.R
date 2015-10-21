#specify the file to load from your working directory
#download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#set path to directory with rds files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Subset data with Short.Name (SCC) Coal
s.scc <- SCC[grepl("Coal",SCC$Short.Name), ]
s.nei <- NEI[NEI$SCC %in% s.scc$SCC, ]

# use ggplot2
library(ggplot2)

png("plot4.png", width=480, height=480,units="px",bg="transparent")
par(mar=c(5, 5, 4, 2) + 0.1) # adjust margins for labels

# fill by source
p <- ggplot(s.nei,aes(factor(year),Emissions/10^5)) +
    geom_bar(stat="identity",fill="red",width=0.8) +
    theme_bw() + 
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*~"emission("~10^{5}~"Tons)")) + 
    ggtitle(bquote(atop("Total PM"[2.5]*~"emission,", 
                        "From Coal Combustion across US from 1999-2008")))
print(p)

dev.off()
