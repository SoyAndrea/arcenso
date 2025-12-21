# check_repository reports the tables currently available in the package

check_repository reports the tables currently available in the package

## Usage

``` r
check_repository(year = 1970, topic = NULL, geolvl = NULL)
```

## Arguments

- year:

  census year for which the user wants to view the currently available
  tabulations. The default is “1970”.

- topic:

  census topic of the tables available: ESTRUCTURA DE POBLACION,
  CONDICION DE ACTIVIDAD, FECUNDIDAD, CONDICIONES HABITACIONALES,
  COMPOSICIÓN DE LO HOGARES, MIGRACIÓN, SITUACIÓN CONYUGAL y EDUCACION.
  Setting the parameter to NULL will download all available tables.

- geolvl:

  geographic disaggregation level, use “Total del país” for the overall
  results. Setting the parameter to NULL will download all available
  tables.

## Value

Returns a data frame with the title of the tables that can be acces with
the get_census function and the name given by that function to each
table

## Examples

``` r
check_repository( year = 1970, topic = "EDUCACION", geolvl = "Total del país")
#>                           Archivo
#> 1 c70_total_del_pais_poblacion_c7
#> 2 c70_total_del_pais_poblacion_c8
#> 3 c70_total_del_pais_poblacion_c9
#>                                                                                                                     Titulo
#> 1 Cuadro 7. Total del país. Población de 10 y más años, por grupo de edad, según condición de alfabetismo y sexo. Año 1970
#> 2         Cuadro 8. Total del país. Población de 5 y más años, por sexo y grupo de edad según asistencia escolar. Año 1970
#> 3      Cuadro 9. Total del país. Población de 5 y más años, por sexo, y grupo de edad según nivel de instrucción. Año 1970
```
