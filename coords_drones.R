library(exiftoolr)
library(leaflet)
library(tidyverse)
library(tidyverse)

path = "ANAFI/"
lista <- list.files(path,pattern = ".JPG$") %>% 
  sprintf("%s%s",path,.)

datos <- lapply(X = lista,FUN = exif_read)

get_coords <- function(x){
  newdata <- datos[[x]] %>% 
    tibble() %>% 
    select(GPSLatitude, GPSLongitude) %>% 
    rename(lat = GPSLatitude, lng = GPSLongitude)
  return(newdata)
}

newdata <- lapply(1:length(datos),get_coords)  %>% 
  map_df(.f = as_tibble)

newdata %>% 
  leaflet() %>% 
  addProviderTiles(provider = providers$Esri.WorldImagery) %>% 
  addCircleMarkers()
