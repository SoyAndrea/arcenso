#' Metadatos de los cuadros del Censo de Argentina
#'
#' Un dataset que contiene la relación entre jurisdicciones, temas y archivos
#' para facilitar la descarga y visualización interactiva.
#'
#' @format Un data frame con 48 filas y 5 columnas:
#' \describe{
#'   \item{Jurisdiccion}{Nombre de la provincia o jurisdicción (ASCII).}
#'   \item{tema}{Categoría temática del censo.}
#'   \item{Titulo}{Título descriptivo del cuadro estadístico.}
#'   \item{Archivo}{Nombre del archivo asociado para descarga.}
#'   \item{Anio}{Año del censo correspondiente.}
#' }
#' @source \url{https://www.indec.gob.ar/}
#'
#' @import shiny
#' @importFrom gt gt render_gt gt_output opt_interactive
#' @importFrom dplyr filter select %>%
"info_cuadros_arcenso"
