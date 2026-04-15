test_that("check_repository filters and adjusts columns dynamically", {
  # 1. Test: Filtro por año (Validamos que NO incluya la columna 'anio')
  # Usamos un año que sabemos que existe (ej: 1970)
  res_1970 <- check_repository(year = 1970)
  expect_s3_class(res_1970, "data.frame")
  expect_false("anio" %in% colnames(res_1970)) # Selección dinámica
  expect_true("id_cuadro" %in% colnames(res_1970))

  # 2. Test: Filtro por tema (Validamos que falle con un tema inexistente)
  # Tu función usa stop(), así que testeamos el error
  expect_error(check_repository(topic = "inexistente"), "El tema 'inexistente' no es v\u00e1lido")

  # 3. Test: Sin filtros (Debe incluir 'anio' y 'cod_geo')
  res_all <- check_repository()
  expect_true(all(c("anio", "cod_geo", "id_cuadro", "titulo") %in% colnames(res_all)))

  # 4. Test: Filtro por GEO
  # Verificamos que el código de CABA (02) funcione y oculte la columna cod_geo
  res_geo <- check_repository(geo_code = "02")
  expect_gt(nrow(res_geo), 0)
  expect_false("cod_geo" %in% colnames(res_geo))
})
