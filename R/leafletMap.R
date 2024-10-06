leafletMapUI <- function(id) {
    ns <- NS(id)
    tagList(
        card(
            card_header("Map", style="background-color:#008DE7;color:white;"),
            leafletOutput(ns("map_plot")),
        )
    )
}

leafletMapServer <- function(id, biodiversity_data, country, animal) {
    stopifnot(is.reactive(biodiversity_data))
    stopifnot(is.reactive(country))
    stopifnot(is.reactive(animal))
    moduleServer(id, function(input, output, session) {
        output$map_plot <- renderLeaflet({
            req(biodiversity_data(), country(), animal())
            tryCatch({
                # Create a leaflet map
                leaflet(
                    biodiversity_data() %>% filter(
                        scientificName==animal() &
                        !is.na(latitudeDecimal) &
                        !is.na(longitudeDecimal)
                    )
                ) %>%            
                addTiles() %>%
                addMarkers(
                    ~longitudeDecimal, ~latitudeDecimal,
                    label = ~paste0(glue("Locality: {locality} <br> Country: {country()}<br>Continent: {continent}<br>Total Individuals: {totalIndividuals}")) %>% lapply(htmltools::HTML),
                    popup = ~paste0(glue("Locality: {locality}<br>Country: {country()}<br>Continent: {continent}<br>Total Individuals: {totalIndividuals}"))
                )
            },
            error=function(cond) {
                warning(paste0("Error in processing map with the selected inputs: ", cond, "Proceeding!"))
            })

        })
    })
}