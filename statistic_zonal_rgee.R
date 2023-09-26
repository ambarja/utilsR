library(rgee)
library(innovar)
library(sf)
library(tidyverse)
ee_Initialize()
data("Peru")

peru_ee <- Peru |> st_as_sf() |> select(ubigeo) 

polygon_ee <- peru_ee[1503:1874,] |> 
    st_transform(32718) |> 
    st_simplify(dTolerance = 250,preserveTopology = TRUE) |> 
    st_transform(4326) |> 
    sf_as_ee()

# 1:500
lista_500_v1 <- get_vegetation(
  from = '2000-02-18',
  to = '2022-12-21',
  band = "NDVI",
  region = polygon_ee,
  fun = "mean"
  )
 
# # 501:1001
lista_500_v2 <- get_vegetation(
  from = '2000-02-18',
  to = '2022-12-21',
  band = "NDVI",
  region = polygon_ee,
  fun = "mean"
)

# # 1002:1502
lista_500_v3 <- get_vegetation(
  from = '2000-02-18',
  to = '2022-12-21',
  band = "NDVI",
  region = polygon_ee,
  fun = "mean"
)

# 1503:1874
lista_374_v4 <- get_vegetation(
  from = '2000-02-18',
  to = '2022-12-21',
  band = "NDVI",
  region = polygon_ee,
  fun = "mean"
)

lista_total <- list(lista_500_v1,lista_500_v2,lista_500_v3,lista_374_v4)

dasedatos <- lista_total |> 
  map_df(.f = as.data.frame) |> 
  pivot_longer(
    cols = `NDVI2000-02`:`NDVI2022-12`,
    names_to = "year",
    values_to = "ndvi"
    ) |> 
  mutate(
    month = as.double(str_sub(year,10,11)),
    year = as.double(str_sub(year,5,8))
  ) |> 
  select(ubigeo,year,month,ndvi)

# write_csv(dasedatos,"Mis vídeos/bbdd_ndvi_modqa1_2000_2022.csv")
# evi <- read_csv("Mis vídeos/bbdd_evi_modqa1_2000_2022.csv")
# ndvi <- read_csv("Mis vídeos/bbdd_ndvi_modqa1_2000_2022.csv")
# veg <- inner_join(x = evi,y = ndvi, by = c("ubigeo","year","month"))

write_csv(veg,"Mis vídeos/bbdd_vegetation_modqa1_2000_2022.csv")
