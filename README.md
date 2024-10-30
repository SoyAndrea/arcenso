
<!-- README.md is generated from README.Rmd. Please edit that file -->

# **ARcenso** <img src="man/figures/logo.png" align="right" height="138"/>

<!-- badges: start -->
<!-- badges: end -->

## Overview

This project was supported by the [rOpenSci Champions
Program](https://ropensci.org/blog/2024/02/15/champions-program-champions-2024/)
2023-2024, with [Andrea Gomez Vargas](https://github.com/SoyAndrea) as
the main developer and [Luis D. Verde
Arregoitia](https://github.com/luisDVA) as the mentor.

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

## Installation

You can install the development version of arcenso from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("SoyAndrea/arcenso")
```

## Main functions

**arcenso** provides

- `get_census()`: get a list with the tables currently available in the
  package

- `check_repository()`: reports the tables currently available in the
  package

## Usage

``` r
library(arcenso)

## get a list with the tables currently available in the package

get_census( year = 1970, topic = "FECUNDIDAD", geolvl = "Total del país")
#> $c70_total_del_pais_poblacion_c17
#>           grupo_edad hijos_nacidos_vivos mujeres
#> 1   Menos de 15 años               Total  647350
#> 2   Menos de 15 años                   0  643550
#> 3   Menos de 15 años                   1    2300
#> 4   Menos de 15 años                   2    1400
#> 5   Menos de 15 años                   3     100
#> 6   Menos de 15 años                   4       0
#> 7   Menos de 15 años                   5       0
#> 8   Menos de 15 años                   6       0
#> 9   Menos de 15 años                   7       0
#> 10  Menos de 15 años                   8       0
#> 11  Menos de 15 años                   9       0
#> 12  Menos de 15 años            10 y más       0
#> 13             15-19               Total 1039850
#> 14             15-19                   0  926750
#> 15             15-19                   1   80050
#> 16             15-19                   2   23750
#> 17             15-19                   3    7200
#> 18             15-19                   4    1550
#> 19             15-19                   5     350
#> 20             15-19                   6     100
#> 21             15-19                   7      50
#> 22             15-19                   8      50
#> 23             15-19                   9       0
#> 24             15-19            10 y más       0
#> 25             20-24               Total  980550
#> 26             20-24                   0  592300
#> 27             20-24                   1  194900
#> 28             20-24                   2  112050
#> 29             20-24                   3   51250
#> 30             20-24                   4   19550
#> 31             20-24                   5    6500
#> 32             20-24                   6    2650
#> 33             20-24                   7     850
#> 34             20-24                   8     200
#> 35             20-24                   9     100
#> 36             20-24            10 y más     200
#> 37             25-29               Total  860150
#> 38             25-29                   0  271300
#> 39             25-29                   1  198300
#> 40             25-29                   2  198200
#> 41             25-29                   3   96000
#> 42             25-29                   4   49700
#> 43             25-29                   5   24900
#> 44             25-29                   6   12350
#> 45             25-29                   7    5600
#> 46             25-29                   8    2300
#> 47             25-29                   9    1000
#> 48             25-29            10 y más     500
#> 49             30-34               Total  795650
#> 50             30-34                   0  140350
#> 51             30-34                   1  141600
#> 52             30-34                   2  231100
#> 53             30-34                   3  127150
#> 54             30-34                   4   62750
#> 55             30-34                   5   34450
#> 56             30-34                   6   23600
#> 57             30-34                   7   15950
#> 58             30-34                   8    8650
#> 59             30-34                   9    4400
#> 60             30-34            10 y más    5650
#> 61             35-39               Total  767400
#> 62             35-39                   0  105750
#> 63             35-39                   1  121250
#> 64             35-39                   2  225050
#> 65             35-39                   3  125450
#> 66             35-39                   4   65650
#> 67             35-39                   5   40400
#> 68             35-39                   6   29050
#> 69             35-39                   7   20100
#> 70             35-39                   8   13150
#> 71             35-39                   9    8700
#> 72             35-39            10 y más   12850
#> 73             40-44               Total  769600
#> 74             40-44                   0   98200
#> 75             40-44                   1  125250
#> 76             40-44                   2  216650
#> 77             40-44                   3  129350
#> 78             40-44                   4   62500
#> 79             40-44                   5   37900
#> 80             40-44                   6   27850
#> 81             40-44                   7   18500
#> 82             40-44                   8   14150
#> 83             40-44                   9   13100
#> 84             40-44            10 y más   26150
#> 85             45-49               Total  698950
#> 86             45-49                   0   96550
#> 87             45-49                   1  121350
#> 88             45-49                   2  189700
#> 89             45-49                   3  107700
#> 90             45-49                   4   58100
#> 91             45-49                   5   30800
#> 92             45-49                   6   23900
#> 93             45-49                   7   18600
#> 94             45-49                   8   14250
#> 95             45-49                   9    9950
#> 96             45-49            10 y más   28050
#> 97             50-54               Total  584800
#> 98             50-54                   0   90200
#> 99             50-54                   1  101050
#> 100            50-54                   2  147900
#> 101            50-54                   3   89450
#> 102            50-54                   4   45850
#> 103            50-54                   5   29900
#> 104            50-54                   6   19900
#> 105            50-54                   7   14300
#> 106            50-54                   8   13600
#> 107            50-54                   9    9500
#> 108            50-54            10 y más   23150
#> 109            55-59               Total  549250
#> 110            55-59                   0   93000
#> 111            55-59                   1   92050
#> 112            55-59                   2  126750
#> 113            55-59                   3   78350
#> 114            55-59                   4   44050
#> 115            55-59                   5   29400
#> 116            55-59                   6   21200
#> 117            55-59                   7   14950
#> 118            55-59                   8   14800
#> 119            55-59                   9   10950
#> 120            55-59            10 y más   23750
#> 121            60-64               Total  454750
#> 122            60-64                   0   76750
#> 123            60-64                   1   75200
#> 124            60-64                   2   93200
#> 125            60-64                   3   62000
#> 126            60-64                   4   37100
#> 127            60-64                   5   26050
#> 128            60-64                   6   20700
#> 129            60-64                   7   16000
#> 130            60-64                   8   13300
#> 131            60-64                   9    9850
#> 132            60-64            10 y más   24600
#> 133            65-69               Total  350450
#> 134            65-69                   0   59000
#> 135            65-69                   1   49700
#> 136            65-69                   2   66800
#> 137            65-69                   3   46750
#> 138            65-69                   4   33050
#> 139            65-69                   5   24250
#> 140            65-69                   6   17500
#> 141            65-69                   7   13700
#> 142            65-69                   8   10800
#> 143            65-69                   9    8550
#> 144            65-69            10 y más   20350
#> 145            70-74               Total  244200
#> 146            70-74                   0   40800
#> 147            70-74                   1   28650
#> 148            70-74                   2   42450
#> 149            70-74                   3   31900
#> 150            70-74                   4   26250
#> 151            70-74                   5   19350
#> 152            70-74                   6   12950
#> 153            70-74                   7   10650
#> 154            70-74                   8    7950
#> 155            70-74                   9    6800
#> 156            70-74            10 y más   16450
#> 157            75-79               Total  156550
#> 158            75-79                   0   24400
#> 159            75-79                   1   18000
#> 160            75-79                   2   21900
#> 161            75-79                   3   19000
#> 162            75-79                   4   16550
#> 163            75-79                   5   12350
#> 164            75-79                   6   10500
#> 165            75-79                   7    9250
#> 166            75-79                   8    7050
#> 167            75-79                   9    4700
#> 168            75-79            10 y más   12850
#> 169            80-84               Total   89400
#> 170            80-84                   0   13650
#> 171            80-84                   1   10450
#> 172            80-84                   2    9450
#> 173            80-84                   3   10000
#> 174            80-84                   4    9200
#> 175            80-84                   5    8200
#> 176            80-84                   6    6850
#> 177            80-84                   7    5100
#> 178            80-84                   8    3950
#> 179            80-84                   9    4300
#> 180            80-84            10 y más    8250
#> 181         85 y más               Total   52350
#> 182         85 y más                   0    6950
#> 183         85 y más                   1    5300
#> 184         85 y más                   2    5150
#> 185         85 y más                   3    5700
#> 186         85 y más                   4    4900
#> 187         85 y más                   5    4900
#> 188         85 y más                   6    4050
#> 189         85 y más                   7    3900
#> 190         85 y más                   8    2650
#> 191         85 y más                   9    3000
#> 192         85 y más            10 y más    5850


##  reports the tables currently available in the package

check_repository( year = 1970, topic = "FECUNDIDAD", geolvl = "Total del país")
#>                            Archivo
#> 1 c70_total_del_pais_poblacion_c17
#>                                                                                                                            Titulo
#> 1 Cuadro 17. Total del país. Población femenina de 12 y más años, por grupo de edad según número de hijos nacidos vivos. Año 1970
```
