# Geographic Metadata (Geographic Dictionary)

Reference table to translate INDEC geographic codes into province names
and regions, including ISO 3166-2 codes for mapping.

## Usage

``` r
geo_metadata
```

## Format

A tibble with the following columns:

- cod_geo:

  INDEC code (character, two digits).

- nombre_geo:

  Official province name (Ordered factor).

- nombre_corto:

  Short name, ideal for plots.

- iso_3166_2:

  International standard code (e.g., "AR-C") for map joining.

## Source

INDEC and ISO 3166-2 standardization.
