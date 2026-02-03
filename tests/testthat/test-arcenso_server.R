test_that("arcenso_server arranca sin errores", {
  server <- arcenso_server(census_metadata, geo_metadata)

  shiny::testServer(server, {
    expect_true(TRUE)
  })
})

