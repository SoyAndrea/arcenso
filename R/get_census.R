#' get_census
#'get a list with the tables currently available in the package
#' @param year census year for which the user wants to view the currently available tabulations. The default is “1970”.
#' @param topic census topic of the tables Setting the parameter to NULL will download all available tables.
#' @param geolvl geographic disaggregation level, use “Total del país” for the overall results. Setting the parameter to NULL will download all available tables.
#'
#' @return Returns a list with the tables that meet the parameters. To check the tables currently available use the check_repository function
#' @export
#'
#' @examples get_census( year = 1970, topic = "EDUCACION", geolvl = "Total del país")
get_census <- function( year = 1970, topic = NULL, geolvl = NULL){

  if(year != 1970) stop(paste0("El año ", year, " todavia no fue cargado en AR_CENSO o no es un año censal"))

  #load("info_cuadros_arcenso.rda")
  repo <- list.files(system.file("extdata", package = "arcenso"), full.names = T)

  selec <- info_cuadros_arcenso[info_cuadros_arcenso$anio %in% year & info_cuadros_arcenso$PKG %in% "SI",  ]

  if(!is.null(topic)){

    if(!topic %in% unique(selec$tema)) stop(c("Temática elegida inválida \nLas temáticas disponibles para el año seleccionado son: \n", paste(unique(selec$tema), "\n")))

    selec <- selec[selec$tema %in% topic,  ]
  }
  if(!is.null(geolvl)){
    selec <- selec[grepl(geolvl, selec$Jurisdiccion),  ]
  }

  cuad <- list.files(grep(year, repo, value = T), full.names = T)

  cuad_selec = cuad[substr(cuad,11,nchar(cuad)-4)  %in% selec$Archivo]

  lista_cuadros <- list()
  for(i in cuad_selec){
    lista_cuadros[[substr(i,17,nchar(i)-4)]] = readRDS(i)
  }

  return(lista_cuadros)

}
