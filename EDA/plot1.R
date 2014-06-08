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

#plot1 histogram chart
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(subsetDF$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()

