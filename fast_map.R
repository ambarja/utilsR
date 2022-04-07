library(pals)
library(sf)
library(tidyverse)
library(basemapR)
library(showtext)
library(ggspatial)
font_add_google('Anton')

data <- st_read("lima.gpkg")
names(data)
my_bbox <- st_bbox(data) %>%
  st_as_sfc() %>%
  st_union(st_as_sfc(st_bbox(data))) %>%
  st_bbox()


data %>% 
  mutate(ZONA = factor(ZONA)) %>% 
  ggplot() + 
  base_map(bbox = my_bbox, basemap = 'positron', increase_zoom = 2) + 
  geom_sf(aes(fill = ZONA), lwd = 0.05) +
  scale_fill_manual(values = c(stepped(n = 24),stepped2(n = 9))) + 
  guides(fill=guide_legend(ncol=12)) + 
  theme_minimal() + 
  theme(legend.position = "bottom") + 
  labs(title = "LIMA - CENSUS BLOCKS") + 
  theme(plot.title = element_text(family = "Anton",face = "bold",size = 30)) + 
  annotation_north_arrow(
    height = unit(6,units = "mm"),
    width = unit(6,units = "mm"),
    pad_y = unit(12,units = "cm")) +
  annotation_scale(
    height =  unit(2.0,"mm"),
    line_width = 0.05)

ggsave(filename = "mapa.png",
       plot = last_plot(),
       width =10 ,
       height = 7,
       bg = "white")

