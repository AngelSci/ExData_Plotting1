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
png(file='plot1.png',width=480,height=480)
#now to plot
with(b, hist(Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)'))
#close the device
dev.off()