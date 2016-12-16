file <- "household_power_consumption.txt"
#read the first record of the data
a <- read.table(file, header=TRUE,nrows=1,sep=';')
#convert the first record date and time to posix
thisDate = as.POSIXct(paste(a$Date, a$Time), format="%d/%m/%Y %H:%M:%S", tz='EST')
#convert our desired start date time into posix
targetDay1 = as.POSIXct('02/01/2007 00:00:00', format('%m/%d/%Y %H:%M:%S'), tz='EST')
#each record is one minute apart. Figure out how many records to skip to get to the deisred date.
skip <- abs(as.integer(difftime(thisDate, targetDay1, units='mins')))
rows2get <- 60*24*2 #60 minutes * 24 hours * 2 days
b <- read.table(file, header=TRUE,sep=';', skip=skip,nrows=rows2get)
#copy the field names to our desired data
names(b) <- names(a)
#create the png file
png(file='plot4.png',width=480,height=480)

#set up the multi plot area
par(mfrow=c(2,2),mar=c(5,4,2,1))

#First Plot - plot2
with(b, plot(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Global_active_power, xlab='', ylab='Global Active Power', type='n', pch=3))
#add the line
with(b, lines(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Global_active_power))

#Second Plot - Voltge
with(b, plot(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Voltage, xlab='datetime', ylab='Voltage', type='n', pch=3))
#add the line
with(b, lines(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Voltage))

#Third plot - plot3
with(b, plot(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Sub_metering_1, xlab='', ylab='Energy sub metering', type='n', pch=3))
#add the lines
with(b, lines(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Sub_metering_1, col='black'))
with(b, lines(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Sub_metering_2, col='red'))
with(b, lines(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Sub_metering_3, col='blue'))
#Add the legend9
with(b, legend("topright",col=c('black','red','blue'),lwd=2, bty='n', legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3')))

#Fourth plot
with(b, plot(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Global_reactive_power, xlab='datetime', ylab='Global_reactive_power', type='n', pch=3))
#add the line
with(b, lines(as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S", tz='EST'),Global_reactive_power))

#close the device
dev.off()
