ubicode <- function(x){
  if(nchar(as.vector(x)) == 6){
    x <- sprintf("%s",x)
  }else{
    x <- sprintf("0%s",x)
  }
}
