## Function read.hpc downloads and unzips the source file (if not done yet)
## + loads the file into `hpc` variable
## + converts the Date and Time variables into `hpc$DateTime`

## The script takes advantage of sorted file and finds the row-range 
## corresponding to 1/2/2007 - 2/2/2007 first (using linux-commands)
## then reads only rows within that range (optimalization for speed and memory)
## Also takes advantage of 1 min gap and generates the timestamps instead of parsing them

read.hpc <- function(date_from = '1/2/2007', date_to = '3/2/2007', days = 2) {
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    zip_name <- 'exdata-data-household_power_consumption.zip'
    txt_name <- 'household_power_consumption.txt'
    
    ## Download and unzip the archive if not done yet
    if (!file.exists(txt_name)) {
        if (!file.exists(zip_name)) {
            #stop(paste('File', zip_name, 'not found in wd.'))
            message('Downloading the archive...')
            download.file(url, zip_name, 'wget')
            sz <- file.info(zip_name)[["size"]]
            if (is.na(sz) || sz<1000000) {
                stop('Failed to download the archive.')
            }
        }
        message('Unzipping the archive...')
        unzip(zip_name)
    }
    
    ## Read the CSV
    # find row-range first and then read only rows within that range
    # this is faster than reading all the file and then subsetting
    com1 <- paste0('grep -n -m 1 "^', date_from, '" ', txt_name, ' | cut -f 1 -d \\:')
    com2 <- paste0('grep -n -m 1 "^', date_to, '" ', txt_name, ' | cut -f 1 -d \\:')
    row1 <- as.integer(system(com1, TRUE))
    row2 <- as.integer(system(com2, TRUE))
    skip <- row1 -2
    nrows <- row2 -row1

    message('Reading the CSV file...')
    message(com1)
    hpc <- read.csv(txt_name, stringsAsFactors=F, sep=';', na.string='?', 
                    header=T, skip=skip, nrows=nrows,
                    colClasses = c('character', 'character', rep('numeric',7)) )
    # add header
    header <- read.csv(txt_name, stringsAsFactors=F, sep=';', nrows=1, header=F)
    colnames(hpc) <- unlist(header)
    
    message('Converting the DateTime...')
    #hpc$DateTime <- strptime( paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S' )
    # we can take advantage of 1min gap and generate the sequence
    # instead of strptime every single row
    dt <- strptime( paste(hpc$Date[1], hpc$Time[1]), '%d/%m/%Y %H:%M:%S' )
    hpc$DateTime <- seq(from=dt, by=60, length.out=days*1440)
    
    hpc
}
