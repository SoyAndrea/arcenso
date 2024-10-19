#' Title
#'
#' @param year
#' @param topic
#' @param geolvl
#'
#' @return
#' @export
#'
#' @examples
check_repository <- function( year = 1970, topic = NULL, geolvl = NULL){

  if(year != 1970) stop(paste0("El año ", year, " todavia no fue cargado en AR_CENSO o no es un año censal"))

  load("data/info_cuadros_arcenso.rda")
  repo <- list.files("data/", full.names = T)

  selec <- info_cuadros_arcenso[info_cuadros_arcenso$anio %in% year & info_cuadros_arcenso$PKG %in% "SI",  ]

  if(!is.null(topic)){

    if(!topic %in% unique(selec$tema)) stop(c("Temática elegida inválida \nLas temáticas disponibles para el año seleccionado son: \n", paste(unique(selec$tema), "\n")))

    selec <- selec[selec$tema %in% topic,  ]
  }
  if(!is.null(geolvl)){
    selec <- selec[grepl(geolvl, selec$Jurisdiccion),  ]
  }


  lista_cuadros <- info_cuadros_arcenso[info_cuadros_arcenso$Archivo %in% selec$Archivo, c("Archivo", "Titulo")]

  return(lista_cuadros)

}
