# get_census get a list with the tables currently available in the package

get_census get a list with the tables currently available in the package

## Usage

``` r
get_census(year = 1970, topic = NULL, geolvl = NULL)
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

Returns a list with the tables that meet the parameters. To check the
tables currently available use the check_repository function

## Examples

``` r
get_census( year = 1970, topic = "EDUCACION", geolvl = "Total del país")
#> list()
```
