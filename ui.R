ui <- page_sidebar(
  title = h1("Biodiversity Dashboard", class="bslib-page-title", style="color:#008DE7;font-weight: bold;font-size: 200%;"),
  sidebar = sidebar(
    title = "Select Values",
    inputModuleUI("input_module"),
    h5("Author: ", tags$a(href="https://github.com/parv-sachdeva/", "Parv Sachdeva"), style="position: absolute; bottom: 80px;"),
    img(
      src="https://cdn.prod.website-files.com/6525256482c9e9a06c7a9d3c/6539655f4ca172cfc5deaad8_Appsilon_logo.svg",
      style="position: absolute; bottom: 10px;"
    ),
    open = TRUE
  ),
  layout_column_wrap(
    width = 1/2,
    height = 300,
    leafletMapUI("leaflet_map"),
    timelinePlotUI("timeline_plot")
  )
)