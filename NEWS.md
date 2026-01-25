# arcenso 0.2.0

🚀 **Major Refactoring & Performance Update**

This version introduces significant changes to the package structure, reducing dependencies and improving stability.

## Breaking Changes

* **Renamed Function:** The Shiny application launcher `arcenso()` has been renamed to **`arcenso_gui()`** to avoid conflicts and improve clarity.

## Internal Improvements

* **Dependency Diet:** Removed `dplyr` and `magrittr` dependencies. The package now runs on **Base R** and `utils`, making it lighter and faster to install.
* **Modern R:** Adopted the native pipe `|>` (requires R >= 4.1.0).
* **Shiny Stability:** Fixed race conditions in `arcenso_gui()` where changing years caused synchronization errors in the filters. Added `freezeReactiveValue` for smoother UI transitions.
* **Clean Checks:** Achieved 0 errors, 0 warnings, and 0 notes in `R CMD check`.

## Documentation

* **Dictionaries:** Exposed `geo_metadata` and `census_metadata` datasets for user reference.
* **Updated README:** Improved roadmap, usage examples, and acknowledgment section.
* **Function Docs:** Added clearer examples for `check_repository()` and `get_census()`.

---

# arcenso 0.1.0

🎉 First public release of the **arcenso** package

This is the initial official release of *arcenso*, an R package designed to organize and provide access to tidy datasets based on Argentina’s **official population censuses**.

## Includes

- Tidy official census data for:
  - **1970**: national level and all 24 jurisdictions.
  - **1980**: national level only.
- Three core functions:
  - `get_census()` – to access available datasets.
  - `check_repository()` – to list all available sources.
  - `arcenso()` – a Shiny app to explore the data interactively.
- Online documentation site:[https://soyandrea.github.io/arcenso](https://soyandrea.github.io/arcenso)

This version establishes a stable foundation for further development. No changes from previous versions, as this is the first official release.
