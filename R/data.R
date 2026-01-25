#' Census Metadata (Table Catalog)
#'
#' A dataframe containing the inventory of all available census tables,
#' including year, topic, geographic level, and the unique ID required for downloading.
#'
#' @format A tibble with the following columns:
#' \describe{
#'   \item{id_cuadro}{Unique identifier (e.g., "1970_02_educacion_01"). Use this ID in \code{get_census()}.}
#'   \item{anio}{Census year (e.g., 1970, 1980, 1991, 2001, 2010).}
#'   \item{unidad}{Unit of analysis (e.g., Población, Hogares, Viviendas).}
#'   \item{tema}{Main topic (e.g., educacion, vivienda, actividad).}
#'   \item{cod_geo}{INDEC geographic code (e.g., "02", "06").}
#'   \item{archivo}{Internal physical file name.}
#'   \item{titulo}{Descriptive title of the table.}
#' }
#' @source Own elaboration based on INDEC data.
"census_metadata"

#' Geographic Metadata (Geographic Dictionary)
#'
#' Reference table to translate INDEC geographic codes into province names
#' and regions, including ISO 3166-2 codes for mapping.
#'
#' @format A tibble with the following columns:
#' \describe{
#'   \item{cod_geo}{INDEC code (character, two digits).}
#'   \item{nombre_geo}{Official province name (Ordered factor).}
#'   \item{nombre_corto}{Short name, ideal for plots.}
#'   \item{iso_3166_2}{International standard code (e.g., "AR-C") for map joining.}
#' }
#' @source INDEC and ISO 3166-2 standardization.
"geo_metadata"
