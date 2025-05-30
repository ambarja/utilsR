capitalizar_oraciones <- function(texto) {
  # Divide en oraciones por punto y espacio
  partes <- unlist(strsplit(tolower(texto), "(?<=\\.)\\s+", perl = TRUE))
  
  # Aplica mayúscula a la primera letra de cada oración
  partes <- sapply(partes, function(oracion) {
    paste0(toupper(substr(oracion, 1, 1)), substr(oracion, 2, nchar(oracion)))
  })
  
  # Une de nuevo en un solo texto
  resultado <- paste(partes, collapse = " ")
  return(resultado)
}
