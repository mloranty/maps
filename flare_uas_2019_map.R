######################
# script to create map of Siberia sites 
# sampled in 2019 for FLARE project
#
# ML 04/15/20
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
library(ggsn)

# note need a google API key for qmap
t <- get_map('texas', zoom = 6, maptype = 'satellite')
qmap(location =  , zoom = 14, maptype = "satellite")

# get a background map based roughly on the bounding box for the sampling points
# this should be giving google satellite imagery, but it is not...
c <- get_map(c(left = 160.2, bottom = 67.7, right = 162.7, top = 68.9),
             maptype = "satellite", zoom = 10, source = "google", force = T)

# was thinking about using Logan's biomass background - not a great background though
#bio <- raster("/Volumes/data/data_repo/gis_data/Berner_2011_Kolyma_fire_biomass/kolyma_landsat5_larch_AGB_gm2_2007.tif")

# read in all of the coordinates of ground control points
sc <- read.csv("/Volumes/data/projects/vege_burn_siberia_2019/flight_info/gcp_coordinates.csv",
               header = T)

# select only those on fire perimeter boundaries
# note there are duplicates, but I am being lazy
b <- sc[which(sc$tr_loc==0),]

# mapp using ggmap, which has ggplot2 syntax, I think
ggmap(c) +
  geom_point(data = b, aes(x = lon, y = lat, color = site), size = 3, position = "jitter") +
  #geom_point(aes(x = 161.399713, y = 68.739907, color = "orange"), shape = 8, size = 5) +
  #geom_label_repel(aes(x = 161.399713, y = 68.739907, label = "Northeast Science Station", vjust = "bottom", hjust = "left", color = "black")) +
  theme(legend.position = "bottom", #specify theme aspects including font/text and legend location 
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.title = element_blank(),
        text = element_text(face = "plain", color = "black", size = 16)) +
  scale_color_manual(values = c("black", "red", "blue", "yellow")) +
  ggsn::scalebar(c,location = "bottomright", dist = 100, dist_unit ="km", transform = T)

# not sure why the scale bar isn't working
  annotation_scale(location = "br", width_hint = 0.25, text_size = 12, text_face = NULL, text_family = "serif", text_col = "black") 




