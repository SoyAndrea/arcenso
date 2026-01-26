# Get census data tables

Retrieves a list of curated data tables from Argentina's official
population censuses based on the specified filters.

## Usage

``` r
get_census(year = 1970, id = NULL, topic = NULL, geo_code = NULL)
```

## Arguments

- year:

  Integer. Census year (1970 or 1980). Default is 1970.

- id:

  Character vector. Specific Table IDs to retrieve (e.g.,
  "1970_00_estructura_01"). If specified, this takes precedence over
  topic filters.

- topic:

  Character vector. Keywords to filter topics (e.g., "migracion",
  c("vivienda", "material")). Matches are case-insensitive.

- geo_code:

  Character. Geographic code (e.g., "02" for CABA).

## Value

A list of data frames containing the requested census tables.

## Examples

``` r
# 1. Retrieve a specific table by its ID
  # Note: 'year' is still required to locate the file in the correct folder
  my_table <- get_census(year = 1970, id = "1970_00_estructura_01")

  # 2. Retrieve tables by topic (e.g., all tables about 'vivienda')
  housing_data <- get_census(year = 1970, topic = "vivienda")
#> Warning: No se encontraron tablas con los filtros especificados.

  # 3. Retrieve tables for multiple topics (OR logic)
  # Gets tables related to 'vivienda' OR 'hogar'
  mix_data <- get_census(year = 1970, topic = c("vivienda", "hogar"))
#> Warning: No se encontraron tablas con los filtros especificados.
```
