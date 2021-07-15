#Provide examples of ggplot utilizing unemployment and poverty data

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

#load in unemployment data
load(paste0(folder_processed_data, "/unemp_data.rda"))

#filter to just indiana
indiana <- unemp_data %>% filter(State_fips=="18")

#create just monroe cty df
monroecty<-indiana %>% filter(County_fips=="105")


#make plot highlighting monroe county in black. suppress key. 
ggplot(data=indiana, aes(x=Year, y=Unemp_rate, colour=County_fips, group=County_fips)) +
  geom_line(size=0.3, alpha=0.5) +
  geom_line(data=monroecty, aes(x=Year, y=Unemp_rate, colour=County_fips, group=1),
    size=0.6, colour='black') +
  theme(legend.position="none", axis.text.x=element_text(angle=45)) +
  ylab('Indiana Unemployment Rate by County')

ggsave(file=paste0(folder_figures, "/indiana_unemp.png"), height = 5, width = 7)


#state aves

## TO DO

unemp_data <- unemp_data %>%
  mutate(state_abbr=substr(County_name, str_length(County_name)-1, str_length(County_name)))

unemp_data$state_abbr[unemp_data$State_fips=='11']<-"DC"

state_ave<-unemp_data %>% group_by(state_abbr, Year) %>% summarise(ave_unemp=mean(Unemp_rate))

ggplot(data=state_ave)+
  geom_line(aes(x=Year, y=ave_unemp, colour=state_abbr, group=state_abbr))


## Dispersion in State aves

disp<-state_ave %>% group_by(Year) %>% 
  summarise(perc90m10=quantile(ave_unemp, c(0.9), na.rm = TRUE)-quantile(ave_unemp, c(0.1), na.rm = TRUE), 
            stddev=sd(ave_unemp, na.rm = TRUE),maxmin=max(ave_unemp, na.rm = TRUE)-min(ave_unemp, na.rm=TRUE))

ggplot(data=disp)+
  geom_line(aes(x=Year, y=perc90m10, group=1))

ggplot(data=disp)+
  geom_line(aes(x=Year, y=stddev, group=1))

ggplot(data=disp)+
  geom_line(aes(x=Year, y=maxmin, group=1))


disp_long<-gather(disp, disp_measure, value, perc90m10:maxmin, factor_key = TRUE)

ggplot(data=disp_long)+
  geom_line(aes(x=Year, y=value, colour=disp_measure, group=disp_measure))