```
data <- ee$FeatureCollection("users/ambarja/Utils/Lima")
data$limit(0)$getInfo()$column %>% as.data.frame()
```
```
> data$limit(0)$getInfo()$column %>% as.data.frame()
  AREA_KM2 FEC_ACT FUENTE NOMBDEP NOMBPROV  fid system.index
1    Float    Long String  String   String Long       String
```
