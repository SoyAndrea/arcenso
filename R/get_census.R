#' Get census data tables
#'
#' Retrieves a list of curated data tables from Argentina's official population
#' censuses based on the specified filters.
#'
#' @param year Census year (1970 or 1980). Default is 1970.
#' @param topic Census topic of the tables (e.g., "EDUCACION").
#' If NULL, all available topics for the year will be retrieved.
#' @param geolvl Geographic disaggregation level (e.g., "Total del país").
#' If NULL, all jurisdictions will be retrieved.
#'
#' @return A list of data frames containing the requested census tables.
#' @export
get_census <- function(year = 1970, topic = NULL, geolvl = NULL) {

  # 1. Validar año
  if (year != 1970 && year != 1980) {
    stop(paste0("El an\u00f1o ", year, " no es un an\u00f1o censal disponible."))
  }

  # 2. Filtrar el índice (metadatos)
  selec <- info_cuadros_arcenso[info_cuadros_arcenso$anio %in% year &
                                  info_cuadros_arcenso$PKG %in% "SI", ]

  if (!is.null(topic)) {
    selec <- selec[selec$tema %in% topic, ]
  }

  if (!is.null(geolvl)) {
    selec <- selec[grepl(geolvl, selec$Jurisdiccion), ]
  }

  # 3. Ubicar archivos
  path_year <- system.file("extdata", as.character(year), package = "arcenso")
  # Buscamos archivos .rds ignorando mayúsculas/minúsculas (ignore.case = TRUE)
  all_files <- list.files(path_year, full.names = TRUE, pattern = "\\.rds$", ignore.case = TRUE)

  if (length(all_files) == 0) return(list())

  lista_cuadros <- list()

  for (f in all_files) {
    # Obtenemos nombre limpio: "c70_buenosaires_poblacion_c1"
    file_id <- tools::file_path_sans_ext(basename(f))

    # COMPARACIÓN DIRECTA:
    # Si el nombre del archivo está en nuestra columna 'Archivo', lo cargamos.
    # Usamos tolower() en ambos lados para evitar errores de mayúsculas.
    if (tolower(file_id) %in% tolower(selec$Archivo)) {
      lista_cuadros[[file_id]] <- readRDS(f)
    }
  }

  return(lista_cuadros)
}
