timelinePlotUI <- function(id) {
    ns <- NS(id)
    tagList(
        card(
            full_screen = TRUE,
            card_header("Timeline Plot", style="background-color:#008DE7;color:white;"),
            layout_sidebar(
                sidebar = sidebar(
                selectizeInput(
                    ns("other_animals"), "Add Animals To Plot",
                    choices = NULL, multiple = TRUE
                ),
                    position = "right", open = FALSE
                ),
                plotlyOutput(ns("time_plot")),
                border = FALSE
            ),
        )
    )
}

timelinePlotServer <- function(id, biodiversity_data, country, animal) {
    stopifnot(is.reactive(biodiversity_data))
    stopifnot(is.reactive(country))
    stopifnot(is.reactive(animal))
    moduleServer(id, function(input, output, session) {
        observeEvent(animal(),{
            req(biodiversity_data())
            # Update Sidebar with a list of additional animals
            updateSelectizeInput(
                session, inputId="other_animals", 
                choices = biodiversity_data() %>% pull(scientificName) %>% unique %>% sort, 
                server=TRUE,
                selected=animal()
            )
        })
        output$time_plot <- renderPlotly({
            req(biodiversity_data(), country(), animal())
            
            # Prepare data
            plotData <- biodiversity_data() %>% 
                filter(scientificName %in% c(animal(), input$other_animals)) %>% 
                select(individualCount, eventDate, scientificName) %>% 
                mutate(eventDate=as.Date(eventDate))

            # Create plot
            p <- plot_animal_timeline_plot(plotData) %>% convert_timeplot_to_plotly_with_legend()
        })
    })
}