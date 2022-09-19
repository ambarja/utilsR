library(tidyverse)
library(OpenImageR)

list_jpg <- list.files(path = ".",pattern = ".jpg$")
readingjpg <- lapply(list_jpg,FUN = readImage)
names_jpg <- list_jpg %>%
  str_sub(6,max(nchar(list_jpg)))%>%
  gsub("d","",.)%>%
  gsub("_co","",.) %>%
  gsub("o","",.) %>%
  gsub(")","",.)

save_jpg <- function(x){
  if(!dir.exists("final")){dir.create("final")}
  readjpg <- readingjpg[[x]]
  writeImage(
    readjpg,
    file_name = paste0("final/",names_jpg[x]),
    quality = 1
    )
  sprintf("Esto ya termino :3 :: %s",x) |> print()
}

lapply(1:length(list_jpg),save_jpg)
