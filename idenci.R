# xml.lonlat <- paste0("http://meteoclimatic.com/feed/rss/",
# lonlat <- xmlParse(rawToChar(GET(xml.lonlat)$content))
# lonlat.l <- t(xmlToList(lonlat, simplify = TRUE))

library(tidyverse)
library(stringr)
library(rvest)
library(sf)
library(leaflet)

codigos <- read_csv('http://sinpad.indeci.gob.pe/Sinpad/Include/export/969012553.csv')
base <- 'http://sinpad.indeci.gob.pe/Sinpad/emergencias/Evaluacion/Reporte/rpt_eme_situacion_emergencia.asp?EmergCode='
lista <- list()

for (i in 1:nrow(codigos)) {
  url <- sprintf('%s%s',base,codigos[["Codigo"]][i])
  page <- read_html(url)
  table <- html_table(page)[[1]] %>% 
    as.matrix() %>% 
    t() %>% 
    as.data.frame() %>% 
    drop_na(V1)
  
  a = page %>%
    html_nodes("td") %>% 
    as.vector() %>% 
    str_extract(".(-[0-9]+).*") %>% 
    substr(2,9) %>% 
    gsub(pattern = ',',replacement = '.') %>% 
    na.omit() %>%
    as.numeric() %>% 
    na.omit() %>% 
    as.vector()
  
  coords <- tibble(
    lat = a[2],
    lon = a[1])
  lista[[i]] <- coords 
}


tabla_coord <- map_df(lista,as.data.frame) %>% 
  drop_na(lat,lon)

point_to_sf <- data.frame(
  lon = tabla_coord$lat,
  lat = tabla_coord$lon
  ) %>% 
  st_as_sf(coords = c("lon", "lat"), crs = 4326)

mapa <- point_to_sf %>% 
  leaflet() %>%
  addProviderTiles(provider = 'OpenStreetMap') %>% 
  addCircles()





