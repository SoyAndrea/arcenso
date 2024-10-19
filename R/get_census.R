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
get_census <- function( year = 1970, topic = NULL, geolvl = NULL){

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

  cuad <- list.files(grep(year, repo, value = T), full.names = T)

  cuad_selec = cuad[substr(cuad,11,nchar(cuad)-4)  %in% selec$Archivo]

  lista_cuadros <- list()
  for(i in cuad_selec){
    lista_cuadros[[substr(i,17,nchar(i)-4)]] = readRDS(i)
  }

  return(lista_cuadros)

}
