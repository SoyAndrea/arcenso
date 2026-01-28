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

  my_table
#> $`1970_00_estructura_01`
#> # A tibble: 54 × 3
#>    grupo_de_edad sexo    poblacion
#>    <chr>         <chr>   <chr>    
#>  1 0-4           Total   2355300  
#>  2 0-4           Varones 1196950  
#>  3 0-4           Mujeres 1158350  
#>  4 5-9           Total   2297000  
#>  5 5-9           Varones 1163050  
#>  6 5-9           Mujeres 1133950  
#>  7 10-14         Total   2201150  
#>  8 10-14         Varones 1114300  
#>  9 10-14         Mujeres 1086850  
#> 10 15-19         Total   2098700  
#> # ℹ 44 more rows
#> 

  # 2. Retrieve tables by topic (e.g., all tables about 'habitacional')

  housing_data <- get_census(year = 1970, topic = "habitacional")

  # Explore the list and extract the first table
  housing_data[[1]]
#> # A tibble: 5 × 4
#>   regimen_de_tenencia                 hogares personas cuartos 
#>   <chr>                               <chr>   <chr>    <chr>   
#> 1 Propietario                         3553250 13778700 11197900
#> 2 Inquilino o arrendatario            1380950 4692800  3305350 
#> 3 Ocupante en relación de dependencia 353300  1402500  880050  
#> 4 Ocupante gratuito                   575650  2271150  1196500 
#> 5 En otro carácter                    192950  816350   419800  
```
