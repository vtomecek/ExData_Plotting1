## Plot 3
## submeterings by time

## Read the data
source('read_hpc.R')
if(!exists('hpc'))
    hpc <- read.hpc()

## Plot the lines graph
png("plot3.png", width=480, height=480, bg="transparent")
plot(hpc$DateTime, hpc$Sub_metering_1, type = 'l', col = 'black',
     xlab = '', ylab = 'Energy sub metering')
lines(hpc$DateTime, hpc$Sub_metering_2, col = 'red')
lines(hpc$DateTime, hpc$Sub_metering_3, col = 'blue')
legend("topright",
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c('black','red','blue'), lwd = 1)
dev.off()
