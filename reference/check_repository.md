# Check available census tables

Reports the census tables currently available in the package for
consultation based on the provided filters.

## Usage

``` r
check_repository(year = 1970, topic = NULL, geolvl = NULL)
```

## Arguments

- year:

  Census year (1970 or 1980). Default is 1970.

- topic:

  Census topic of the tables (e.g., "EDUCACION"). If NULL, all available
  topics for the selected year will be shown.

- geolvl:

  Geographic disaggregation level (e.g., "Total del país"). If NULL, all
  jurisdictions will be included.

## Value

A data frame containing the table titles and the internal names required
to access them via the get_census function.

## Examples

``` r
check_repository(year = 1970, topic = "EDUCACION", geolvl = "Total del país")
#>                           Archivo
#> 1 c70_total_del_pais_poblacion_c7
#> 2 c70_total_del_pais_poblacion_c8
#> 3 c70_total_del_pais_poblacion_c9
#>                                                                                                                     Titulo
#> 1 Cuadro 7. Total del país. Población de 10 y más años, por grupo de edad, según condición de alfabetismo y sexo. Año 1970
#> 2         Cuadro 8. Total del país. Población de 5 y más años, por sexo y grupo de edad según asistencia escolar. Año 1970
#> 3      Cuadro 9. Total del país. Población de 5 y más años, por sexo, y grupo de edad según nivel de instrucción. Año 1970
```
