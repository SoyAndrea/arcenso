# Census Metadata (Table Catalog)

A dataframe containing the inventory of all available census tables,
including year, topic, geographic level, and the unique ID required for
downloading.

## Usage

``` r
census_metadata
```

## Format

A tibble with the following columns:

- id_cuadro:

  Unique identifier (e.g., "1970_02_educacion_01"). Use this ID in
  [`get_census()`](https://soyandrea.github.io/arcenso/reference/get_census.md).

- anio:

  Census year (e.g., 1970, 1980, 1991, 2001, 2010).

- unidad:

  Unit of analysis (e.g., Población, Hogares, Viviendas).

- tema:

  Main topic (e.g., educacion, vivienda, actividad).

- cod_geo:

  INDEC geographic code (e.g., "02", "06").

- archivo:

  Internal physical file name.

- titulo:

  Descriptive title of the table.

## Source

Own elaboration based on INDEC data.
