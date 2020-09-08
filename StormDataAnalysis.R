file_name <- "stormData.csv.bz2"
if(!file.exists(file_name))
{
  download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", file_name, method = "curl")
}

doc_name <- "stormDataDocumentation.pdf"
if(!file.exists(doc_name))
{
  download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf", doc_name, method = "curl")
}

stormData <- read.csv(file_name)
str(stormData)
colnames(stormData)

library(dplyr)
library(ggplot2)

totFatalities <- aggregate(stormData$FATALITIES, by = list(stormData$EVTYPE), "sum")
names(totFatalities) <- c("Event", "Fatalities")
totFatalitiesSorted <- totFatalities[order(-totFatalities$Fatalities), ][1:10, ]
totFatalitiesSorted

totInjuries <- aggregate(stormData$INJURIES, by = list(stormData$EVTYPE), "sum")
names(totInjuries) <- c("Event", "Injuries")
totInjuriesSorted <- totInjuries[order(-totInjuries$Injuries), ][1:10, ]
totInjuriesSorted

par(mfrow = c(1,2), mar = c(4,4,2,4), las = 3, cex = 0.7, cex.main = 1.4, cex.lab = 1.2)
barplot(totFatalitiesSorted$Fatalities, names.arg = totFatalitiesSorted$Event, col = 'blue', main = 'Top 20 Weather Events for Fatalities', ylab = 'Number of Fatalities')
barplot(totInjuriesSorted$Injuries, names.arg = totInjuriesSorted$Event, col = 'light blue', main = 'Top 20 Weather Events for Injuries', ylab = 'Number of Injuries')

totProperty <- aggregate(stormData$PROPDMG, by = list(stormData$EVTYPE), "sum")
names(totProperty) <- c("Event", "Property")
totPropertySorted <- totProperty[order(-totProperty$Property), ][1:20, ]
totPropertySorted


totCrop <- aggregate(stormData$CROPDMG, by = list(stormData$EVTYPE), "sum")
names(totCrop) <- c("Event", "Crop")
totCropSorted <- totCrop[order(-totCrop$Crop), ][1:20, ]
totCropSorted


par(mfrow = c(1, 2), mar = c(10, 4, 2, 2), las = 3, cex = 0.7, cex.main = 1.4, cex.lab = 1.2)
barplot(totPropertySorted$Property, names.arg = totPropertySorted$Event, col = 'Brown', main = 'Top 20 Weather Events for Property Damage ', ylab = 'Amount of Property Damage', ylim = c(0, 3500000))
barplot(totCropSorted$Crop, names.arg = totCropSorted$Event, col = 'Green', main = 'Top 20 Weather Events for Crop Damage', ylab = 'Amount of  Crop Damage', ylim = c(0, 3500000))


totTotalCost <- aggregate(noaaDF$CROPDMG+noaaDF$PROPDMG, by = list(noaaDF$EVTYPE), "sum")
names(totTotalCost) <- c("Event", "TotalCost")
totTotalCostSorted <- totTotalCost[order(-totTotalCost$TotalCost), ][1:20, ]
totTotalCostSorted


par(mfrow = c(1,1), mar = c(10, 4, 2, 2), las = 3, cex = 0.7, cex.main = 1.4, cex.lab = 1.2)
barplot(totTotalCostSorted$TotalCost, names.arg = totTotalCostSorted$Event, col = 'Black', main = 'Top 20 Weather Events for total Damage ', ylab = 'Amount of total Damage', ylim = c(0, 3500000))
