#Clean poverty data downloaded from usda: 
#https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/
#And merge with unemployment
#------------------------------------------------------------#

# Clean workspace and console.
cat("\014")
rm(list=ls())

#Load req packages
require(tidyverse)
require(readxl)

#setwd("C:/Users/weste/Documents/GitHub/retail_electricity/bld")
source('project_paths.R')
#------------------------------------------------------------#

## Now read in poverty data
PovertyEstimates <- 
  read_excel(paste0(folder_raw_data, "/PovertyEstimates.xls"), skip = 4)

## rid us of us level and state level observations
pov_2019 <- PovertyEstimates %>% 
  filter(substr(FIPStxt, str_length(FIPStxt)-2, str_length(FIPStxt))!="000")

save(pov_2019, file=paste0(PATH_OUT_DATA, "/poverty_data.rda"))

# First load in and clean unemployment data
load(paste0(PATH_OUT_DATA, "/unemp_data.rda"))

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

save(unempandpoverty_data, file=paste0(PATH_OUT_DATA, "/unempandpoverty_data.rda"))