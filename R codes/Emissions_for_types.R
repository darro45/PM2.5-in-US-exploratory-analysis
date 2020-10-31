# As long as each of the files is in your current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by (point, nonpoint, onroad, nonroad) variable, which 
#of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City

library(ggplot2)
Baltimore <- with(NEI,NEI[fips == "24510",])
png(file="plot3.png",width=780, height=480)
qplot(year, log(Emissions), data = Baltimore, facets = .~type, shape = type, ylab = expression('Log normalized PM'[2.5]*' emission')) + geom_smooth(method ="lm") 
dev.off()
