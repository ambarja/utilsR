capitalizar_oraciones <- function(texto) {
  partes <- unlist(strsplit(tolower(texto), "(?<=\\.)\\s+", perl = TRUE))
  partes <- sapply(partes, function(oracion) {
    paste0(toupper(substr(oracion, 1, 1)), substr(oracion, 2, nchar(oracion)))
  })
  resultado <- paste(partes, collapse = " ")
  return(resultado)
}
