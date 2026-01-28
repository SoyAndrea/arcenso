#' Get census data tables
#'
#' Retrieves a list of curated data tables from Argentina's official population
#' censuses based on the specified filters.
#'
#' @param year Integer. Census year (1970 or 1980). Default is 1970.
#' @param id Character vector. Specific Table IDs to retrieve (e.g., "1970_00_estructura_01").
#' If specified, this takes precedence over topic filters.
#' @param topic Character vector. Keywords to filter topics (e.g., "migracion", c("vivienda", "material")).
#' Matches are case-insensitive.
#' @param geo_code Character. Geographic code (e.g., "02" for CABA).
#'
#' @return A list of data frames containing the requested census tables.
#' @export
#'
#' @examples
#' # 1. Retrieve a specific table by its ID
#'
#' # Note: 'year' is still required to locate the file in the correct folder
#' my_table <- get_census(year = 1970, id = "1970_00_estructura_01")
#'
#' my_table
#'
#' # 2. Retrieve tables by topic (e.g., all tables about 'habitacional')
#'
#' housing_data <- get_census(year = 1970, topic = "habitacional")
#'
#' # Explore the list and extract the first table
#' housing_data[[1]]
get_census <- function(year = 1970, id = NULL, topic = NULL, geo_code = NULL) {
  # 1. Validar anio (ASCII safe)
  if (!year %in% c(1970, 1980)) {
    stop(paste0("El an\u00f1o ", year, " no es un an\u00f1o censal disponible."))
  }

  # 2. Cargar metadatos
  selec <- census_metadata
  selec <- selec[selec$anio == year, ]

  # --- LOGICA DE FILTROS ---

  if (!is.null(id)) {
    # Prioridad absoluta al ID
    selec <- selec[selec$id_cuadro %in% id, ]
  } else {
    # Filtros opcionales
    if (!is.null(geo_code)) {
      selec <- selec[selec$cod_geo == geo_code, ]
    }

    if (!is.null(topic)) {
      # Limpieza para busqueda de temas (sin tildes)
      clean_topic <- function(x) {
        x <- tolower(x)
        chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", x)
      }

      topic_clean <- clean_topic(topic)
      temas_db_clean <- clean_topic(selec$tema)

      topic_pattern <- paste(topic_clean, collapse = "|")
      selec <- selec[grepl(topic_pattern, temas_db_clean, ignore.case = TRUE), ]
    }
  }

  if (nrow(selec) == 0) {
    warning("No se encontraron tablas con los filtros especificados.")
    return(list())
  }

  # 3. LECTURA DE ARCHIVOS

  path_year <- system.file("extdata", as.character(year), package = "arcenso")

  archivos_reales <- list.files(path_year, full.names = TRUE)

  if (length(archivos_reales) == 0) {
    warning(paste("No se encontraron archivos .rds en la carpeta extdata para el a\u00f1o", year))
    return(list())
  }

  # --- FUNCION DE LIMPIEZA DE NOMBRES ---
  clean_fname <- function(x) {
    x <- tolower(x)
    x <- gsub("\\.rds$", "", x)
    x <- chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", x)
    return(x)
  }

  reales_clean <- clean_fname(basename(archivos_reales))

  lista_cuadros <- list()

  # 4. Loop de carga
  for (i in seq_len(nrow(selec))) {
    buscado_clean <- clean_fname(selec$archivo_rds[i])
    match_idx <- which(reales_clean == buscado_clean)

    if (length(match_idx) > 0) {
      cuadro_id <- selec$id_cuadro[i]
      lista_cuadros[[cuadro_id]] <- readRDS(archivos_reales[match_idx[1]])
    }
  }

  return(lista_cuadros)
}
