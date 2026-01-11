test_that("arcenso_gui genera una aplicacion de shiny", {
  # Si la funcion falla por error de sintaxis o falta de paquetes,
  # el test fallara aqui.
  app <- arcenso_gui()

  # Verificamos que sea un objeto de aplicacion Shiny
  expect_s3_class(app, "shiny.appobj")
})
