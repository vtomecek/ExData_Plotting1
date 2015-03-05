## Plot 2
## Global active power by time

## Read the data
source('read_hpc.R')
if(!exists('hpc'))
    hpc <- read.hpc()

## Plot the lines graph
png("plot2.png", width=480, height=480, bg="transparent")
plot(hpc$DateTime, hpc$Global_active_power, type = 'l',
     xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()
