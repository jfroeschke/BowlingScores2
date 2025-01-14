#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

ui <- fluidPage(
  titlePanel("Filter Data by Date"),
  sidebarLayout(
    sidebarPanel(
      selectInput("player_filter", "Player Name", 
                  choices=c("John", "Andrew", "Catalina", "Bridgette"), multiple = TRUE, selected="John"),
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
        value = verbatimTextOutput("avg_score")
      ),
      
      value_box(
        title = "Number of Games",
        value = verbatimTextOutput("num_games")
      ),
      plotOutput("score_histogram"),
      
      HTML('<img src = "logo.png", width = "100%", height = "auto">')
      
    ),
    mainPanel(
    
      #tableOutput("filtered_table")
      plotOutput("score_trend", height = "400px"),
      DT::dataTableOutput("filtered_table"),
      HTML('<div style="text-align: center; font-size: 24px; font-weight: bold;">Create a bowling match</div>'),
      
      
      fluidRow(
        style = "border: 2px solid #ccc; padding: 10px; border-radius: 5px; margin-top: 15px;",
        column(6, 
               selectInput(
                 "select_player", 
                 "Select Player", 
                 choices = c("John", "Andrew", "Catalina", "Bridgette"), 
                 multiple = TRUE, 
                 selected = "John"
               )
        ),
        column(6, 
               radioButtons(
                 inputId = "num_games", 
                 label = "Select the number of games:", 
                 choices = c("1" = 1, "2" = 2, "3" = 3), 
                 selected = 1, 
                 inline = TRUE
               )
        )),
      # DT::dataTableOutput("game_scores"),
      tableOutput("table")
      # value_box(
      #   title = "test",
      #   value = verbatimTextOutput("test_out")
      # ),
      
    )
  )
)