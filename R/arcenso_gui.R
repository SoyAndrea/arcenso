#' ARcenso Interactive Interface
#'
#' Launches a basic Shiny application to interactively browse and consult
#' Argentina's historical census data.
#'
#' @return A Shiny app object.
#' @export
#'
#' @examples
#' \dontrun{
#' arcenso_gui()
#' }
arcenso_gui <- function() {

  # UI SIMPLE ---------------------------------------------------------------
  ui <- shiny::fluidPage(
    shiny::titlePanel("ARcenso: Consulta de Datos"),

    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::helpText("Seleccione los filtros para visualizar la tabla."),
        shiny::selectInput("anio", "An\u00f1o censal", choices = c(1970, 1980)),
        shiny::selectInput("geo", "Alcance geogr\u00e1fico", choices = NULL),
        shiny::selectInput("tema", "Tem\u00e1tica", choices = NULL),
        shiny::selectInput("listas", "Seleccione tabla", choices = NULL),
        shiny::hr(),

      ),

      shiny::mainPanel(
        shiny::h3(shiny::textOutput("archivo")),
        gt::gt_output("tablacensal"),
        shiny::br(),
        shiny::uiOutput("fuente_ui")
      )
    )
  )

  # SERVER (La lógica se mantiene casi igual, pero más limpia) -----------
  server <- function(input, output, session) {

    # Observadores para selects dependientes
    shiny::observeEvent(input$anio, {
      geo_filtrada <- info_cuadros_arcenso$Jurisdiccion[info_cuadros_arcenso$anio == input$anio]
      shiny::updateSelectInput(session, "geo", choices = unique(geo_filtrada))
    })

    shiny::observeEvent(input$geo, {
      tema_filtrado <- info_cuadros_arcenso$tema[
        info_cuadros_arcenso$anio == input$anio & info_cuadros_arcenso$Jurisdiccion == input$geo
      ]
      shiny::updateSelectInput(session, "tema", choices = unique(tema_filtrado))
    })

    shiny::observeEvent(input$tema, {
      listas_filtrado <- info_cuadros_arcenso$Titulo[
        info_cuadros_arcenso$anio == input$anio &
          info_cuadros_arcenso$Jurisdiccion == input$geo &
          info_cuadros_arcenso$tema == input$tema
      ]
      shiny::updateSelectInput(session, "listas", choices = unique(listas_filtrado))
    })

    output$tablacensal <- gt::render_gt({
      shiny::req(input$listas)

      # Usamos nuestra propia función get_census para la lógica!
      # Esto es lo más profesional: que la app use las funciones del paquete
      res <- get_census(year = as.numeric(input$anio),
                        topic = input$tema,
                        geolvl = input$geo)

      # Buscamos la tabla específica por título en el índice
      nombre_archivo <- info_cuadros_arcenso$Archivo[info_cuadros_arcenso$Titulo == input$listas]

      if(length(res) > 0 && nombre_archivo %in% names(res)) {
        gt::gt(res[[nombre_archivo]]) %>%
          gt::opt_interactive(use_compact_mode = TRUE)
      }
    })

    output$fuente_ui <- shiny::renderUI({
      txt <- if(input$anio == 1970) "INDEC, Censo Nacional de Poblaci\u00f3n, Familias y Viviendas 1970."
      else "INDEC, Censo Nacional de Poblaci\u00f3n y Viviendas 1980."
      shiny::tags$i(paste("Fuente:", txt))
    })
  }

  shiny::shinyApp(ui, server)
}
