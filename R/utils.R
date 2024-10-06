get_all_countries <- function(data_path) {
    all_csv_files <- list.files(data_path, pattern = ".csv$")
    if (length(all_csv_files) == 0) {
        return(NULL)
    }
    countries <- all_csv_files %>% str_remove(., ".csv")
    return(countries)
}

read_country_data <- function(data_path, country) {
    data <- fread(
        input = file.path(data_path, glue("{country}.csv")), sep=","
    )
    return(data)
}

get_animal_names_list <- function(data, country="Poland") {
    animalNames <- data %>% 
        filter(country==country) %>%
        select(scientificName, vernacularName) %>% 
        mutate(fullName=paste0(scientificName, " -- ", vernacularName)) %>% 
        distinct()
    animalNamesList <- setNames(animalNames$scientificName, animalNames$fullName)
    return(animalNamesList) 
}

add_total_individuals_per_locality <- function(data) {
    data <- data %>%
        group_by(locality, scientificName, latitudeDecimal, longitudeDecimal) %>%
        mutate(totalIndividuals = sum(individualCount)) %>%
        ungroup()
    return(data)
}

plot_animal_timeline_plot <- function(plotData) {
    p <- ggplot(plotData, aes(x = eventDate, y = individualCount, color = scientificName)) +
        geom_line(size = 0.5, alpha = 0.5) +
        geom_point(alpha = 0.5) +
        ylab("Animal Spottings") +
        xlab("Date")
}

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