# As long as each of the files is in your current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Emissions from coal combustion-related between 1999–2008 across United States
years <- c(1999,2002,2005,2008)
joined_df <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC", all.x = FALSE, all.y = TRUE)
coal <- joined_df$EI.Sector; coalEm <- joined_df[grepl("Coal",coal),]
total.Coal.Em <- with(coalEm,tapply(Emissions, year, sum))
png(file="plot4.png",width=480, height=480)
plot(years, total.Coal.Em/1000, xlab = "year", ylab=expression('Total PM'[2.5]*' emission (kilotons)'), main=expression('Coal combustion-related PM'[2.5]*' emission in US'),pch = 19)
dev.off()
