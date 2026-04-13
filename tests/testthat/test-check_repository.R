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

test_that("check_repository rechaza un año no disponible", {
  expect_error(
    check_repository(year = 1900),
    "El año 1900 no está disponible"
  )
})

test_that("check_repository rechaza un geo_code inexistente", {
  expect_error(
    check_repository(geo_code = "99"),
    "El código '99' no existe"
  )
})

test_that("check_repository rechaza topic inválido dentro de un año válido", {
  expect_error(
    check_repository(year = 1970, topic = "tema_inventado_xyz"),
    "El tema 'tema_inventado_xyz' no es válido"
  )
})

test_that("check_repository devuelve invisible(NULL) cuando la combinación de filtros no tiene resultados", {
  meta_1970 <- census_metadata[census_metadata$anio == 1970, c("tema", "cod_geo")]
  meta_1970 <- unique(meta_1970)

  combinaciones <- expand.grid(
    tema = unique(meta_1970$tema),
    cod_geo = unique(meta_1970$cod_geo),
    stringsAsFactors = FALSE
  )

  claves_existentes <- paste(meta_1970$tema, meta_1970$cod_geo, sep = "___")
  claves_todas <- paste(combinaciones$tema, combinaciones$cod_geo, sep = "___")

  idx_faltante <- which(!claves_todas %in% claves_existentes)[1]

  expect_false(is.na(idx_faltante))

  tema_sin_match <- combinaciones$tema[idx_faltante]
  geo_sin_match <- combinaciones$cod_geo[idx_faltante]

  expect_message(
    res <- check_repository(
      year = 1970,
      topic = tema_sin_match,
      geo_code = geo_sin_match
    ),
    "No se encontraron cuadros con esa combinación de filtros"
  )

  expect_null(res)
})
