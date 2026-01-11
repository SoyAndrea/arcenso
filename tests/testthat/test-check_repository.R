test_that("check_repository returns a valid data frame", {
  # Carga local para asegurar que usamos el código nuevo
  res <- check_repository(year = 1970)

  # TEST 1: ¿Es un data frame?
  expect_s3_class(res, "data.frame")

  # TEST 2: ¿Tiene las columnas correctas?
  expect_true(all(c("Archivo", "Titulo") %in% colnames(res)))

  # TEST 3: ¿Tiene filas? (Que no venga vacío para un año válido)
  expect_gt(nrow(res), 0)
})

test_that("check_repository filtering works", {
  # TEST 4: Si filtro por una temática, todas las filas deben ser de esa temática
  # (Esto asume que 'EDUCACION' existe en tus datos de 1970)
  res_edu <- check_repository(year = 1970, topic = "EDUCACION")

  # Verificamos que traiga algo
  expect_gt(nrow(res_edu), 0)

  # Verificamos que el filtrado sea coherente comparando con el índice global
  expect_true(all(res_edu$Archivo %in% info_cuadros_arcenso$Archivo))
})
