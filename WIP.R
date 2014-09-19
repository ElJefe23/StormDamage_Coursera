setwd("~/GitHub/RepData_PeerAssessment2")
require(plyr)
## There will be some require statements once I figure out what we need.
stormData<-read.table("repdata_data_StormData.csv.bz2", header=TRUE, sep=",")
workData<-stormData[,c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "CROPDMG")]
## To summarize the data by event
byEvent<-ddply(workData,.(EVTYPE), summarize, totFatal=sum(FATALITIES), totInj=sum(INJURIES), totProp=sum(PROPDMG), totCrop=sum(CROPDMG))
## Now we parse/order the data to create the graphs.
byFatal<-byEvent[order(byEvent$totFatal, decreasing=TRUE),c("EVTYPE","totFatal")]
byFatal10<-byFatal[c(1:10),]
## This is really close, but we need to make the plot area shorter (or the font smaller).
par(mar=c(5,11,4,2))
barplot(byFatal10$totFatal,names.arg=byFatal10$EVTYPE,horiz=TRUE,las=1,col=c(1:5),main="Fatalities by Event Type", xlab="Fatalities")
byInjury<-byEvent[order(byEvent$totInj,decreasing=TRUE),c("EVTYPE","totInj")]
byInjury10<-byInjury[c(1:10),]
barplot(byInjury10$totInj,names.arg=byInjury10$EVTYPE,horiz=TRUE,las=1,col=c(6:10),main="Injuries by Event Type", xlab="Injuries")


## The crop and property damage plots will go together, possibly with a total plot as well.
byProp<-byEvent[order(byEvent$totProp,decreasing=TRUE),c("EVTYPE","totProp")]
byProp10<-byProp[c(1:10),]
barplot(byProp10$totProp,names.arg=byProp10$EVTYPE,horiz=TRUE,las=1,col=c(3:7),main="Property Damage by Event Type", xlab="Property Damage")
byCrop<-byEvent[order(byEvent$totCrop,decreasing=TRUE),c("EVTYPE","totCrop")]
byCrop10<-byCrop[c(1:10),]
barplot(byCrop10$totCrop,names.arg=byCrop10$EVTYPE,horiz=TRUE,las=1,col=c(3:7),main="Crop Damage by Event Type", xlab="Crop Damage")

## All that remains is to sort out how to put multiple plots in a single figure and to write
## some blather for the expected audience.
dmgByEvent<-ddply(byEvent,.(EVTYPE), summarize, totDamage=(totProp + totCrop))
byDmg<-dmgByEvent[order(dmgByEvent$totDamage, decreasing=TRUE),]
byDmg10<-byDmg[c(1:10),]
par(mar=c(5,11,4,2))
barplot(byDmg10$totDamage,names.arg=byDmg10$EVTYPE,horiz=TRUE,las=1,col=c(9:13),main="Total Damage by Event Type", xlab="Total Damage")

  