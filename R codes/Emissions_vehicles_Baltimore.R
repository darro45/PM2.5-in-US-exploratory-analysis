# As long as each of the files is in your current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Emissions from motor vehicle sources(1999–2008) in Baltimore City
years <- c(1999,2002,2005,2008)
Baltimore <- with(NEI,NEI[fips == "24510",])
joined_Baltimore <- merge(Baltimore, SCC, by.x = "SCC", by.y = "SCC", all.x = FALSE, all.y = TRUE)
sector <- joined_Baltimore$EI.Sector
vehicleEm <- joined_Baltimore[grepl("Vehicles",sector),]
total.Vehicle.Em <- with(vehicleEm,tapply(Emissions, year, sum))
png(file="plot5.png",width=480, height=480)
plot(years, total.Vehicle.Em, xlab = "year",ylab=expression('Total PM'[2.5]*' emission (tons)'),main="Emissions from motor vehicle sources in Baltimore City",pch = 19)
dev.off()
