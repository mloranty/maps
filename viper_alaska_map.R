######################
# script to create map of Alaska sites 
# sampled in 2015 for VIPER project
#
# ML 04/03/20
######################

rm(list=ls())

# load packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(sf)
library(ggmap) # devtools::install_github("dkahle/ggmap")
library(ggrepel)
library(raster)
library(rgdal)
library(rasterVis)
library(RColorBrewer)
library(cowplot)
library(ggspatial)
library(maps)
library(maptools)


# read ESRI states shapefile
st <- st_read("/Volumes/GoogleDrive/My Drive/GIS_Data/ESRIDATA1/USA/STATES.SHP")

# get only the Alaska file and omit extraneous attribute data
ak <- st[51,-c(1,3:52)]

#read viper point data
site <- read.csv("/Volumes/GoogleDrive/My Drive/Documents/research/NSF_VIPER_2015-18/borehole_data/viper_stations_15_16/site_info.csv",
                 header = T)
# longitude values should be negative because we are in the western hemisphere
site$Long <- -site$Long

#convert to sf object for plotting
sc <- st_as_sf(site, coords = c("Long", "Lat"),crs = 4326)
# sc <- SpatialPointsDataFrame(site[,c(7,6)], 
#                               proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"),
#                               site)
 

# create the map
ggplot() +
  geom_sf(data = ak, fill = "gray75", color = "black",expand =F) +
  geom_sf(data = sc, shape = 21, size = 2, color = as.numeric(site$Biome)) +
  coord_sf(label_graticule = "SW")
  
  