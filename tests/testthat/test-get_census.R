test_that("get_census funciona con inputs básicos (ID válido)", {
  # Usamos un ID que sabemos que existe en tu metadata (basado en lo que vimos hoy)
  # Si este ID cambia en el futuro, habrá que actualizar el test.
  id_prueba <- "1970_00_estructura_01"

  res <- get_census(year = 1970, id = id_prueba)

  # 1. Debe devolver una lista
  expect_type(res, "list")

  # 2. Debe tener longitud 1 (porque pedimos 1 solo ID)
  expect_length(res, 1)

  # 3. El contenido debe ser un data.frame
  expect_true(is.data.frame(res[[1]]))

  # 4. El nombre del elemento en la lista debe ser el ID
  expect_equal(names(res), id_prueba)
})

test_that("get_census valida el año correctamente", {
  # Año inválido debe dar error (stop)
  expect_error(get_census(year = 2025), "no es un an\u00f1o censal disponible")
  expect_error(get_census(year = 1810), "no es un an\u00f1o censal disponible")
})

test_that("get_census devuelve warning y lista vacía si no encuentra nada", {
  # Caso: Tema inventado
  expect_warning(
    res <- get_census(year = 1970, topic = "tema_imposible_xyz_123"),
    "No se encontraron tablas"
  )

  # Debe devolver lista vacía
  expect_length(res, 0)
  expect_type(res, "list")
})

test_that("get_census ignora mayúsculas/minúsculas en el Topic", {
  # Asumimos que 'vivienda' o 'poblacion' existen en tu metadata
  # Si 'vivienda' devuelve datos, 'VIVIENDA' también debería.

  # Nota: Este test solo pasa si 'vivienda' existe realmente en tus datos de prueba.
  # Si no, cámbialo por un tema que sepas seguro que está.
  tema_prueba <- "vivienda" # O el tema más común que tengas

  suppressWarnings({
    res_lower <- get_census(year = 1970, topic = tolower(tema_prueba))
    res_upper <- get_census(year = 1970, topic = toupper(tema_prueba))
  })

  # Si ambos devuelven algo, deberían devolver la misma cantidad de tablas
  expect_equal(length(res_lower), length(res_upper))
})
