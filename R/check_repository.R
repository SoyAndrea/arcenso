#' Check available census tables
#'
#' Explores the catalog of census tables available in the package.
#' This function helps identify the correct \code{id_cuadro} required
#' to download data using \code{\link{get_census}}.
#'
#' The output columns are dynamically adjusted based on the filters applied
#' to avoid redundant information.
#'
#' @param year Integer. The census year (e.g., 1970, 1980).
#' @param topic Character. The specific topic of the table (e.g., "educacion", "vivienda").
#' To see the list of available topics, run: \code{unique(census_metadata$tema)}.
#' @param geo_code Character. The INDEC geographic code (e.g., "02" for CABA).
#' To see the full list of codes and names, inspect: \code{View(geo_metadata)}.
#'
#' @return A data frame containing the \code{id_cuadro}, title, and relevant context columns.
#' @export
#'
#' @seealso \code{\link{get_census}} to download the data found here.
#'
#' @examples
#' # Check all tables available for the 1970 census
#' check_repository(year = 1970)
#'
#' # Search for a specific topic in a specific jurisdiction (CABA)
#' # Note: Topics are in Spanish as they appear in the original source
#' check_repository(topic = "educacion", geo_code = "02")
check_repository <- function(year = NULL, topic = NULL, geo_code = NULL) {
  out <- census_metadata

  # Filtro por AÑO
  if (!is.null(year)) {
    available_years <- unique(out$anio)
    if (!year %in% available_years) {
      stop(
        "El a\u00f1o ", year, " no est\u00e1 disponible. A\u00f1os v\u00e1lidos: ",
        paste(available_years, collapse = ", ")
      )
    }
    # Subset base: filas donde anio coincide
    out <- out[out$anio == year, ]
  }

  # Filtro por TEMA
  if (!is.null(topic)) {
    available_topics <- unique(out$tema)
    if (!topic %in% available_topics) {
      stop(
        "El tema '", topic, "' no es v\u00e1lido. Temas disponibles:\n",
        paste(available_topics, collapse = ", ")
      )
    }
    out <- out[out$tema == topic, ]
  }

  # Filtro por GEO
  if (!is.null(geo_code)) {
    available_geos <- unique(out$cod_geo)
    if (!geo_code %in% available_geos) {
      stop("El c\u00f3digo '", geo_code, "' no existe. Consulte arcenso::geo_metadata.")
    }
    out <- out[out$cod_geo == geo_code, ]
  }

  # --- SELECCIÓN DINÁMICA DE COLUMNAS ---

  # Vector de nombres de columnas a mantener
  cols_to_keep <- c("id_cuadro")

  # Solo agregamos 'anio' si el usuario NO filtró por un año específico
  if (is.null(year)) {
    cols_to_keep <- c(cols_to_keep, "anio")
  }

  # Solo agregamos 'cod_geo' si el usuario NO filtró por geo
  if (is.null(geo_code)) {
    cols_to_keep <- c(cols_to_keep, "cod_geo")
  }

  # El título siempre va al final
  cols_to_keep <- c(cols_to_keep, "titulo")

  # Subset de columnas
  out_final <- out[, cols_to_keep, drop = FALSE]

  # Limpieza visual: Resetear los nombres de las filas (1, 5, 24...) a (1, 2, 3...)
  rownames(out_final) <- NULL

  # Verificación final
  if (nrow(out_final) == 0) {
    message("No se encontraron cuadros con esa combinaci\u00f3n de filtros.")
    return(invisible(NULL))
  }

  return(out_final)
}
