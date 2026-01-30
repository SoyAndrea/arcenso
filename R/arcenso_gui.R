#' Launches a basic Shiny application to interactively browse and consult
#' Argentina's historical census data.
#'
#' @return A Shiny app object.
#'
#' @examples
#' if (interactive()) {
#'   arcenso_gui()
#' }
#'
#' @importFrom shiny runApp
#' @importFrom gt gt_output render_gt
#' @export
arcenso_gui <- function() {
  app_dir <- system.file("app_arcenso", package = "arcenso")

  if (app_dir == "") {
    stop("No se pudo encontrar el directorio de la aplicación. Reinstala el paquete.", call. = FALSE)
  }

  shiny::runApp(app_dir, display.mode = "normal")
}
