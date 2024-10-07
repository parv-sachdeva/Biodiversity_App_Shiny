# Get a vector of countries by scanning the csv files in the data folder
get_all_countries <- function(data_path) {
    all_csv_files <- list.files(data_path, pattern = ".csv$")
    if (length(all_csv_files) == 0) {
        return(NULL)
    }
    countries <- all_csv_files %>% str_remove(., ".csv")
    return(countries)
}

# Read the data file for a country and set data types
read_country_data <- function(data_path, country) {
    data <- fread(
        input = file.path(data_path, glue("{country}.csv")), sep=","
    ) %>%
    # Add datatypes for important variables
    mutate(
        latitudeDecimal = as.numeric(latitudeDecimal),
        longitudeDecimal = as.numeric(longitudeDecimal),
        eventDate = as.Date(eventDate)
    )
    return(data)
}

# Get a named list of animals from the data
# The names are a combination of scientificNAme and fullName
# The values are scientificName
get_animal_names_list <- function(data, country="Poland") {
    animalNames <- data %>% 
        filter(country==country) %>%
        select(scientificName, vernacularName) %>% 
        mutate(fullName=paste0(scientificName, " -- ", vernacularName)) %>% 
        distinct()
    animalNamesList <- setNames(animalNames$scientificName, animalNames$fullName)
    return(animalNamesList) 
}

# Summarize the total number of spottins of an organism in an area
add_total_individuals_per_locality <- function(data) {
    data <- data %>%
        group_by(locality, scientificName, latitudeDecimal, longitudeDecimal) %>%
        mutate(totalIndividuals = sum(individualCount)) %>%
        ungroup()
    return(data)
}

# Create a ggplot of the timeline of organism observations
plot_animal_timeline_plot <- function(plotData) {
    p <- ggplot(plotData, aes(x = eventDate, y = individualCount, color = scientificName)) +
        geom_line(linewidth = 0.8, alpha = 0.5) +
        geom_point(alpha = 0.5) +
        ylab("Number of Individuals Observed") +
        xlab("Date") +
        ggtitle("Timeline Plot of Organism Observations")
}

# Convert a ggplot object to a plotly object with the legend at bottom of plot
convert_timeplot_to_plotly_with_legend <- function(p) {
    ggplotly(p) %>%
    plotly::layout(
        legend=list(
            x=0, y = -0.1,
            xanchor='left',
            yanchor='top',
            orientation='h'
        )
    ) 
}