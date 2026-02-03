#' @importFrom shiny observeEvent req freezeReactiveValue updateSelectInput
#' @importFrom shiny renderText renderUI tags
#' @importFrom gt gt tab_header fmt_number opt_interactive
#' @importFrom tidyselect where

# SERVER ------------------------------------------------------------------
arcenso_server <- function(census_metadata, geo_metadata) {

    function(input, output, session) {

  observeEvent(input$anio, {
    req(input$anio)
    freezeReactiveValue(input, "geo")
    freezeReactiveValue(input, "tema")
    freezeReactiveValue(input, "listas")


    codigos_existentes <- census_metadata$cod_geo[census_metadata$anio == input$anio]
    geo_subset <- geo_metadata[geo_metadata$cod_geo %in% codigos_existentes, ]

    es_total <- geo_subset$cod_geo == "00"
    geo_sorted <- rbind(geo_subset[es_total, ], geo_subset[!es_total, ])
    opciones <- stats::setNames(geo_sorted$cod_geo, geo_sorted$nombre_geo)

    updateSelectInput(session, "geo", choices = opciones)
  })

  observeEvent(input$geo, {
    req(input$anio)
    freezeReactiveValue(input, "tema")
    freezeReactiveValue(input, "listas")

    tema_filtrado <- census_metadata$tema[
      census_metadata$anio == input$anio & census_metadata$cod_geo == input$geo
    ]
    updateSelectInput(session, "tema", choices = sort(unique(tema_filtrado)))
  })

  observeEvent(input$tema, {
    req(input$anio, input$geo)
    freezeReactiveValue(input, "listas")

    listas_filtrado <- census_metadata$titulo[
      census_metadata$anio == input$anio &
        census_metadata$cod_geo == input$geo &
        census_metadata$tema == input$tema
    ]
    updateSelectInput(session, "listas", choices = sort(unique(listas_filtrado)))
  })


  output$id_view <- renderText({
    req(input$listas)

    id <- census_metadata$id_cuadro[census_metadata$titulo == input$listas]
    res_id <- if (length(id) > 0) id[1] else "-"

    res_id

  })

  output$tablacensal <- render_gt({
    req(input$listas)

    titulos_posibles <- census_metadata$titulo[census_metadata$anio == input$anio]
    req(input$listas %in% titulos_posibles)

    nombre_en_excel <- census_metadata$archivo_rds[census_metadata$titulo == input$listas]
    req(length(nombre_en_excel) > 0)

    # Buscamos los archivos RDS en el sistema de archivos del paquete instalado
    path_carpeta <- system.file("extdata", as.character(input$anio), package = "arcenso")
    archivos_reales <- list.files(path_carpeta, full.names = TRUE)

    limpiar <- function(x) {
      x <- tolower(x)
      x <- gsub("\\.rds$", "", x)
      x <- chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", x)
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
    tags$i(paste("Fuente: INDEC, Censo Nacional de Poblaci\u00f3n", txt))
  })
    }
}
