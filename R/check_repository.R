#' check_repository
#'reports the tables currently available in the package
#' @param year census year for which the user wants to view the currently available tabulations. The default is “1970”.
#' @param topic census topic of the tables available: ESTRUCTURA DE POBLACION, CONDICION DE ACTIVIDAD, FECUNDIDAD, CONDICIONES HABITACIONALES, COMPOSICIÓN DE LO HOGARES, MIGRACIÓN, SITUACIÓN CONYUGAL y EDUCACION. Setting the parameter to NULL will download all available tables.
#' @param geolvl geographic disaggregation level, use “Total del país” for the overall results. Setting the parameter to NULL will download all available tables.
#'
#' @return Returns a data frame with the title of the tables that can be acces with the get_census function and the name given by that function to each table
#' @export
#'
#' @examples check_repository( year = 1970, topic = "EDUCACION", geolvl = "Total del país")
check_repository <- function( year = 1970, topic = NULL, geolvl = NULL){

  if(year != 1970 & year != 1980) stop(paste0("El año ", year, " todavia no fue cargado en AR_CENSO o no es un año censal"))


  #repo <- list.files(paste0(system.file("extdata", package = "arcenso"),"/"), full.names = T)

  selec <- info_cuadros_arcenso[info_cuadros_arcenso$anio %in% year & info_cuadros_arcenso$PKG %in% "SI",  ]

  if(!is.null(topic)){

    if(!topic %in% unique(selec$tema)) stop(c("Temática elegida inválida \nLas temáticas disponibles para el año seleccionado son: \n", paste(unique(selec$tema), "\n")))

    selec <- selec[selec$tema %in% topic,  ]
  }
  if(!is.null(geolvl)){
    selec <- selec[grepl(geolvl, selec$Jurisdiccion),  ]
  }


  lista_cuadros <- info_cuadros_arcenso[info_cuadros_arcenso$Archivo %in% selec$Archivo, c("Archivo", "Titulo")]

  rownames(lista_cuadros) = NULL

  return(lista_cuadros)

}
