library(shiny)
library(gt)

data("census_metadata", package = "arcenso")
data("geo_metadata", package = "arcenso")

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
