# Biodiversity Shiny App for Appsilon

This app is deployed at:
- Possit Connect Cloud: [Biodiversity Dashboard](https://connect.posit.cloud/parv-sachdeva/content/01926389-7248-1872-23fa-dbfb66268249)
- shinyapps.io: [Biodiversity Dashboard](http://parvsachdeva.shinyapps.io/shiny_biodiversity_app)

This R Shiny dashboard helps visualize the biodiversity data from [Global Biodiversity Information Facility](https://www.gbif.org/occurrence/search?dataset_key=8a863029-f435-446a-821e-275f4f641165).

## Main Features

1. Species Visualization Map: Biodiversity observations can be viewed on the map by selecting a country and a species or vernacular name. 

2. Species Visualization Timeline: The timeline of when indivuduals were spotted can be seen as an interactive plotly plot.

Additional Features:

- Get a count of total number of individuals spotted in a certain area by hovering over the map markers.

- Compare the timeline of a species with other species by using the sidebar in the timeline plot.

## Data

The data has been pre-processed and is present as multiple csv files. Each country has a unique CSV file which is loaded on demand when the user selects that country.

This preprocessing ensures that the app is optimized and also ensures fast processing speed of the dataset.

## Extras

- Beautiful UI: This app includes a custom theme made using [bslib](https://rstudio.github.io/bslib/) and custom CSS styling. This ensures that the app matches the Appsilon theme.

- Performance Optimization: This app is optimized to load data on demand. This ensures that the plots and map are fast to load.

- JavaScript: I have used interactive elements in the app such as
  - Hover to display additional data on map markers
  - Interactive plotly js plot for the timeline
  - Ability to add and compare the timeline of multiple species

- Infrastructure: This app has also been deployed on Posit Connect @ [Biodiversity Dashboard](https://connect.posit.cloud/parv-sachdeva/content/01926389-7248-1872-23fa-dbfb66268249).

## Running the app locally

The app can be launched by using the following command:

```{R}
shiny::runApp()
```

## Tests

Tests for this app can be run using the following command:

```{R}
shiny::runTests()
```

