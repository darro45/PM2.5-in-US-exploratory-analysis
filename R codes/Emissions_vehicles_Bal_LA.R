# As long as each of the files is in your current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County
years <- c(1999,2002,2005,2008)

#Baltimore data
Baltimore <- with(NEI,NEI[fips == "24510",])
joined_Baltimore <- merge(Baltimore, SCC, by.x = "SCC", by.y = "SCC", all.x = FALSE, all.y = TRUE)
vehicleBaltimore <- joined_Baltimore$EI.Sector
vehicleEm.Baltimore <- joined_Baltimore[grepl("Vehicles",vehicleBaltimore),]
total.Vehicle.Em.Bal <- with(vehicleEm.Baltimore,tapply(Emissions, year, sum))

#Los Angeles data
Los.Angeles <- with(NEI,NEI[fips == "06037",])
joined_Los.Angeles <- merge(Los.Angeles, SCC, by.x = "SCC", by.y = "SCC", all.x = FALSE, all.y = TRUE)
vehicleLosAngeles <- joined_Los.Angeles$EI.Sector
vehicleEm.Los.Angeles <- joined_Los.Angeles[grepl("Vehicles",vehicleLosAngeles),]
total.Vehicle.Em.LA <- with(vehicleEm.Los.Angeles,tapply(Emissions, year, sum))

#Merge data
Baltimore_df <- as.data.frame(total.Vehicle.Em.Bal, row.names = NULL); 
Baltimore_df <- setNames(Baltimore_df, c("PM2.5"))
Baltimore_df$County <- "Baltimore, MD"; Baltimore_df$year <- years
LA_df <- as.data.frame(total.Vehicle.Em.LA, row.names = NULL)
LA_df <- setNames(LA_df, c("PM2.5"))
LA_df$County <- "Los Angeles, CA"; LA_df$year <- years

final_df <- rbind(Baltimore_df,LA_df)



#Plot using ggplot2 library
library(ggplot2)
png(file="plot6.png",width=680, height=480)
qplot(year, PM2.5, data = final_df, facets = County ~., col = County) + geom_smooth(method ="lm")  +
  ylab(expression("total PM"[2.5]*" emissions (tons)")) +
  ggtitle(expression("Motor vehicle emission variation (1999-2008)")) + facet_grid(County~., scales="free")

dev.off()
