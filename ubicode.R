# Ubigeo - dist
ubicode_dist <- function(x){
  if(nchar(as.vector(x)) == 6){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("0%s",x)
  }
  return(x)
}

# Ubigeo - mz
ubicode_mz <- function(x){
  if(nchar(as.vector(x)) == 19){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("%s0",x)
  }
  return(x)
}

# Ubigeo - cp 

ubicode_cp <- function(x){
  if(nchar(as.vector(x)) == 10){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("0%s",x)
  }
  return(x)
}

# Zonal censal 
ubicode_zona <- function(x){
  if(nchar(as.vector(x)) == 15){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("0%s",x)
  }
  return(x)
}
