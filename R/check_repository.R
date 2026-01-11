#' Check available census tables
#'
#' Reports the census tables currently available in the package for consultation
#' based on the provided filters.
#'
#' @param year Census year (1970 or 1980). Default is 1970.
#' @param topic Census topic of the tables (e.g., "EDUCACION").
#' If NULL, all available topics for the selected year will be shown.
#' @param geolvl Geographic disaggregation level (e.g., "Total del país").
#' If NULL, all jurisdictions will be included.
#'
#' @return A data frame containing the table titles and the internal names
#' required to access them via the get_census function.
#' @export
#'
#' @examples
#' check_repository(year = 1970, topic = "EDUCACION", geolvl = "Total del país")
check_repository <- function(year = 1970, topic = NULL, geolvl = NULL) {

  # 1. Validate year (ASCII escapes in error messages)
  if (year != 1970 && year != 1980) {
    stop(paste0("El an\u00f1o ", year, " todav\u00eda no fue cargado en arcenso o no es un an\u00f1o censal"))
  }

  # 2. Initial filtering
  # Uses the internal dataset documented in data.R
  selec <- info_cuadros_arcenso[info_cuadros_arcenso$anio %in% year &
                                  info_cuadros_arcenso$PKG %in% "SI", ]

  # 3. Validate Topic
  if (!is.null(topic)) {
    if (!topic %in% unique(selec$tema)) {
      stop(paste0("Tem\u00e1tica elegida inv\u00e1lida. \nLas tem\u00e1ticas disponibles son: \n",
                  paste(unique(selec$tema), collapse = "\n")))
    }
    selec <- selec[selec$tema %in% topic, ]
  }

  # 4. Filter by geographic level
  if (!is.null(geolvl)) {
    # Using grepl for flexibility
    selec <- selec[grepl(geolvl, selec$Jurisdiccion), ]
  }

  # 5. Select final columns
  lista_cuadros <- selec[, c("Archivo", "Titulo")]

  # Clean row names for aesthetic output
  rownames(lista_cuadros) <- NULL

  return(lista_cuadros)
}
