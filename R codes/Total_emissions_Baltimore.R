# As long as each of the files is in your current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Total emissions from PM2.5 in the  Baltimore City, Maryland ("fips" == 24510) from 1999 to 2008
years <- c(1999,2002,2005,2008)
Baltimore <- with(NEI,NEI[fips == "24510",])
baltimorePM <- with(Baltimore,tapply(Emissions, year, sum))
png(file="plot2.png",width=480, height=480)
plot(years,baltimorePM, main = expression('Total PM'[2.5]*' emission from different sources in Baltimore'), ylab=expression('total PM'[2.5]*' emission (tons)'), xlab = "Year", pch = 19)
dev.off()
