test_that("get_census devuelve un data frame para un ID válido", {
  id_prueba <- "1970_00_estructura_01"

  res <- get_census(id = id_prueba)

  expect_s3_class(res, "data.frame")
})

test_that("get_census devuelve una lista nombrada para múltiples IDs válidos", {
  ids_prueba <- c("1970_00_estructura_01", "1980_00_estructura_03")

  res <- get_census(id = ids_prueba)

  expect_type(res, "list")
  expect_length(res, 2)
  expect_equal(names(res), ids_prueba)
  expect_true(all(vapply(res, is.data.frame, logical(1))))
})

test_that("get_census funciona con ID sin especificar year", {
  id_prueba <- "1980_00_estructura_03"

  res <- get_census(id = id_prueba)

  expect_s3_class(res, "data.frame")
})

test_that("get_census requiere id o year", {
  expect_error(
    get_census(),
    "Debes indicar `id` o `year`"
  )
})

test_that("get_census rechaza años no censales", {
  expect_error(
    get_census(year = 2025),
    "no es un año censal válido"
  )

  expect_error(
    get_census(year = 1810),
    "no es un año censal válido"
  )
})

test_that("get_census rechaza años censales aún no disponibles", {
  expect_error(
    get_census(year = 1991),
    "aún no está disponible en este paquete"
  )

  expect_error(
    get_census(year = 2001),
    "aún no está disponible en este paquete"
  )

  expect_error(
    get_census(year = 2010),
    "aún no está disponible en este paquete"
  )

  expect_error(
    get_census(year = 2022),
    "aún no está disponible en este paquete"
  )
})

test_that("get_census devuelve NULL con warning cuando no encuentra tablas", {
  expect_warning(
    res <- get_census(year = 1970, topic = "tema_imposible_xyz_123"),
    "No se encontraron tablas"
  )

  expect_null(res)
})

test_that("get_census ignora mayúsculas y minúsculas en el filtro topic", {
  topic_prueba <- "vivienda"

  suppressWarnings({
    res_lower <- get_census(year = 1970, topic = tolower(topic_prueba))
    res_upper <- get_census(year = 1970, topic = toupper(topic_prueba))
  })

  expect_identical(is.null(res_lower), is.null(res_upper))

  if (!is.null(res_lower) && !is.null(res_upper)) {
    if (is.list(res_lower) && is.list(res_upper)) {
      expect_equal(length(res_lower), length(res_upper))
      expect_equal(names(res_lower), names(res_upper))
    } else {
      expect_s3_class(res_lower, "data.frame")
      expect_s3_class(res_upper, "data.frame")
      expect_equal(names(res_lower), names(res_upper))
    }
  }
})
