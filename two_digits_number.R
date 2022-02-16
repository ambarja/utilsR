two_digits <- function(x){
  if(nchar(x) == 2){
    digits = x
  }else{
    digits = sprintf("0%s",x)
  }
  return(digits)
}
