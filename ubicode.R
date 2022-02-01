# Ubigeo
ubicode <- function(x){
  if(nchar(as.vector(x)) == 6){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("0%s",x)
  }
}

# idmz
ubicode <- function(x){
  if(nchar(as.vector(x)) == 19){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("%s0",x)
  }
}
