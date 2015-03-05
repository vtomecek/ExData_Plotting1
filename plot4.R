## Plot 4
## Global active power by time
## submeterings by time
## Voltage by time
## Global reactive power by time

## Read the data
source('read_hpc.R')
if(!exists('hpc'))
    hpc <- read.hpc()

## Plot the graphs
png("plot4.png", width=480, height=480, bg="transparent")
par(mfrow=c(2,2))

# 1
plot(hpc$DateTime, hpc$Global_active_power, type = 'l',
     xlab = '', ylab = 'Global Active Power (kilowatts)')

# 2
with(hpc, 
     plot(DateTime, Voltage, type = 'l')
)

# 3
plot(hpc$DateTime, hpc$Sub_metering_1, type = 'l', col = 'black',
     xlab = '', ylab = 'Energy sub metering')
lines(hpc$DateTime, hpc$Sub_metering_2, col = 'red')
lines(hpc$DateTime, hpc$Sub_metering_3, col = 'blue')
legend("topright", bty="n",
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c('black','red','blue'), lwd = 1)

# 4
with(hpc, 
     plot(DateTime, Global_reactive_power, type = 'l')
)

dev.off()
