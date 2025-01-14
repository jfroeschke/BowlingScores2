ui <- page_sidebar(
  
  theme = bs_theme(bootswatch = "darkly"),
  
  title= "Bowling Scores",
  sidebar=sidebar(
    selectInput("player_filter", "Player Name", 
                choices=c("John", "Andrew", "Catalina", "Bridgette"), multiple = TRUE, selected=c("John", "Andrew", "Catalina", "Bridgette")),
    dateRangeInput(
      "date_range",
      "Select Date Range:",
      start = min(data$Date),
      end = max(data$Date),
      min = min(data$Date),
      max = max(data$Date)
    ),
    selectInput("location_filter", "Bowling Alley",
                choices=c("PCB", "PCM" ,"NA" ), multiple=TRUE),
    selectInput("ball", "Ball Used",
                choices=unique(bowling_data$Ball), multiple=TRUE),
    
    value_box(
      title = "Average Score",
      value = verbatimTextOutput("avg_score"),
      showcase = bs_icon("award-fill")
    ),
    
    value_box(
      title = "Number of Games",
      value = verbatimTextOutput("num_games"),
      showcase = bs_icon("bar-chart")
    ),
    #plotOutput("score_histogram"), ## move to main panel
    
    HTML('<img src = "logo.png", width = "100%", height = "auto">')
    
   
    
  ),
  layout_columns(
    card(card_header("Score Trends"),
  plotOutput("score_trend", height = "400px")
  ),
  # card(card_header("Scores"),
  #      style = "resize:vertical;",
  #      height=300,
  #      min_height=100,
  #      DT::dataTableOutput("filtered_table"),
  #      
  # ),
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
       )#,
       #tableOutput("table") 
  ),
  card(card_header("Match"),
       tableOutput("table") 
  ),
  
  col_widths = c(12,6,6, 12),
  row_heights = c(4,  2)
  
)
)