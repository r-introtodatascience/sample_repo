### Map county data

# clean workspace and environment
cat("\014")
rm(list=ls())

### Put in your own folder path here
workingdir<-#"Path_to_your_main_folder"
# for example for me it was workingdir<-"C:/Users/Documents/GitHub/Rcourse/"

#load in folder paths
source(paste0(workingdir, "workingdir.R"))

#load required packages
require(widgetframe)
require(tigris)
require(leaflet)

##############################################################

#download shapefile for wisconsin
wisccounty<-counties(state="WI", cb=TRUE)

#load in unemployment data
load(paste0(folder_processed_data, "/unemp_data.rda"))

wiscodata<-county_data %>% filter(State_fips=="55" & (Year==1990 | Year==2019))
wiscodata$GEOID<-paste0(wiscodata$State_fips, wiscodata$County_fips)
wiscodata_lf<-wiscodata %>% select(Year, GEOID, Labor_force)
wide_wiscodata_lf<-wiscodata_lf %>% spread(Year, Labor_force)
colnames(wide_wiscodata_lf)[2:3]<-paste0("LaborForce_", colnames(wide_wiscodata_lf)[2:3])

wide_wiscodata_lf<-wide_wiscodata_lf %>% 
  mutate(percchange=round(((LaborForce_2019 - LaborForce_1990)/LaborForce_1990),4)*100)

wisccounty@data<-wisccounty@data %>% left_join(wide_wiscodata_lf)

centerLNG<--90
centerLAT<-44.8
mypopup <- paste0("County: ", wisccounty$NAME,
                  " <br> ", 
                  "1990 Labor Force: ", wisccounty$LaborForce_1990,
                  " <br> ", 
                  "2019 Unemployment: ", wisccounty$LaborForce_2019,
                  " <br> ", 
                  "Percent Change: ", wisccounty$percchange, "%")




my_pal <- colorNumeric(
  palette = "YlOrBr",
  domain = wisccounty@data$percchange
)
leafmap<-leaflet(options = leafletOptions(minZoom = 4)) %>%
  addProviderTiles("CartoDB.Positron", group = "base") %>%
  setView(centerLNG, centerLAT, zoom = 6) %>%
  setMaxBounds(-94, 41, -85, 48) %>%
  addPolygons(data = wisccounty, fillOpacity = 0.7, color = "#b2aeae", smoothFactor = 0.2,
              fillColor = ~my_pal(wisccounty@data$percchange), weight = 2, popup = mypopup) %>%
  addLegend(
    pal=my_pal, values = wisccounty@data$percchange, position = "bottomright", title="% Change Labor Force"
  )

leafmap
