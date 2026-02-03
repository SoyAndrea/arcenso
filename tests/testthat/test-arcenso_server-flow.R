test_that("arcenso_server flujo completo básico", {

  server_fun <- arcenso_server(
    census_metadata = census_metadata,
    geo_metadata = geo_metadata
  )

  suppressWarnings(
    shiny::testServer(server_fun, {

      # 1) Año
      session$setInputs(anio = 1970)
      session$flushReact()

      geo_ok <- unique(
        census_metadata$cod_geo[census_metadata$anio == 1970]
      )[1]

      # 2) Geo
      session$setInputs(geo = geo_ok)
      session$flushReact()

      tema_ok <- unique(
        census_metadata$tema[
          census_metadata$anio == 1970 &
            census_metadata$cod_geo == geo_ok
        ]
      )[1]

      # 3) Tema
      session$setInputs(tema = tema_ok)
      session$flushReact()

      titulo_ok <- unique(
        census_metadata$titulo[
          census_metadata$anio == 1970 &
            census_metadata$cod_geo == geo_ok &
            census_metadata$tema == tema_ok
        ]
      )[1]

      # 4) Tabla
      session$setInputs(listas = titulo_ok)
      session$flushReact()

      # Outputs: id
      expect_true(nzchar(output$id_view))

      # Outputs: fuente
      expect_false(is.null(output$fuente_ui))
      fuente_txt <- paste(as.character(output$fuente_ui), collapse = " ")
      expect_match(fuente_txt, "INDEC")

    })
  )
})
