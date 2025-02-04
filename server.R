#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Server
server <- function(input, output, session) {
  
 # bs_themer()
  
  # Reactive expression to filter data
  filtered_data0 <- reactive({
    #data <- bowling_data
    
    if (!is.null(input$player_filter) && length(input$player_filter) > 0)
      data <- data[data$Player %in% input$player_filter,]
    if (!is.null(input$location_filter) && length(input$location_filter) > 0)
      data <- data[data$Location %in% input$location_filter,]
    if (!is.null(input$ball) && length(input$ball) > 0)
      data <- data[data$Ball %in% input$ball,]
    if (!is.null(input$lanecondition) && length(input$lanecondition) > 0)
      data <- data[data$'Lane Conditions' %in% input$lanecondition,]
    # # if (!is.null(input$ball) && length(input$ball) > 0)
    # #   data <- data[data$Ball %in% input$ball,]
    # 
    # 
    # # if (!is.null(input$conditions_filter) && length(input$conditions_filter) > 0)
    # #   data <- data[data$LaneConditions %in% input$conditions_filter,]
    # # if (!is.null(input$gametype_filter) && length(input$gametype_filter) > 0)
    # #   data <- data[data$GameType %in% input$gametype_filter,]
    # 
    data
  })
  
  filtered_data <- reactive({
    data <- filtered_data0()
    data %>%
      filter(Date >= input$date_range[1], Date <= input$date_range[2])
  })
  
######################### Output Table ########################
  
  output$filtered_table <- DT::renderDataTable({
    filtered_data() %>%
      mutate(Date = as.character(Date)) # Ensure dates are displayed correctly
  }, options = list(pageLength = 5))
  
  


######################### End  Output Table ########################
  ######################### Time Series Chart ########################
#output$score_trend <- renderPlot({
  output$score_trend <- renderPlotly({ # with plotly
  req(nrow(filtered_data()) > 0)

  # p <- ggplot(filtered_data(), aes(x = Date, y = Score, color = Player)) +
  #   geom_point() +
  #   geom_smooth(se = FALSE, method = "loess") +
  #   theme_minimal() +
  #   labs(#title = "Score Trends Over Time",
  #        x = "Date",
  #        y = "Score") +
  #   theme(legend.position = "bottom")
  # p2 <- ggplotly(p)
    
    p <- ggplot(filtered_data(), aes(x = Date, y = Score, color = Player)) +
      geom_point() +
      geom_smooth(se = FALSE, method = "loess") +
      theme_minimal() +
      labs(
        x = "Date",
        y = "Score"
      ) +
      theme(
        legend.position = "bottom",
        axis.title = element_text(size = 18),  # Larger axis labels
        axis.text = element_text(size = 14)   # Larger tick labels
      ) +
      #scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") + # More x-axis ticks
      scale_y_continuous(limits = c(80, 300), breaks = seq(0, 300, by = 20)) # Set y-limits and more ticks
    
    p2 <- ggplotly(p)
    
})

######################### End: Time Series Chart ########################

######################### Average Score ########################
output$avg_score <- renderText({
  req(filtered_data())
  round(mean(filtered_data()$Score, na.rm = TRUE), 1)
  #filtered_data()$Score[2]
})
  ######################### End Average Score ########################
  
  ######################### Number of games ########################
  output$num_games<- renderText({
    req(filtered_data())
    length(filtered_data()$Score)
    #round(mean(filtered_data()$Score, na.rm = TRUE), 1)
    #filtered_data()$Score[2]
  })
  
  output$max_score <- renderText({
    req(filtered_data())
    max(filtered_data()$Score)
    #round(mean(filtered_data()$Score, na.rm = TRUE), 1)
    #filtered_data()$Score[2]
  })
  
  ######################### End Number of games ########################
  ######################### Histogram of Scores ######################## 
  # Render histogram of Score using ggplot
  output$score_histogram <- renderPlot({
    filtered_scores <- filtered_data()
    
    if (nrow(filtered_scores) > 0) {
      ggplot(filtered_scores, aes(x = Score)) +
        geom_histogram(binwidth = 10, fill = "skyblue", color = "white") +
        labs(
          title = "Histogram of Scores",
          x = "Score",
          y = "Frequency"
        ) +
        theme_minimal()
    } else {
      ggplot() +
        geom_blank() +
        annotate("text", x = 1, y = 1, label = "No data available for the selected date range.", size = 5) +
        theme_void()
    }
    
  }) 
  ######################### End:  Histogram of Scores ########################
  ######################### Game Simulator ########################  
  ###Create reactive for game simulation
  ### start with name, then number of games.  
  
  game_sim <- reactive({
    #data <- bowling_data
    
    if (!is.null(input$select_player) && length(input$select_player) > 0)
      data <- data[data$Player %in% input$select_player,]

    NAMES <- unique(data$Player)
    NO_GAMES <- input$num_games
    OUT <- c()
    # 
    for(i in 1:length(NAMES)){
      tmp <- subset(data, Player==NAMES[i])
      p1 <- data.frame(Player=rep(NAMES[i], NO_GAMES))
      p1$Score <- sample(tmp$Score, NO_GAMES, replace=TRUE)
      p1$Game <- 1:NO_GAMES
      OUT <- rbind(OUT, p1)
    }
    OUT <- data.frame(OUT)
    # #head(OUT)
    OUT <- OUT %>% spread(Player, Score)
    OUT$Total <- rowSums(OUT[-1])
  
    head(OUT)
   
  })
  
  
 #  output$game_scores<- DT::renderDataTable({
 # game_sim() # Ensure dates are displayed correctly
 #  }, options = list(pageLength = 12))
 #  
  # Render table
  output$table <- ({
    renderTable(game_sim(), digits=0)
    })
#}

  
  
  output$test_out <- renderText({
   class(game_sim())
    #filtered_data()$Score[2]
  })
  ######################### End:  Game Simulator ########################
  
  output$pivotTable <- renderRpivotTable({
    rpivotTable(
      data = data,
      rows = "Date",
      cols = "Player",
      vals = "Score",
      aggregatorName = "Average",
      rendererName = "Table"
    )
  })
  
    
} ## End bracket