### EXPLORATORY DATA ANALYSIS - Course Project 1: Plot 1
## Data Source: UC Irvine Machine Learning Repository  
## Data Set: Individual household electric power consumption

#Before running, set a working directory and copy this file into it. Data files and plots will be created in the working dir

#Please ensure to check plots against the reference ones in the "figures" directory of the github repo
#The reference plots display with a transparent background, not white

## Download file from website into temp file
fileurl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
temp <- tempfile()
download.file(fileurl,temp, method = "curl")

##Unzip temp file and read into data frame 
##(already downloaded the file directly from the website to ascertain that it's suitable to process using read.table)
df <- read.table (unz(temp, "household_power_consumption.txt"),sep=";",header = TRUE)

##Subset the data for the two dates of interest and bind into a working dataframe (wkdf) to use for the plots.
##Note that at this point, the date column is being treated as a charater string
ss1 <- df[,1] == "1/2/2007"
ss2 <- df[,1] == "2/2/2007"
wkdf <- rbind(df[ss1,],df[ss2,])

##Reformat the Date and Time columns to be of the correct type and format
##Create DateTime Character Vector from the Date and Time variables 
dtv <- paste(wkdf[,1],wkdf[,2])
##Convert to Posix time vector
DateTime <- strptime(dtv, format = "%d/%m/%Y %H:%M:%S")

##Bind the Posix Date Time Vector to the working data frame
wkdf <- cbind(DateTime,wkdf)



## Set up PNG file
png("plot2.png", bg = "transparent")

## Construct plot 
## conversion of Global_active_power variable to numeric (needs to convert via character type to maintain values)
gap <- as.numeric(as.character(wkdf$Global_active_power))
## Create and annotate plot
with(wkdf, plot(DateTime,gap, type ="l", xlab = "" , ylab = "Global Active Power (kilowatts)"))
# Close device
dev.off()






