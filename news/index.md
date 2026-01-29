# Changelog

## arcenso 0.2.1

- Added `CITATION.cff` file to provide standardized citation metadata.
- Improved metadata generation (`codemeta.json`).

## arcenso 0.2.0

### New documentation

- Added a “Get Started” vignette with examples using both Base R and
  tidyverse-style workflows.
- Made internal datasets `geo_metadata` and `census_metadata` available
  for user inspection.
- Updated the README with expanded usage examples and a project roadmap.

### Breaking changes

- Renamed the Shiny application launcher from `arcenso()` to
  [`arcenso_gui()`](https://soyandrea.github.io/arcenso/reference/arcenso_gui.md)
  to improve clarity and avoid naming conflicts.

### Improvements

- Reduced package dependencies by removing `dplyr` and `magrittr`; core
  functionality now relies on Base R.
- Adopted the native pipe operator `|>` (requires R \>= 4.1.0).
- Improved Shiny app stability by fixing synchronization issues when
  switching census years.
- Enhanced documentation for
  [`check_repository()`](https://soyandrea.github.io/arcenso/reference/check_repository.md)
  and
  [`get_census()`](https://soyandrea.github.io/arcenso/reference/get_census.md)
  with clearer examples.

### Bug fixes and maintenance

- Fixed non-ASCII character issues in documentation and metadata.
- Updated package metadata, including author ORCID identifiers in
  `DESCRIPTION`.

## arcenso 0.1.0

First public release of the **arcenso** package.

This is the initial official release of *arcenso*, an R package designed
to organize and provide access to tidy datasets based on Argentina’s
**official population censuses**.

### Includes

- Tidy official census data for:
  - **1970**: national level and all 24 jurisdictions.
  - **1980**: national level only.
- Three core functions:
  - [`get_census()`](https://soyandrea.github.io/arcenso/reference/get_census.md)
    – access available census datasets.
  - [`check_repository()`](https://soyandrea.github.io/arcenso/reference/check_repository.md)
    – list all available data sources.
  - `arcenso()` – a Shiny app to explore the data interactively (renamed
    to
    [`arcenso_gui()`](https://soyandrea.github.io/arcenso/reference/arcenso_gui.md)
    in version 0.2.0).
- Online documentation site: <https://soyandrea.github.io/arcenso>

This version establishes a stable foundation for further development.
