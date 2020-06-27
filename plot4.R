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
#Plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
f<-finaldata
plot(f$Global_active_power~f$dateTime, type="l",  ylab="Global Active Power (kilowatts)", xlab="")
plot(f$Voltage~f$dateTime, type="l",  ylab="Voltage (volt)", xlab="dateTime")
plot(f$Sub_metering_1~f$dateTime, type="l", xlab="",ylab="Energy sub metering")
lines(f$Sub_metering_2~f$dateTime,col='Red')
lines(f$Sub_metering_3~f$dateTime,col='Blue')
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
plot(f$Global_reactive_power~f$dateTime, type="l",  ylab="Global Reactive Power (kilowatts)",xlab="dateTime")
dev.off()