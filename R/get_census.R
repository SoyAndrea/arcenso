#' Get census data tables
#'
#' Retrieves curated data tables from Argentina's official population censuses
#' based on table ID or filtering criteria.
#'
#' @param year Integer. Census year. Valid census years are 1970, 1980,
#'   1991, 2001, 2010, and 2022. Currently, only 1970 and 1980 are
#'   available in this package. Used only when `id` is `NULL`.
#' @param id Character vector. Specific table IDs to retrieve
#'   (e.g., `"1970_00_estructura_01"`). If supplied, this takes precedence over
#'   `year`, `topic`, and `geo_code`.
#' @param topic Character vector. Keywords to filter topics
#'   (e.g., `"migracion"`, `c("vivienda", "material")`).
#'   Matching is case-insensitive and accent-insensitive.
#' @param geo_code Character vector. Geographic code(s) (e.g., `"02"` for CABA).
#'
#' @return If one table is found, a data frame. If multiple tables are found,
#'   a named list of data frames. If no matches are found, returns `NULL`.
#' @export
#'
#' @examples
#' # 1. Retrieve a specific table by ID
#' educacion <- get_census(id = "1970_00_educacion_01")
#' head(educacion)
#'
#'
#' # 2. Retrieve tables by topic (may return multiple tables)
#' housing_data <- get_census(year = 1970, topic = "habitacional")
#'
#'
#' # Explore the list and extract the first table
#' housing_data[[1]]
#'
#'
#' # 3. Retrieve a single table using filters (returns a data frame)
#' poblacion_total <- get_census(
#'   year = 1970,
#'   topic = "estructura",
#'   geo_code = "00"
#' )
#' head(poblacion_total)

get_census <- function(year = NULL, id = NULL, topic = NULL, geo_code = NULL) {

  # Input validation
  valid_years <- c(1970, 1980, 1991, 2001, 2010, 2022)
  available_years <- c(1970, 1980)

  if (is.null(id) && is.null(year)) {
    stop("Debes indicar `id` o `year`.")
  }

  if (!is.null(year) && !year %in% valid_years) {
    stop(
      paste0("El a\u00f1o ", year, " no es un a\u00f1o censal v\u00e1lido.")
    )
  }

  if (!is.null(year) && !year %in% available_years) {
    stop(
      paste0(
        "El a\u00f1o ", year,
        " es un a\u00f1o censal v\u00e1lido, pero a\u00fan no est\u00e1 disponible en este paquete."
      )
    )
  }

  # Helper functions
  clean_text <- function(x) {
    x <- tolower(x)
    x <- trimws(x)
    chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", x)
  }

  clean_fname <- function(x) {
    x <- tolower(x)
    x <- trimws(x)
    x <- gsub("\\.rds$", "", x)
    chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", x)
  }

  # Metadatos
  selec <- census_metadata

  # Selección de metadatos
  if (!is.null(id)) {

    idx <- match(id, selec$id_cuadro)
    idx <- idx[!is.na(idx)]
    selec <- selec[idx, , drop = FALSE]

  } else {

    selec <- selec[selec$anio == year, , drop = FALSE]

    if (!is.null(geo_code)) {
      selec <- selec[selec$cod_geo %in% geo_code, , drop = FALSE]
    }

    if (!is.null(topic)) {
      topic_clean <- clean_text(topic)
      temas_db_clean <- clean_text(selec$tema)

      topic_pattern <- paste(topic_clean, collapse = "|")
      selec <- selec[grepl(topic_pattern, temas_db_clean), , drop = FALSE]
    }
  }

  if (nrow(selec) == 0) {
    warning("No se encontraron tablas con los filtros especificados.")
    return(NULL)
  }

  # Lectura de archivos
  out <- list()

  for (i in seq_len(nrow(selec))) {
    year_i <- selec$anio[i]
    file_i <- selec$archivo_rds[i]
    id_i <- selec$id_cuadro[i]

    path_year <- system.file("extdata", as.character(year_i), package = "arcenso")
    archivos_reales <- list.files(path_year, full.names = TRUE)

    if (length(archivos_reales) == 0) {
      warning(
        paste0("No se encontraron archivos .rds en extdata/", year_i, ".")
      )
      next
    }

    reales_clean <- clean_fname(basename(archivos_reales))
    buscado_clean <- clean_fname(file_i)

    match_idx <- which(reales_clean == buscado_clean)

    if (length(match_idx) == 0) {
      warning(
        paste0("No se encontr\u00f3 el archivo asociado al cuadro: ", id_i)
      )
      next
    }

    out[[id_i]] <- readRDS(archivos_reales[match_idx[1]])
  }

  if (length(out) == 0) {
    warning("Se encontraron metadatos coincidentes, pero no se pudo cargar ning\u00fan archivo.")
    return(NULL)
  }

  # Si hay una sola tabla, devolver data frame directo
  if (length(out) == 1) {
    return(out[[1]])
  }

  # Si hay varias, devolver lista nombrada
  out
}
