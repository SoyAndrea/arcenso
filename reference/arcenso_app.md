# Launch ARcenso Shiny application

Launches a Shiny application to interactively browse and consult
Argentina's historical census data.

## Usage

``` r
arcenso_app()
```

## Value

Launches the Shiny application (invisibly returns the result of
[`shiny::runApp()`](https://rdrr.io/pkg/shiny/man/runApp.html)).

## Examples

``` r
if (interactive()) {
  arcenso_app()
}
```
