#install.packages("tidyverse")

library(tidyverse)
library(skimr)
library(janitor)

require(data.table)

##Setting up project data folder
project_folder <- "C:/Users/Dawid/Desktop/Projekty/R/GDA Capstone/Code/Data"
setwd(project_folder)

#Getting file list from  data folder
file_list <- list.files(path=project_folder)


#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable
dataset <- data.frame()

#had to specify columns to get rid of the total column
for (i in 1:length(file_list)){
  
  print(file_list[i])
  
  #read in files using the fread function from the data.table package
  temp_data <- fread(file_list[i], stringsAsFactors = F)
  
  names(temp_data)[names(temp_data) == 'birthyear'] <- 'birthday'
  
  #for each iteration, bind the new data to the building dataset
  dataset <- rbindlist(list(dataset, temp_data), use.names = T) 

}
