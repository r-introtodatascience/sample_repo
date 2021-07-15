#Merge poverty data with unemployment data

# clean workspace and environment
cat("\014")
rm(list=ls())

### Put in your own folder path here
workingdir<-#"Path_to_your_main_folder"
# for example for me it was workingdir<-"C:/Users/Documents/GitHub/Rcourse/"

#load in folder paths
source(paste0(workingdir, "workingdir.R"))

#load required packages
require(tidyverse)

##############################################################


# First load in and clean unemployment data
load(paste0(folder_processed_data, "/unemp_data.rda"))

# filter to 2019 and drop PR. 
# rename to unem_2019, drop year variable, create FIPStxt
unem_2019<-unemp_data %>% 
  filter(Year==2019, State_fips!=72) %>% #restrict sample to only year 2019, drop PR
  select(-Year) %>% #drop the variable Year
  mutate(FIPStxt=paste0(State_fips, County_fips)) #Create variable to merge on

#load in poverty data
load(paste0(folder_processed_data, "/poverty_data.rda"))

## merge data
unempandpoverty_data<-
  unem_2019 %>% full_join(pov_2019)

## there are 4 different merge styles left_join, right_join, inner_join and full_join
## see details on link.

save(unempandpoverty_data, file=paste0(folder_processed_data, "/unempandpoverty_data.rda"))