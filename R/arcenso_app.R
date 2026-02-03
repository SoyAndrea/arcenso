#' Launch ARcenso Shiny application
#'
#' Launches a Shiny application to interactively browse and consult
#' Argentina's historical census data.
#'
#' @return Launches the Shiny application (invisibly returns the result of
#'   [shiny::runApp()]).
#'
#' @examples
#' if (interactive()) {
#'   arcenso_app()
#' }
#'
#' @importFrom shiny runApp
#' @export
arcenso_app <- function() {
  app_dir <- system.file("app_arcenso", package = "arcenso")

  if (app_dir == "") {
    stop(
      "No se pudo encontrar el directorio de la aplicaci\u00f3n.",
      call. = FALSE
    )
  }

  shiny::runApp(app_dir)
}
