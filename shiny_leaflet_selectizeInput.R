library(shiny)
library(leaflet)


hotels <- read.table(text = "Hotel Year  latitude        longitude
                     A   2000  41.886337      -87.628472
                     B   2005  41.88819       -87.635199
                     C   2010  41.891113      -87.63301", 
                     header = TRUE)

ui <- fluidPage(
  selectizeInput(
    inputId = 'year',
    label='Choose Year:',
    choices = hotels$Year,
    multiple=TRUE,
    options = list(
      maxItems = 2,
      placeholder = '',
      onInitialize = I("function() { this.setValue(''); }"))
  ),
  actionButton("go", "go"),
  leafletOutput("mymap")
)

server <- function(input, output, session) {
  
  # use the button for observeEvent
  # ignore values ensure an empty map is loading in the beginning
  observeEvent(input$go, ignoreInit = FALSE, ignoreNULL = FALSE, {
    
    # no need for a reactive list here
    if (length(input$year)>1) {
      df_list <- list(hotels[hotels$Year == input$year[1],], 
                      hotels[hotels$Year == input$year[2],])
    } else {
      df_list <- list(hotels[hotels$Year == input$year[1],])
    }
    
    output$mymap <- renderLeaflet({
      map <- leaflet()  %>%
        addProviderTiles("OpenStreetMap.Mapnik") %>% 
        addCircleMarkers( data = df_list[[1]] ,
                          group = 'Data Markers 1',
                          lng = ~longitude,
                          lat = ~latitude,
                          radius = 10,
                          stroke = F,
                          fillOpacity = 0.9,
                          color = 'red')
      # not using input does not invoke reactiveness
      if ( length(df_list) > 1){
        map <- map %>% 
          addCircleMarkers( data = df_list[[2]] ,
                            group = 'Data Markers 2',
                            lng = ~longitude,
                            lat = ~latitude,
                            radius = 10,
                            stroke = F,
                            fillOpacity = 0.9,
                            color = 'blue')
      }
      
      if ( length(input$year)>1) {
        map <- map %>% 
          addLayersControl(
            overlayGroups = c('Data Markers 1', 'Data Markers 2'),
            options = layersControlOptions(collapsed = FALSE) )
      } else {
        map <- map %>% 
          addLayersControl(
            overlayGroups = c('Data Markers 1'),
            options = layersControlOptions(collapsed = FALSE) )
      }
      
      map
    })
  })
}

shinyApp(ui, server)
