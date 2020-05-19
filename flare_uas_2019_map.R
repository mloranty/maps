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
library(rgeos)
library(gpclib)
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
# t <- get_map('texas', zoom = 6, maptype = 'satellite')
# qmap(location =  , zoom = 14, maptype = "satellite")

# get a background map based roughly on the bounding box for the sampling points
# this should be giving google satellite imagery, but it is not...
c <- get_map(c(left = 160.2, bottom = 67.7, right = 162.7, top = 68.9),
             maptype = "terrain", zoom = 9, source = "osm", force = TRUE)

# read in all of the coordinates of ground control points
sc <- read.csv("/Volumes/data/projects/vege_burn_siberia_2019/flight_info/gcp_coordinates.csv",
               header = T)

# select only those on fire perimeter boundaries
# note there are duplicates, but I am being lazy
b <- sc[which(sc$tr_loc==0),]

# mapp using ggmap, which has ggplot2 syntax, I think
ggmap(c) +
  geom_point(data = b, aes(x = lon, y = lat, color = site), shape = 17,size = 2, position = "jitter") +
  geom_point(aes(x = 161.399713, y = 68.739907),  size = 3, color = "gray25", show.legend = F) +
  geom_text(aes(x = 161.399713-0.25, y = 68.739907, label = "Cherskiy"), show.legend = F) +
  #geom_label_repel(aes(x = 161.399713, y = 68.739907, label = "Northeast Science Station", vjust = "bottom", hjust = "left", color = "black")) +
  theme(legend.position = "bottom", #specify theme aspects including font/text and legend location 
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.title = element_blank(),
        text = element_text(face = "plain", color = "black", size = 16)) +
  scale_color_manual(values = c("orange", "purple", "blue", "red")) +
  ggsn::scalebar(location = "bottomleft", dist = 10, dist_unit ="km", 
                 st.bottom = F,anchor = c(x = 160.3, y = 67.75),
                 transform = T, model = "WGS84",
              #   nudge_x = 0.2, nudge_y = 0.2,
                 x.min = 160.2,x.max = 162.7,
                 y.min = 67.7, y.max = 68.9)

ggsave("/Volumes/GoogleDrive/My Drive/Documents/research/manuscripts/siberia_uas/figure_1_sitemap.png", 
       #       plot = fig_manuscript2, 
       width = 8, height = 8, dpi = 600)


### MAKE PNG or JPG for ANNA ### 4/30/20


# not sure why the scale bar isn't working
# annotation_scale(location = "br", width_hint = 0.25, text_size = 12, text_face = NULL, text_family = "serif", text_col = "black") 




