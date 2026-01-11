test_that("get_census returns data for valid parameters", {
  # 1. Probar que devuelve una lista
  res <- get_census(year = 1970, topic = "CONDICIONES HABITACIONALES")
  expect_type(res, "list")

  # 2. Probar que NO está vacía (esto es lo que fallaba en el README)
  expect_gt(length(res), 0)

  # 3. Probar que el contenido es un data.frame
  expect_s3_class(res[[1]], "data.frame")
})

test_that("get_census fails gracefully with invalid years", {
  # 4. Probar que el stop() funciona si el año es incorrecto
  expect_error(get_census(year = 2024))
})

test_that("get_census filter logic works", {
  # 5. Probar que si pido una temática específica, los resultados coinciden
  res <- get_census(year = 1970, topic = "CONDICIONES HABITACIONALES")

  # Verificamos que los nombres de la lista (nombres de archivos)
  # existen en el índice para ese tema
  archivo_nombre <- names(res)[1]
  expect_true(archivo_nombre %in% info_cuadros_arcenso$Archivo)
})
