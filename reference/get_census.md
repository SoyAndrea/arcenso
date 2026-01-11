# Get census data tables

Retrieves a list of curated data tables from Argentina's official
population censuses based on the specified filters.

## Usage

``` r
get_census(year = 1970, topic = NULL, geolvl = NULL)
```

## Arguments

- year:

  Census year (1970 or 1980). Default is 1970.

- topic:

  Census topic of the tables (e.g., "EDUCACION"). If NULL, all available
  topics for the year will be retrieved.

- geolvl:

  Geographic disaggregation level (e.g., "Total del país"). If NULL, all
  jurisdictions will be retrieved.

## Value

A list of data frames containing the requested census tables.
