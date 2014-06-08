setwd("C:/Anthony_Wynn/Docs/R/R_Lang/hopkins/exploratoryDataAnalysis/coursePrj1")
getwd()

#### Step - 1 : Download, Extract and Unzip file to working dir. #####
url= ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
#create tmp_dir for later unzip
temp_dir=tempdir()
# create the temp zip file_holder + its path with temp_dir 
(file_holder=tempfile(tmpdir=temp_dir, fileext=".zip")  )
#download file to temp placeholder for unzip
(download.file(url, file_holder)  )
# unzip file to current working dir 
unzip(file_holder, files=NULL, exdir=getwd(), overwrite=TRUE)
?read.table
colnAttribute = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
dataDF = read.table("household_power_consumption.txt", header=T, sep=';', na.strings="?",colClasses=colnAttribute)
str(dataDF)
#subset only the data you need for 2 days
subsetDF = dataDF[(dataDF$Date == "1/2/2007") | (dataDF$Date == "2/2/2007"),] 
head(subsetDF)

#build dataDF$DateTime coln for timeSeries
subsetDF$DateTime <- strptime(paste(subsetDF$Date, subsetDF$Time), "%d/%m/%Y %H:%M:%S")
write.csv(subsetDF, "household_power_consumption.csv")

#plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
# put graph in 2 rows x 2 coln with margin ? oma?
par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
?within()
?with()
result <-within(subsetDF, {
  plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="l")
  plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="l")    
  cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=cols, bty="n")  
  plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")        
})    
str(result)
summary(result)
dev.off()