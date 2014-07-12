
## - loads data into dataframe and formats Date as a date
loaddata<-function(){

        classes<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        dataOut<-read.table("household_power_consumption.txt",sep=";",header=TRUE, colClasses=classes, na.strings="?")
        dataOut$Date<-strptime(dataOut$Date,format="%d/%m/%Y")                 
        dataOut
}

## - fills a vector with dates for analysis and subsets the date with those dates
## - returns a subset of the data
subsetData<-function(dataIn){
        dates<-c(strptime("2007-02-01",format="%Y-%m-%d"),strptime("2007-02-02",format="%Y-%m-%d"))
        dataOut<-dataIn[dataIn$Date %in% dates,]
        dataOut
}



## plot to png
plot1<-function(dataIn){
        png(filename = "plot1.png",
            width = 480, height = 480, units = "px", pointsize = 12,
            bg = "white")
        
        hist(dataIn
             $Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
        
        dev.off()
}




##-----------------------
## ON RUN

## Load and subset the data 
datafile<-subsetData(loaddata())

## plot
plot1(datafile)