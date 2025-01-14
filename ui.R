ui <- page_sidebar(
  theme = bs_theme(bootswatch = "darkly",
                   success = "#21869B",
                   "table-color" = "#E8E9E6",
                   base_font = font_google("Lato")# ,
                   # heading_font = font_face(
                   #   family = "Open Sauce Sans",
                   #   src="url('../OpenSauceSans-Regular.ttf) format('tru)"
                   # )
                   
                  # code_font = 
                   ), #change font color of table text
  title = "Bowling Scores",
  sidebar = sidebar(
    class = "bg-secondary", ## change sidebar background color
    selectInput("player_filter", "Player Name", 
                choices = c("John", "Andrew", "Catalina", "Bridgette"), 
                multiple = TRUE, 
                selected = c("John", "Andrew", "Catalina", "Bridgette")),
    dateRangeInput(
      "date_range",
      "Select Date Range:",
      start = min(data$Date),
      end = max(data$Date),
      min = min(data$Date),
      max = max(data$Date)
    ),
    selectInput("location_filter", "Bowling Alley",
                choices = c("PCB", "PCM", "NA"), 
                multiple = TRUE),
    selectInput("ball", "Ball Used",
                choices = unique(bowling_data$Ball), 
                multiple = TRUE),
    # value_box(
    #   title = p("Average Score", bs_icon("award-fill")),
    #   value = verbatimTextOutput("avg_score"),
    #   theme = "secondary"
    #   #showcase = bs_icon("award-fill")
    # ),
    # value_box(
    #   title = p("Games", bs_icon("bar-chart")),
    #   value = verbatimTextOutput("num_games"),
    #   theme = "success"
    #   #showcase = bs_icon("bar-chart")
    # ),
    HTML('<img src = "logo2.png", width = "100%", height = "auto">')
  ),
  #layout_columns(
    # Add tab panel here
    tabsetPanel(
      tabPanel(
        title = "Main",
    ### value boxes 
    layout_columns(
        col_widths =c(4,4,4,12,4,-1,5),
        #row_heights = c(1, 3,1),
    value_box(
      title = p("Average Score", bs_icon("award-fill")),
      value = verbatimTextOutput("avg_score"),
      theme = "secondary"
      #showcase = bs_icon("award-fill")
    ),
    value_box(
      title = p("Games", bs_icon("bar-chart")),
      value = verbatimTextOutput("num_games"),
      theme = "success"
      #showcase = bs_icon("bar-chart")
    ),
    value_box(
      title = p("Games", bs_icon("bar-chart")),
      value = 1,
      theme = "success"
      #showcase = bs_icon("bar-chart")
    ),
        
    ### end value boxes    
        card(card_header("Score Trends", class = "text-success"),
             plotOutput("score_trend", height = "400px")
        ),
        card(card_header("Create a Bowling Match"),
             selectInput(
               "select_player", 
               "Select Player", 
               choices = c("John", "Andrew", "Catalina", "Bridgette"), 
               multiple = TRUE, 
               selected = "John"
             ),
             radioButtons(
               inputId = "num_games", 
               label = "Select the number of games:", 
               choices = c("1" = 1, "2" = 2, "3" = 3), 
               selected = 1, 
               inline = TRUE
             )
        ),
        card(card_header("Match"),
             tableOutput("table")
        )
    
    )### layout
      ),
      tabPanel(
        title = "Scores Data",
        card(card_header("Test Tab Content"),
             h4("This is the Test tab content."),
             DT::dataTableOutput("filtered_table")
        )
      )
    ),
    #col_widths = c( 6,6,12, 6,6, 12), ## this isnt working as expected
    #row_heights = c(4, 2)
  )
#)
