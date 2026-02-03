library(shiny)
library(gt)

data("census_metadata", package = "arcenso")
data("geo_metadata", package = "arcenso")

server <- arcenso_server(
  census_metadata = census_metadata,
  geo_metadata = geo_metadata
)
