plot3<-function(){
  ###########################
  ##
  ##  Exploratory Data Analysis project
  ##
  ##
  ###########################
  
  library(ggplot2)
  library(dplyr)
  library(lubridate)
  
  ## read data
  dat<-read.table("C:/Users/andrewll/Documents/R/expldata/exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep=";", na.strings = "NA", stringsAsFactors = FALSE)
  
  #convert to tbl_df
  dat2<-tbl_df(dat)
  
  ##convert to Date variable to date format
  ##dat2$Date<-as.Date(dat2$Date, format = "%m/%d/%Y")
  dat2$Date<-dmy(dat2$Date)
  
  ##subset to desired dates
  dat3<-dat2[which(dat2$Date>'2007-01-31'),]
  dat4<-dat3[which(dat3$Date<'2007-02-02'),]
  
  ##convert number variables to numeric value
  dat4$Global_active_power<-as.numeric(dat4$Global_active_power)
  dat4$Global_reactive_power<-as.numeric(dat4$Global_reactive_power)
  dat4$Voltage<-as.numeric(dat4$Voltage)
  dat4$Global_intensity<-as.numeric(dat4$Global_intensity)
  dat4$Sub_metering_1<-as.numeric(dat4$Sub_metering_1)
  dat4$Sub_metering_2<-as.numeric(dat4$Sub_metering_2)
  dat4$Sub_metering_3<-as.numeric(dat4$Sub_metering_3)
  
  ##create weekday variable, and convert hours_minutes_second to posix format
  dat5<-mutate(dat4, weekday = format(Date, "%a"), hrsminsec = hms(Time))
  
  ##create date plus time variable
  dat6<-mutate(dat5, date_time = Date+hrsminsec)
  

  ##plot3
  png("C:/Users/andrewll/Documents/R/expldata/ExData_Plotting1/plot3.png", width = 480, height = 480, units = "px")
  with(dat6, plot(date_time, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = ""))
  with(subset(dat6), points(date_time, Sub_metering_2, type = "l", col = "red"))
  with(subset(dat6), points(date_time, Sub_metering_3, type = "l", col = "blue"))
  legend("topright", pch = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  dev.off()
  
}
