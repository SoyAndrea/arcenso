#' arcenso
#'
#' @return Shiny
#' @export
#'
#' @examples arcenso()
arcenso <- function(){
  mytheme <-
    create_theme(
      adminlte_color(light_blue = "#434C5E"),
      adminlte_global(content_bg = "#FFF", box_bg = "#FFFFFF",info_box_bg = "#FFFFFF")
    )
  
  #load("info_cuadros_arcenso.RData")
  
  # Header ------------------------------------------------------------------
  ui_header <- dashboardHeader(title = "ARcenso consulta", disable = T)
  
  # Side Bar ----------------------------------------------------------------
  ui_sidebar <- dashboardSidebar(collapsed = TRUE, sidebarMenu())
  
  # Body --------------------------------------------------------------------
  
  ui_body <- dashboardBody(
    
    use_theme(mytheme),
    tabItem(tabName = "consulta",
            br(),
            fluidRow(
              box(width = 12,
                  imageOutput(outputId = "banner", height = "10%",width = "100%")),
              box(status = "info",
                  width = 4,
                  br(),
                  selectInput(
                    inputId = "anio",
                    label = "Año censal",
                    choices = c(1970,1980)),
                  selectInput(
                    inputId = "geo",
                    label = "Alcance geográfico",
                    choices = NULL),
                  selectInput(
                    inputId = "tema",
                    label = "Temática",
                    choices = NULL),
                  selectInput(
                    inputId = "listas",
                    label = "Seleccione tabla",
                    choices = NULL),
                  
              ), # cierre box
              
              box(
                width = 8,status = "info",
                h4(textOutput("archivo")),
                br(),
                gt_output("tablacensal"),
                h4(htmlOutput("Fuente"))
              ) # cierra box
              
            )
    ) # cierre tab
  )
  
  # built -------------------------------------------------------------------
  
  ui <- dashboardPage(header = ui_header,
                      sidebar = ui_sidebar,
                      body = ui_body)
  
  
  # server ------------------------------------------------------------------
  
  
  server <- function(input, output, session) {
    
    
    output$banner <- renderImage({
      
      filename <- normalizePath(file.path('./img','arcenso.png'))
      list(src = filename,
           width = 850,
           height = 200,
           alt = "banner")
    }, deleteFile = FALSE)
    
    # OBSER ------------
    
    observeEvent(input$anio, {
      geo_filtrada <- info_cuadros_arcenso$Jurisdiccion[info_cuadros_arcenso$anio == input$anio]
      
      
      updateSelectInput(
        session, "geo",
        choices = unique(geo_filtrada))
      
      updateSelectInput(session, "tema", choices = NULL)
      updateSelectInput(session, "Titulo", choices = NULL)
      
    })
    
    
    observeEvent(input$geo, {
      tema_filtrado <- info_cuadros_arcenso$tema[info_cuadros_arcenso$anio == input$anio & info_cuadros_arcenso$Jurisdiccion == input$geo ]
      
      
      updateSelectInput(
        session, "tema",
        choices = unique(tema_filtrado))
      
      updateSelectInput(session, "Titulo", choices = NULL)
      
    })
    
    observeEvent(input$tema, {
      listas_filtrado <- info_cuadros_arcenso$Titulo[
        info_cuadros_arcenso$anio == input$anio &
          info_cuadros_arcenso$Jurisdiccion == input$geo &
          info_cuadros_arcenso$tema == input$tema]
      
      
      updateSelectInput(
        session, "listas",
        choices = unique(listas_filtrado))
      
    })
    
    
    # archivo ---------
    
    output$archivo <- renderText({
      
      concepto <- paste(info_cuadros_arcenso %>%
                          filter(
                            anio== input$anio,
                            Jurisdiccion == input$geo,
                            tema == input$tema,
                            Titulo == input$listas) %>%
                          select(Archivo))
      
    })
    
    # tabla ------------
    
    
    output$tablacensal <- render_gt({
      
      
      req(input$listas)
      req(input$anio)
      
      cuadro <- info_cuadros_arcenso$Archivo[info_cuadros_arcenso$Titulo %in% input$listas]
      
      if(grepl(substr(input$anio,3,4), cuadro)){
        
        path <- paste0(paste0(system.file("extdata", package = "arcenso"),"/"),input$anio,"/")
        
        tabla_censal <- readRDS(paste0(path,cuadro, ".RDS"))
        
        gt(tabla_censal) %>%
          opt_interactive(use_compact_mode = TRUE)
        
      } else {
        gt(as.data.frame("..."))
      }
      
    })
    
    output$Fuente <- renderText({
      
      anio=input$anio
      
      if(req(anio) == 1970){
        
        "Fuente: INDEC, Censo Nacional de Población, Familias y Viviendas 1970."
        
      }
      else if(req(anio) == 1980){
        "Fuente: INDEC, Censo Nacional de Población y Viviendas 1980"
        
      }
      
      
      
    })
    
    
    
  }
  
  
  # ejecutar shiny ----------------------------------------------------------
  
  shinyApp(ui, server)
  
  
}
