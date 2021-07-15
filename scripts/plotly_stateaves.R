#Interactive plots of state unempl averages over time.

# clean workspace and environment
cat("\014")
rm(list=ls())

### Put in your own folder path here
workingdir<-#"Path_to_your_main_folder"
# for example for me it was workingdir<-"C:/Users/Documents/GitHub/Rcourse/"

#load in folder paths
source(paste0(workingdir, "workingdir.R"))

#load required packages
require(stringr)
require(dplyr)
require(ggplot2)
require(tidyr)
require(plotly)

##############################################################

#load in unemployment data
load(paste0(folder_processed_data, "/unemp_data.rda"))


county_data$state_abbr<-substr(county_data$County_name, str_length(county_data$County_name)-1, str_length(county_data$County_name))

county_data$state_abbr[county_data$State_fips=='11']<-"DC"
checkdup<-county_data %>% group_by(State_fips, state_abbr) %>% summarize(ave=mean(Unemp_rate))

state_ave<-county_data %>% group_by(state_abbr, Year) %>% summarise(ave_unemp=sum(Unemployed)/sum(Labor_force))

pal<-rainbow(52)

state_ave %>%
  plot_ly(
    x = ~Year,
    y = ~ave_unemp,
    color = ~state_abbr,
    text = ~state_abbr,
    hoverinfo = "text",
    type = 'scatter',
    mode = 'lines',
    colors = ~pal,
    line =list(width=1)
  )
