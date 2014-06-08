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

#plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(subsetDF$DateTime, subsetDF$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subsetDF$DateTime, subsetDF$Sub_metering_2, type="l", col="red")
lines(subsetDF$DateTime, subsetDF$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=cols)
dev.off()

