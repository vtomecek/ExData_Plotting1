## Plot 1
## histogram of Global active power

## Read the data
source('read_hpc.R')
if(!exists('hpc'))
    hpc <- read.hpc()

## Plot the histogram
png("plot1.png", width=480, height=480, bg="transparent")
hist(hpc$Global_active_power,
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency',
     main = 'Global active power',
     col='red')
dev.off()
