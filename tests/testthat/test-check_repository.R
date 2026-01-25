check_repository <- function(year = NULL, topic = NULL, geo_code = NULL) {

  # 1. Carga los datos completos
  data <- census_metadata

  # 2. Filtra por año (si se pide)
  if (!is.null(year)) {
    data <- data[data$anio == year, ]
  }

  # 3. Filtra por tema (si se pide)
  if (!is.null(topic)) {
    data <- data[grepl(topic, data$tema, ignore.case = TRUE), ]
  }

  # 4. Filtra por geografía (si se pide)
  if (!is.null(geo_code)) {
    data <- data[data$cod_geo == geo_code, ]
  }

  # 5. RETORNA TODO (Importante: NO selecciones columnas específicas aquí)
  return(data)
}
