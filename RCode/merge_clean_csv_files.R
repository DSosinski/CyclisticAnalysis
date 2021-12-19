#install.packages("tidyverse")

library(tidyverse)
library(skimr)
library(janitor)

require(data.table)

#To clear your environment
rm(list = ls(all.names = TRUE))

#Setting up project data folder
project_folder <- "C:/Users/Dawid/Desktop/Projekty/R/GDA Capstone/Code/Data"
setwd(project_folder)

#Getting file list from  data folder
file_list <- list.files(path=project_folder)
#file_list <- c('Divvy_Trips_2015_07.csv','Divvy_Trips_2018_Q1.csv','Divvy_Trips_2013.csv')

#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable
dataset <- data.frame()

#had to specify columns to get rid of the total column
for (i in 1:length(file_list) ){
  
  print(file_list[i])
  
  #read in files using the fread function from the data.table package
  temp_data <- fread(file_list[i], stringsAsFactors = F)
  

  temp_data$file_name <- file_list[i]
  
  names(temp_data)[names(temp_data) == 'birthyear'] <- 'birthday'
  names(temp_data)[names(temp_data) == 'start_time'] <- 'starttime'
  names(temp_data)[names(temp_data) == 'end_time'] <- 'stoptime'
  
  names(temp_data)[names(temp_data) == '01 - Rental Details Rental ID'] <- 'trip_id'
  names(temp_data)[names(temp_data) == '01 - Rental Details Local Start Time'] <- 'starttime'
  names(temp_data)[names(temp_data) == '01 - Rental Details Local End Time'] <- 'stoptime'
  names(temp_data)[names(temp_data) == '01 - Rental Details Bike ID'] <- 'bikeid'
  names(temp_data)[names(temp_data) == '01 - Rental Details Duration In Seconds Uncapped'] <- 'tripduration'
  names(temp_data)[names(temp_data) == '03 - Rental Start Station ID'] <- 'from_station_id'
  names(temp_data)[names(temp_data) == '03 - Rental Start Station Name'] <- 'from_station_name'
  names(temp_data)[names(temp_data) == '02 - Rental End Station ID'] <- 'to_station_id'
  names(temp_data)[names(temp_data) == '02 - Rental End Station Name'] <- 'to_station_name'
  names(temp_data)[names(temp_data) == 'User Type'] <- 'usertype'
  names(temp_data)[names(temp_data) == 'Member Gender'] <- 'gender'
  names(temp_data)[names(temp_data) == '05 - Member Details Member Birthday Year'] <- 'birthday'


  if (file_list[i] == 'Divvy_Trips_2018_Q1.csv' ) {
    
    temp_data[['starttime']] <- 
      strftime(  
        strptime(temp_data[['starttime']] ,format="%Y-%m-%d %H:%M:%S"),
        format = "%Y-%m-%d %H:%M:%S"
      )
    
    temp_data[['stoptime']] <- 
      strftime(  
        strptime(temp_data[['stoptime']] ,format='%Y-%m-%d %H:%M:%S'),
        format = "%Y-%m-%d %H:%M:%S"
      )

  }
  else  if (file_list[i] == 'Divvy_Trips_2013.csv' ) {
      
    temp_data[['starttime']] <- 
      strftime(  
        strptime(temp_data[['starttime']] ,format='%Y-%m-%d %H:%M'),
        format = "%Y-%m-%d %H:%M:%S"
      )
    
    temp_data[['stoptime']] <- 
      strftime(  
        strptime(temp_data[['stoptime']] ,format='%Y-%m-%d %H:%M'),
        format = "%Y-%m-%d %H:%M:%S"
      )
    
  }
  else  {

    temp_data[['starttime']] <- 
      strftime(  
        strptime(temp_data[['starttime']] ,format='%m/%d/%Y %H:%M'),
        format = "%Y-%m-%d %H:%M:%S"
      )
    
    temp_data[['stoptime']] <- 
      strftime(  
        strptime(temp_data[['stoptime']] ,format='%m/%d/%Y %H:%M'),
        format = "%Y-%m-%d %H:%M:%S"
      )
  }
  
  dataset <- rbindlist(list(dataset, temp_data), use.names = T) 
  
  #View(dataset)
  write.csv(dataset,"C:/Users/Dawid/Desktop/Projekty/R/GDA Capstone/Code/Data/ful_data.csv", row.names = FALSE)


}
