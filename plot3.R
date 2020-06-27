powerdata<- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?",sep = ";", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
powerdata2<- subset(powerdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
finaldata<- powerdata2[complete.cases(powerdata2),]
## Combine Date and Time column
dateTime <- paste(finaldata$Date, finaldata$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateandTime")

## Remove Date and Time column
Drop<-c("Date","Time")
finaldata <- finaldata[ ,!(names(finaldata) %in% Drop)]

## Add DateTime column
finaldata <- cbind(dateTime, finaldata)

## Format dateTime Column
finaldata$dateTime <- as.POSIXct(dateTime)
#Plot3
png("plot3.png", width=480, height=480)
plot(finaldata$Sub_metering_1~finaldata$dateTime, type="l", xlab="",ylab="Energy sub metering")
lines(finaldata$Sub_metering_2~finaldata$dateTime,col='Red')
lines(finaldata$Sub_metering_3~finaldata$dateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()