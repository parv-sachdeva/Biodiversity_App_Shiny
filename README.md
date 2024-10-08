# Biodiversity Shiny App for Appsilon

This app is deployed at:
- shinyapps.io: [Biodiversity Dashboard](http://parvsachdeva.shinyapps.io/shiny_biodiversity_app)
- Possit Connect Cloud: [Biodiversity Dashboard](https://connect.posit.cloud/parv-sachdeva/content/01926389-7248-1872-23fa-dbfb66268249) [Note: this link is currently inactive since the free version only supports public repositories.]

This R Shiny dashboard helps visualize the biodiversity data from [Global Biodiversity Information Facility](https://www.gbif.org/occurrence/search?dataset_key=8a863029-f435-446a-821e-275f4f641165).

## Main Features

1. Species Visualization Map: Biodiversity observations can be viewed on the map by selecting a country and a species or vernacular name. 

2. Species Visualization Timeline: The timeline of when individuals were spotted can be seen as an interactive plotly plot.

Additional Features:

- Hover over the map markers to count the total number of individuals spotted in a certain area.

  ![image](https://github.com/user-attachments/assets/dc67f078-5945-40f5-823a-4f5669b846f9)


- Compare the timeline of a species with other species by using the `Add Animals To Plot` option in the sidebar of the timeline plot. This will add multiple timelines, one for each selected species (colored by species).

![image](https://github.com/user-attachments/assets/2a40aa0b-cb8c-4c94-a68f-a8f33acb4af5)




## Extras

- Beautiful UI: This app includes a custom theme made using [bslib](https://rstudio.github.io/bslib/) and custom CSS styling. This ensures that the app matches the Appsilon theme.

- Performance Optimization: This app is optimized to load data on demand. This ensures that the map and the plots are fast to load.

- JavaScript: Interactive elements have been utilized in the app such as
  - Hover to display additional data on map markers
  - Interactive plotly js plot for the timeline
  - Ability to add and compare the timeline of multiple species

- Infrastructure: This app has also been deployed on Posit Connect @ [Biodiversity Dashboard](https://connect.posit.cloud/parv-sachdeva/content/01926389-7248-1872-23fa-dbfb66268249).

## Data

The data has been pre-processed and cleaned and is split by country into multiple CSV files in the `data` folder. Each country has a unique CSV file loaded on demand when the user selects that country.

This preprocessing ensures that the app is optimized and that the dataset is processed quickly.

Note: Data for two countries (France and Spain) has been excluded from the app since their sizes were larger than GitHub's file limit of 100MB. Apart from this, all deformed data has been filtered out.

## Running the app locally


Note: Before running make sure to have the following dependencies installed:

```
glue
shiny
bslib
dplyr
plotly
ggplot2
leaflet
stringr
data.table
```

The app can be launched locally using the following command:

```{R}
shiny::runApp("<path to app folder>")
```

## Tests

Tests for this app can be run using the following command:

```{R}
shiny::runTests("<path to app folder>")
```
