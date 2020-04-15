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
#ak <- st_transform(st[51,-c(1,3:52)], CRS("+proj=lcc =lon_0=-150 +lat_0=65 +lat1=60 +lat_1=65 +lon_1=-155"))
ak <- st[51,-c(1,3:52)]
ak2 <- st_transform(ak,3857)
#read viper point data
site <- read.csv("/Volumes/GoogleDrive/My Drive/Documents/research/NSF_VIPER_2015-18/borehole_data/viper_stations_15_16/site_info.csv",
                 header = T)
# longitude values should be negative because we are in the western hemisphere
site$Long <- -site$Long

#convert to sf object for plotting
sc <- st_as_sf(site, coords = c("Long", "Lat"),crs = 4326)
sc2 <- 
 
# create the map
ggplot() +
  geom_sf(data = ak, fill = "gray75", color = "black") +
  #geom_point(data = site, aes(x = Long, y = Lat, color = Biome), shape = 16, position = "jitter") +
  geom_point(data = site, aes(x = Long, y = Lat, color = Biome), shape = 16, size = 3, position = "jitter") +
  theme(legend.position = "bottom", #specify theme aspects including font/text and legend location 
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.title = element_blank(),
        text = element_text(face = "plain", color = "black", size = 16)) +
#        ylab("Latitude") +
  
  scale_color_manual(values = c("black", "red")) + #manually set the colors
  
  # scale_color_manual(values = c("boreal" = "black", "tunrda" = "red"),guide = "legend",
  #                    labels = c("Boreal", "Tundra")) +
  
  coord_sf(label_graticule = "SW", xlim = c(-177, -131)) #specify axis limits and graticule locations

#  coord_sf(crs = "+proj=aea +lat_1=50 +lat_2=58.5 +lat_0=65 +lon_0=-146 +x_0=1000000 +y_0=0 +datum=NAD83 +units=m +no_defs", 
#           xlim = c(983000, 1071000), ylim = c(892000, 941000), 
#           expand = FALSE, label_graticule = "SW")
    
# save map file
ggsave("/Volumes/GoogleDrive/My Drive/Documents/research/manuscripts/mcculloch_roots/ak_map.pdf", 
#       plot = fig_manuscript2, 
       width = 8, height = 8, dpi = 600)


  