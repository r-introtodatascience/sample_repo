#Create summary stats table and print to tex table

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
require(xtable)

##############################################################


#load in unemployment data
load(paste0(folder_processed_data, "/unemp_data.rda"))

indiana_laborforce<-unemp_data %>% 
  filter(State_fips=="18") %>% 
  group_by(Year) %>% 
  summarise(`Min`=min(Labor_force),
    `10th`=quantile(Labor_force, c(0.1)),
    `25th`=quantile(Labor_force, c(0.25)),
    `50th`=quantile(Labor_force, c(0.5)),
    `75th`=quantile(Labor_force, c(0.75)),
    `90th`=quantile(Labor_force, c(0.9)),
    `Max`=max(Labor_force),
    `Average`=mean(Labor_force),
    `St. Dev`=sd(Labor_force))

print.xtable(xtable(indiana_laborforce, type ="latex",
            digits=0, label= "tab:indiana_laborforce",
            align = c("|c|", "|c|", "c", "c", "c", "c", "c", "c", "c", "c", "c|")), 
            table.placement="H",
            file=paste0(folder_tables, "/indiana_laborforce.tex"), include.rownames=FALSE)


