# Get census data tables

Retrieves curated data tables from Argentina's official population
censuses based on table ID or filtering criteria.

## Usage

``` r
get_census(year = NULL, id = NULL, topic = NULL, geo_code = NULL)
```

## Arguments

- year:

  Integer. Census year. Valid census years are 1970, 1980, 1991, 2001,
  2010, and 2022. Currently, only 1970 and 1980 are available in this
  package. Used only when `id` is `NULL`.

- id:

  Character vector. Specific table IDs to retrieve (e.g.,
  `"1970_00_estructura_01"`). If supplied, this takes precedence over
  `year`, `topic`, and `geo_code`.

- topic:

  Character vector. Keywords to filter topics (e.g., `"migracion"`,
  `c("vivienda", "material")`). Matching is case-insensitive and
  accent-insensitive.

- geo_code:

  Character vector. Geographic code(s) (e.g., `"02"` for CABA).

## Value

If one table is found, a data frame. If multiple tables are found, a
named list of data frames. If no matches are found, returns `NULL`.

## Examples

``` r
# 1. Retrieve a specific table by ID
educacion <- get_census(id = "1970_00_educacion_01")
head(educacion)
#> # A tibble: 6 × 4
#>   sexo  grupo_de_edad alfabetismo poblacion
#>   <chr> <chr>         <chr>       <chr>    
#> 1 Total 10-14         Total       2201150  
#> 2 Total 10-14         Alfabetos   2100600  
#> 3 Total 10-14         Analfabetos 100550   
#> 4 Total 15-19         Total       2098700  
#> 5 Total 15-19         Alfabetos   2012900  
#> 6 Total 15-19         Analfabetos 85800    


# 2. Retrieve tables by topic (may return multiple tables)
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


# 3. Retrieve a single table using filters (returns a data frame)
poblacion_total <- get_census(
  year = 1970,
  topic = "estructura",
  geo_code = "00"
)
head(poblacion_total)
#> # A tibble: 6 × 3
#>   grupo_de_edad sexo    poblacion
#>   <chr>         <chr>   <chr>    
#> 1 0-4           Total   2355300  
#> 2 0-4           Varones 1196950  
#> 3 0-4           Mujeres 1158350  
#> 4 5-9           Total   2297000  
#> 5 5-9           Varones 1163050  
#> 6 5-9           Mujeres 1133950  
```
