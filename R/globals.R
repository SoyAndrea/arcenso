# Este archivo es necesario para que R CMD check no se queje de las
# columnas de los dataframes o del pipe de magrittr.

utils::globalVariables(c(
  "anio",
  "Jurisdiccion",
  "tema",
  "Titulo",
  "Archivo",
  "info_cuadros_arcenso",
  ".",
  "V_ASEGURABLES" # Agrega aquí cualquier otra columna que uses en dplyr
))
