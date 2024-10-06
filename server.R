server <- function(input, output, session) {

    # Add blib theme
    bs_theme_update(bs_theme(), primary = "#008DE7", base_font = font_google("Maven Pro"), 
    `enable-gradients` = TRUE, `enable-shadows` = TRUE)

    biodiversity_data <- reactiveValues()

    # Capture input values from inputModule
    inputValues <- inputModuleServer("input_module", data_path="data/split_by_country")

    # Map plot using leafletMap module
    leafletMapServer(
        "leaflet_map",
        biodiversity_data = reactive(inputValues$data),
        country = reactive(inputValues$country),
        animal = reactive(inputValues$animal)
    )

    # Timeline plot using timeplinePlot module
    timelinePlotServer(
        "timeline_plot",
        biodiversity_data = reactive(inputValues$data),
        country = reactive(inputValues$country),
        animal = reactive(inputValues$animal)
    )
}