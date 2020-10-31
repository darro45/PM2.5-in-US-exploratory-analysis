# As long as each of the files is in your current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Total emissions from PM2.5 in the United States from 1999 to 2008
totalPM <- with(NEI,tapply(Emissions, year, sum))
totalPM <- totalPM/1000
years <- c(1999,2002,2005,2008)

png(file="plot1.png",width=480, height=480)
plot(years,totalPM, main = expression('Total PM'[2.5]*' emission from different sources'), ylab=expression('total PM'[2.5]*' emission (kilotons)'), xlab = "Year", pch = 19)
dev.off()
