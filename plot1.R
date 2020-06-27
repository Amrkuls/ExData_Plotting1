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

#Plot1
png("plot1.png", width=480, height=480)
hist(finaldata$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()