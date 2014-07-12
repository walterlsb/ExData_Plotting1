
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

## combines the Date and Time fields and formats as a DateTime
addDateTime<-function(dataIn){
        dataIn$DT<-strptime(paste(as.character(dataIn$Date),dataIn$Time, sep=" "),format="%Y-%m-%d %H:%M:%S")
        dataIn
}


## plot to png
plot4<-function(dataIn){
        png("plot4.png",width = 480, height = 480, units = "px", pointsize = 12,        bg = "white")
        
        par(mfcol=c(2,2))
        
        ##1
        plot(dataIn$DT,dataIn$Global_active_power,type="l",ylab="Global Active Power",xlab="")
        
        ##2
        with(dataIn,plot(DT, Sub_metering_1, type="n",ylab="Energy sub metering",xlab=""))
        with(dataIn, points(DT, Sub_metering_1, col="black",type="l"))
        with(dataIn, points(DT, Sub_metering_2, col="red",type="l"))
        with(dataIn, points(DT, Sub_metering_3, col="blue",type="l"))
        legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        #3
        with(dataIn,plot(DT,Voltage,type="l",xlab="datetime"))

        #4
        with(dataIn,plot(DT,Global_reactive_power,type="l",xlab="datetime"))
        
        dev.off()
}


##-----------------------
## ON RUN
## Load and subset the data
datafile<-subsetData(loaddata())

## add the DateTime column and plot
plot4(addDateTime(datafile))