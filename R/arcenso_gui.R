#' ARcenso Interactive Interface
#'
#' Launches a basic Shiny application to interactively browse and consult
#' Argentina's historical census data.
#'
#' @return A Shiny app object.
#'
#' @examples
#' \dontrun{
#' arcenso_gui()
#' }
#'
#' @import shiny
#' @import gt
#' @export
arcenso_gui <- function() {

  # UI ----------------------------------------------------------------------
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
        shiny::p("Desarrollado con el paquete {arcenso}")
      ),

      shiny::mainPanel(
        shiny::div(
          style = "text-align: right; margin-bottom: 10px; border-bottom: 1px solid #eee; padding-bottom: 5px;",
          shiny::tags$span("ID de Cuadro: ", style = "color: #666; font-size: 0.9em; margin-right: 5px;"),
          shiny::tags$code(shiny::textOutput("id_view", inline = TRUE),
                           style = "color: #007bff; font-weight: bold; font-size: 1.1em;")
        ),

        gt::gt_output("tablacensal"),

        shiny::br(),
        shiny::uiOutput("fuente_ui")
      )
    )
  )

  # SERVER ------------------------------------------------------------------
  server <- function(input, output, session) {

    # 1. Filtros (Con freezeReactiveValue para evitar errores al cambiar año)
    shiny::observeEvent(input$anio, {
      shiny::req(input$anio)

      # --- FIX 1: CONGELAR INPUTS ---
      # Esto evita que se disparen errores mientras se calculan las nuevas opciones
      shiny::freezeReactiveValue(input, "geo")
      shiny::freezeReactiveValue(input, "tema")
      shiny::freezeReactiveValue(input, "listas")
      # ------------------------------

      codigos_existentes <- census_metadata$cod_geo[census_metadata$anio == input$anio]
      geo_subset <- geo_metadata[geo_metadata$cod_geo %in% codigos_existentes, ]

      es_total <- geo_subset$cod_geo == "00"
      df_total <- geo_subset[es_total, ]
      df_provs <- geo_subset[!es_total, ]
      df_provs <- df_provs[order(df_provs$cod_geo), ]

      geo_sorted <- rbind(df_total, df_provs)
      opciones <- stats::setNames(geo_sorted$cod_geo, geo_sorted$nombre_geo)

      shiny::updateSelectInput(session, "geo", choices = opciones)
    })

    shiny::observeEvent(input$geo, {
      shiny::req(input$anio)
      shiny::freezeReactiveValue(input, "tema")   # Congelamos los siguientes
      shiny::freezeReactiveValue(input, "listas")

      tema_filtrado <- census_metadata$tema[
        census_metadata$anio == input$anio & census_metadata$cod_geo == input$geo
      ]
      shiny::updateSelectInput(session, "tema", choices = sort(unique(tema_filtrado)))
    })

    shiny::observeEvent(input$tema, {
      shiny::req(input$anio, input$geo)
      shiny::freezeReactiveValue(input, "listas") # Congelamos el último

      listas_filtrado <- census_metadata$titulo[
        census_metadata$anio == input$anio &
          census_metadata$cod_geo == input$geo &
          census_metadata$tema == input$tema
      ]
      shiny::updateSelectInput(session, "listas", choices = sort(unique(listas_filtrado)))
    })

    # 2. Output ID
    output$id_view <- shiny::renderText({
      shiny::req(input$listas)
      # Validacion rapida para evitar parpadeos
      titulo_valido <- input$listas %in% census_metadata$titulo[census_metadata$anio == input$anio]
      if(!titulo_valido) return("-")

      id <- census_metadata$id_cuadro[census_metadata$titulo == input$listas]
      if(length(id) > 0) id[1] else "-"
    })

    # 3. Render Tabla
    output$tablacensal <- gt::render_gt({
      shiny::req(input$listas)

      # --- FIX 2: VALIDACIÓN DE SEGURIDAD ---
      # Verificamos que el titulo seleccionado realmente pertenezca al anio seleccionado.
      # Si no coincide (porque está cambiando), detenemos la ejecución silenciosamente.
      titulos_posibles <- census_metadata$titulo[census_metadata$anio == input$anio]
      shiny::req(input$listas %in% titulos_posibles)
      # --------------------------------------

      nombre_en_excel <- census_metadata$archivo_rds[census_metadata$titulo == input$listas]
      shiny::req(length(nombre_en_excel) > 0)

      path_carpeta <- system.file("extdata", as.character(input$anio), package = "arcenso")
      archivos_reales <- list.files(path_carpeta, full.names = TRUE)

      limpiar <- function(x) {
        x <- tolower(x)
        x <- gsub("\\.rds$", "", x)
        x <- chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", x)
        return(x)
      }

      buscado_clean <- limpiar(nombre_en_excel[1])
      reales_clean  <- limpiar(basename(archivos_reales))
      match_idx <- which(reales_clean == buscado_clean)

      if (length(match_idx) > 0) {
        df <- readRDS(archivos_reales[match_idx[1]])

        gt::gt(df) |>
          gt::tab_header(
            title = input$listas
          ) |>
          gt::cols_label_with(
            fn = function(x) {
              x <- gsub("_", " ", x)
              x <- tolower(x)
              substr(x, 1, 1) <- toupper(substr(x, 1, 1))
              return(x)
            }
          ) |>
          gt::fmt_number(
            columns = gt::where(is.numeric),
            decimals = 0,
            sep_mark = ".",
            dec_mark = ","
          ) |>
          gt::opt_interactive(use_compact_mode = TRUE) |>
          gt::tab_options(
            table.width = gt::pct(100),
            heading.align = "left",
            heading.title.font.size = 16,
            column_labels.background.color = "#f0f0f0"
          )

      } else {
        gt::gt(data.frame(Error = "Archivo no encontrado en el paquete"))
      }
    })

    output$fuente_ui <- shiny::renderUI({
      txt <- if(input$anio == 1970) "1970" else "1980"
      shiny::tags$i(paste("Fuente: INDEC, Censo Nacional de Poblaci\u00f3n", txt))
    })
  }

  shiny::shinyApp(ui, server)
}
