library(sf)
library(tidyverse)
library(lwgeom)

villages <-  read_csv("ffi_locations.csv") %>% 
  select(1,3,4) %>% 
  drop_na() %>% 
  st_as_sf(coords = c("ffi_gps_long","ffi_gps_lat"),crs = 4326) %>% 
  distinct(ffi_h_code,.keep_all = T)

rivers <- st_read("rivers_ffi_v2.gpkg") %>% 
  st_transform(4326)

near_distance_pto_2_line <- function(x){
  ptos <- villages[x,]
  sprintf("👨🏻‍💻Processing %s ...", ptos[["ffi_h_code"]])
  lines <- rivers
  pto_to_line <- st_nearest_points(ptos,lines) 
  end_coord <- st_endpoint(pto_to_line)
  index <- st_nearest_feature(lines,end_coord)
  table_distance <- pto_to_line %>% 
    st_as_sf() %>% 
    rename(geom = x) %>% 
    mutate(
      ffi_h_code =  ptos[["ffi_h_code"]],
      name = rivers[index,][["NOMBRE"]],
      distance_km = (st_length(geom) %>% as.vector())/1000) %>% 
    select(
      ffi_h_code,
      distance_km,
      name,
      geom)
  return(table_distance)
}

lista_distancia <- lapply(
  1:nrow(villages),
  near_distance_pto_2_line
  )

db_final <- lista_distancia %>% 
  bind_rows()

write_sf(db_final,"ffi_distance_to_rivers.gpkg")
write_csv(db_final %>% st_drop_geometry(),"ffi_distance_to_rivers.csv")