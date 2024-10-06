inputModuleUI <- function(id) {
    ns <- NS(id)
    tagList(
        selectInput(
        ns("country"), "Select Country",
        choices = NULL
        ),
        selectizeInput(
        ns("animal"), "Select Animal",
        choices = NULL
        )
    )
}


inputModuleServer <- function(id, data_path="data/split_by_country") {
    # stopifnot(is.reactive(country))
    # stopifnot(is.reactive(animal))
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        returnValues <- reactiveValues()
        localReactiveValues <- reactiveValues()

        # Get a list of countries from the available csv files
        localReactiveValues$countries <- get_all_countries(data_path = data_path)

        # Observe the list of countries and update the country selection input
        observeEvent(localReactiveValues$countries,{
            req(localReactiveValues$countries)
            updateSelectInput(session, inputId="country", choices = localReactiveValues$countries, selected = "Poland")
        })

        # Read a country specific csv when a country is selected and then update the available list of animals
        observeEvent(input$country,{
            req(input$country, localReactiveValues$countries)
            # Read CSV file for the selected country
            tryCatch({
                localReactiveValues$data <- read_country_data(
                    data_path = data_path,
                    country = input$country
                )
                # Make the eventDate column a Data data type
                localReactiveValues$data <- localReactiveValues$data %>%
                    mutate(eventDate = as.Date(eventDate))
            },
            error=function(cond) {
                localReactiveValues$data <- NULL
                warning(paste0("Could not read CSV file with error: ", cond, "Proceeding!"))
            })

            tryCatch({
                # Add total individuals spotted for use in map info
                localReactiveValues$data <- add_total_individuals_per_locality(data = localReactiveValues$data)

                # Get a named list of animals with the values as the scientificName
                # and the names as a combination of scientificName and vernacularName
                animalNamesList <- get_animal_names_list(
                    data = localReactiveValues$data,
                    country = input$country
                )

                # Update animal names input
                updateSelectizeInput(session, inputId="animal", choices = NULL, server=TRUE)
                updateSelectizeInput(session, inputId="animal", choices = animalNamesList, server=TRUE)
            },
            error=function(cond) {
                warning(paste0("Error in processing and updating inputs: ", cond, "Proceeding!"))
            })
        })

        # Observe input variables to return to main server
        observe({ 
            returnValues$country <- input$country 
            returnValues$animal <- input$animal 
            returnValues$data <- localReactiveValues$data
        })
        return(returnValues)
    })
}