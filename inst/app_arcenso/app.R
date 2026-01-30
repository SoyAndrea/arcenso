library(shiny)
library(gt)
library(arcenso)

# UI ----------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("ARcenso: Consulta de Datos"),
  sidebarLayout(
    sidebarPanel(
      helpText("Seleccione los filtros para visualizar la tabla."),
      selectInput("anio", "Año censal", choices = c(1970, 1980)),
      selectInput("geo", "Alcance geográfico", choices = NULL),
      selectInput("tema", "Temática", choices = NULL),
      selectInput("listas", "Seleccione tabla", choices = NULL),
      hr(),
      p("Desarrollado con el paquete {arcenso}")
    ),
    mainPanel(
      div(
        style = "text-align: right; margin-bottom: 10px; border-bottom: 1px solid #eee; padding-bottom: 5px;",
        tags$span("ID de Cuadro: ", style = "color: #666; font-size: 0.9em; margin-right: 5px;"),
        tags$code(textOutput("id_view", inline = TRUE),
                  style = "color: #007bff; font-weight: bold; font-size: 1.1em;"
        )
      ),
      gt_output("tablacensal"),
      br(),
      uiOutput("fuente_ui")
    )
  )
)

# SERVER ------------------------------------------------------------------
server <- function(input, output, session) {

  # 1. Filtros dinámicos
  observeEvent(input$anio, {
    req(input$anio)
    freezeReactiveValue(input, "geo")
    freezeReactiveValue(input, "tema")
    freezeReactiveValue(input, "listas")

    # Usamos los datasets que vienen en el paquete
    codigos_existentes <- arcenso::census_metadata$cod_geo[arcenso::census_metadata$anio == input$anio]
    geo_subset <- arcenso::geo_metadata[arcenso::geo_metadata$cod_geo %in% codigos_existentes, ]

    es_total <- geo_subset$cod_geo == "00"
    geo_sorted <- rbind(geo_subset[es_total, ], geo_subset[!es_total, ])
    opciones <- stats::setNames(geo_sorted$cod_geo, geo_sorted$nombre_geo)

    updateSelectInput(session, "geo", choices = opciones)
  })

  observeEvent(input$geo, {
    req(input$anio)
    freezeReactiveValue(input, "tema")
    freezeReactiveValue(input, "listas")

    tema_filtrado <- arcenso::census_metadata$tema[
      arcenso::census_metadata$anio == input$anio & arcenso::census_metadata$cod_geo == input$geo
    ]
    updateSelectInput(session, "tema", choices = sort(unique(tema_filtrado)))
  })

  observeEvent(input$tema, {
    req(input$anio, input$geo)
    freezeReactiveValue(input, "listas")

    listas_filtrado <- arcenso::census_metadata$titulo[
      arcenso::census_metadata$anio == input$anio &
        arcenso::census_metadata$cod_geo == input$geo &
        arcenso::census_metadata$tema == input$tema
    ]
    updateSelectInput(session, "listas", choices = sort(unique(listas_filtrado)))
  })

  # 2. Output ID y Exportación para Tests
  output$id_view <- renderText({
    req(input$listas)

    # Buscamos el ID
    id <- arcenso::census_metadata$id_cuadro[arcenso::census_metadata$titulo == input$listas]
    res_id <- if (length(id) > 0) id[1] else "-"

    # ESTO ES CLAVE PARA SHINYTEST2: Permite leer valores internos
    exportTestValues(id_view_test = res_id)

    return(res_id)
  })

  # 3. Render Tabla
  output$tablacensal <- render_gt({
    req(input$listas)

    titulos_posibles <- arcenso::census_metadata$titulo[arcenso::census_metadata$anio == input$anio]
    req(input$listas %in% titulos_posibles)

    nombre_en_excel <- arcenso::census_metadata$archivo_rds[arcenso::census_metadata$titulo == input$listas]
    req(length(nombre_en_excel) > 0)

    # Buscamos los archivos RDS en el sistema de archivos del paquete instalado
    path_carpeta <- system.file("extdata", as.character(input$anio), package = "arcenso")
    archivos_reales <- list.files(path_carpeta, full.names = TRUE)

    limpiar <- function(x) {
      x <- tolower(x)
      x <- gsub("\\.rds$", "", x)
      x <- chartr("áéíóúñ", "aeioun", x)
      return(x)
    }

    buscado_clean <- limpiar(nombre_en_excel[1])
    reales_clean <- limpiar(basename(archivos_reales))
    match_idx <- which(reales_clean == buscado_clean)

    if (length(match_idx) > 0) {
      df <- readRDS(archivos_reales[match_idx[1]])

      gt(df) |>
        tab_header(title = input$listas) |>
        fmt_number(columns = where(is.numeric), decimals = 0, sep_mark = ".", dec_mark = ",") |>
        opt_interactive(use_compact_mode = TRUE)
    } else {
      gt(data.frame(Error = "Archivo no encontrado"))
    }
  })

  output$fuente_ui <- renderUI({
    txt <- if (input$anio == 1970) "1970" else "1980"
    tags$i(paste("Fuente: INDEC, Censo Nacional de Población", txt))
  })
}

# Lanzar la app
shinyApp(ui, server)
