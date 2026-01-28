test_that("La lógica de filtros de arcenso funciona", {
  anio_test <- 1970
  lista_test <- census_metadata$titulo[census_metadata$anio == anio_test][1]
  id <- census_metadata$id_cuadro[census_metadata$titulo == lista_test &
    census_metadata$anio == anio_test]

  expect_true(length(id) > 0)
  expect_false(is.na(id[1]))
  print(paste("ID encontrado:", id[1]))
})


test_that("Flujo de metadatos y limpieza de nombres", {
  for (anio in c(1970, 1980)) {
    expect_true(any(arcenso::census_metadata$anio == anio))
  }

  nombre_rds <- "Poblaci\u00f3n_Censo.rds"
  limpio <- tolower(gsub("\\.rds$", "", nombre_rds))
  limpio <- chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00f1", "aeioun", limpio)

  expect_equal(limpio, "poblacion_censo")
})
