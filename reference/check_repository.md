# Check available census tables

Explores the catalog of census tables available in the package. This
function helps identify the correct `id_cuadro` required to download
data using
[`get_census`](https://soyandrea.github.io/arcenso/reference/get_census.md).

## Usage

``` r
check_repository(year = NULL, topic = NULL, geo_code = NULL)
```

## Arguments

- year:

  Integer. The census year (e.g., 1970, 1980).

- topic:

  Character. The specific topic of the table (e.g., "educacion",
  "vivienda"). To see the list of available topics, run:
  `unique(census_metadata$tema)`.

- geo_code:

  Character. The INDEC geographic code (e.g., "02" for CABA). To see the
  full list of codes and names, inspect: `View(geo_metadata)`.

## Value

A data frame containing the `id_cuadro`, title, and relevant context
columns.

## Details

The output columns are dynamically adjusted based on the filters applied
to avoid redundant information.

## See also

[`get_census`](https://soyandrea.github.io/arcenso/reference/get_census.md)
to download the data found here.

## Examples

``` r
# Check all tables available for the 1970 census
check_repository(year = 1970)
#> # A tibble: 332 × 3
#>    id_cuadro             cod_geo titulo                                         
#>    <chr>                 <chr>   <chr>                                          
#>  1 1970_00_estructura_01 00      Cuadro 1. Total del país. Población total, por…
#>  2 1970_00_fecundidad_01 00      Cuadro 17. Total del país. Población femenina …
#>  3 1970_00_educacion_01  00      Cuadro 7. Total del país. Población de 10 y má…
#>  4 1970_00_educacion_02  00      Cuadro 8. Total del país. Población de 5 y más…
#>  5 1970_00_educacion_03  00      Cuadro 9. Total del país. Población de 5 y más…
#>  6 1970_00_conyugal_01   00      Cuadro 3. Total del país. Población de 12 y má…
#>  7 1970_00_actividad_01  00      Cuadro 11. Total del país. Población de 10 y m…
#>  8 1970_00_actividad_02  00      Cuadro 12. Total del país. Población económica…
#>  9 1970_00_actividad_03  00      Cuadro 14. Total del pais. Población económica…
#> 10 1970_00_actividad_04  00      Cuadro 15. Total del país. Población económica…
#> # ℹ 322 more rows

# Search for a specific topic in a specific jurisdiction (CABA)
# Note: Topics are in Spanish as they appear in the original source
check_repository(topic = "educacion", geo_code = "02")
#> # A tibble: 3 × 3
#>   id_cuadro             anio titulo                                             
#>   <chr>                <dbl> <chr>                                              
#> 1 1970_02_educacion_01  1970 Cuadro 3. Capital Federal. Población de 10 y más a…
#> 2 1970_02_educacion_02  1970 Cuadro 4. Capital Federal. Población de 5 y más añ…
#> 3 1970_02_educacion_03  1970 Cuadro 5. Capital Federal. Población de 5 y más añ…
```
