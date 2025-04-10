
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **ARcenso** <img src="man/figures/logo.png" align="right" height="138"/>

<!-- badges: start -->

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15192435.svg)](https://doi.org/10.5281/zenodo.15192435)

<!-- badges: end -->

## Overview

This project was supported by the [rOpenSci Champions
Program](https://ropensci.org/blog/2024/02/15/champions-program-champions-2024/)
2023-2024, with [Andrea Gomez Vargas](https://github.com/SoyAndrea) as
the main developer, [Emanuel Ciardullo](https://github.com/ECiardullo)
as co-author and [Luis D. Verde Arregoitia](https://github.com/luisDVA)
as the mentor.

**arcenso** is a package under development that will allow access to the
official data of the national population censuses in Argentina from the
National Institute of Statistics and Census - INDEC. Currently, the
results of the historical censuses of 1970, 1980, 1991, 2001, 2010 and
2022 are available in different formats through physical books, PDFs,
Excel files or in REDATAM, without having a unified system or format
that allows working with the data of these six census periods as a
database. In addition, the presentation of the data is not homogeneous
between the periods, making it difficult to make historical or serial
comparisons of the available information.

This package aims to make census data available, homogenized and ready
to use. It will include the census data from 1970 to 2022. Having a
package of census information will allow the public and private sectors,
citizens and other actors in society to access current and historical
information on Argentina’s population, households and housing in a more
accessible way.

> **The available data will be added to the package in stages as shown
> in the table below by year and geographic disaggregation. Currently,
> the package is in stage 1 of the roadmap.**

## Data Availability Roadmap

| Stage | Census years | Geographic level | Notes |
|----|----|----|----|
| **1** | 1970 | National and 24 jurisdictions | First available census data |
|  | 1980 | National level | Jurisdiction-level data not available |
| 2 | 1991 and 2001 | National level |  |
| 3 | 2010 | National level |  |
| 4 | 2022 | National level |  |
| 5 | 1980 and 1991 | 24 jurisdictions |  |
| 6 | 2001 and 2010 | 24 jurisdictions |  |
| 7 | 2022 | 24 jurisdictions |  |

## Installation

You can install the development version of arcenso from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
# if you do not have remotes installed

remotes::install_github("SoyAndrea/arcenso")
```

## Main functions

**arcenso** provides

- `get_census()`: get a list with the tables currently available in the
  package

- `check_repository()`: reports the tables currently available in the
  package

- `arcenso()`: shinyapp to query the available tables in the package

## Usage

``` r
library(arcenso)

## get a list with the tables currently available in the package

get_census(year = 1970, topic = "CONDICIONES HABITACIONALES", geolvl = "Total del país")
#> $c70_total_del_pais_poblacion_c18
#>                   regimen_de_tenencia hogares personas  cuartos
#> 1                         Propietario 3553250 13778700 11197900
#> 2            Inquilino o arrendatario 1380950  4692800  3305350
#> 3 Ocupante en relación de dependencia  353300  1402500   880050
#> 4                   Ocupante gratuito  575650  2271150  1196500
#> 5                    En otro carácter  192950   816350   419800
#> 
#> $c70_total_del_pais_poblacion_c20
#>     tama?o_hogar                     regimen_tenencia hogares
#> 1   De 1 persona                                Total  615900
#> 2   De 1 persona                          Propietario  255900
#> 3   De 1 persona             Inquilino o arrendatario  199350
#> 4   De 1 persona Ocupante con relación de dependencia   52600
#> 5   De 1 persona                    Ocupante gratuito   82100
#> 6   De 1 persona                                 Otro   25950
#> 7  De 2 personas                                Total 1125250
#> 8  De 2 personas                          Propietario  652950
#> 9  De 2 personas             Inquilino o arrendatario  302400
#> 10 De 2 personas Ocupante con relación de dependencia   49250
#> 11 De 2 personas                    Ocupante gratuito   91300
#> 12 De 2 personas                                 Otro   29350
#> 13 De 3 personas                                Total 1230600
#> 14 De 3 personas                          Propietario  744800
#> 15 De 3 personas             Inquilino o arrendatario  290650
#> 16 De 3 personas Ocupante con relación de dependencia   62150
#> 17 De 3 personas                    Ocupante gratuito  103200
#> 18 De 3 personas                                 Otro   29800
#> 19 De 4 personas                                Total 1255000
#> 20 De 4 personas                          Propietario  787900
#> 21 De 4 personas             Inquilino o arrendatario  266000
#> 22 De 4 personas Ocupante con relación de dependencia   65650
#> 23 De 4 personas                    Ocupante gratuito  102850
#> 24 De 4 personas                                 Otro   32600
#> 25 De 5 personas                                Total  818550
#> 26 De 5 personas                          Propietario  516100
#> 27 De 5 personas             Inquilino o arrendatario  157500
#> 28 De 5 personas Ocupante con relación de dependencia   48200
#> 29 De 5 personas                    Ocupante gratuito   71550
#> 30 De 5 personas                                 Otro   25200
#> 31 De 6 personas                                Total  443250
#> 32 De 6 personas                          Propietario  272000
#> 33 De 6 personas             Inquilino o arrendatario   80000
#> 34 De 6 personas Ocupante con relación de dependencia   29000
#> 35 De 6 personas                    Ocupante gratuito   45750
#> 36 De 6 personas                                 Otro   16500
#> 37 De 7 personas                                Total  276750
#> 38 De 7 personas                          Propietario  163400
#> 39 De 7 personas             Inquilino o arrendatario   44950
#> 40 De 7 personas Ocupante con relación de dependencia   19950
#> 41 De 7 personas                    Ocupante gratuito   35200
#> 42 De 7 personas                                 Otro   13250
#> 43 De 8 personas                                Total  121450
#> 44 De 8 personas                          Propietario   70600
#> 45 De 8 personas             Inquilino o arrendatario   18250
#> 46 De 8 personas Ocupante con relación de dependencia   10050
#> 47 De 8 personas                    Ocupante gratuito   16250
#> 48 De 8 personas                                 Otro    6300
#> 49 De 9 personas                                Total   76000
#> 50 De 9 personas                          Propietario   40950
#> 51 De 9 personas             Inquilino o arrendatario    9400
#> 52 De 9 personas Ocupante con relación de dependencia    7150
#> 53 De 9 personas                    Ocupante gratuito   12900
#> 54 De 9 personas                                 Otro    5600
#> 55   De 10 y más                                Total   93350
#> 56   De 10 y más                          Propietario   48650
#> 57   De 10 y más             Inquilino o arrendatario   12450
#> 58   De 10 y más Ocupante con relación de dependencia    9300
#> 59   De 10 y más                    Ocupante gratuito   14550
#> 60   De 10 y más                                 Otro    8400


##  reports the tables currently available in the package

check_repository(year = 1970, topic = "CONDICIONES HABITACIONALES", geolvl = "Total del país")
#>                            Archivo
#> 1 c70_total_del_pais_poblacion_c18
#> 2 c70_total_del_pais_poblacion_c20
#>                                                                                                      Titulo
#> 1    Cuadro 18. Total del país. Hogares particulares, personas y cuartos, por régimen de tenencia. Año 1970
#> 2 Cuadro 20. Total del país. Hogares particulares, por tamaño del hogar según régimen de tenencia. Año 1970
```
