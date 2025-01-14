

library(shiny)
library(bslib)
library(DT)
library(ggplot2)
library(dplyr)
#library(googlesheets4)
library(tidyverse)
library(bslib)
library(bsicons)
library(thematic)

#thematic_shiny()
# 
#  gs4_auth("john.froeschke@gmail.com")
#  #bowling_data <- read_sheet("https://docs.google.com/spreadsheets/d/1YdRJJENXkx3vH55uSFour4gEjQFPffVYM1vC9S8L-wo/edit?gid=0#gid=0")
# bowling_data <- read_sheet("https://docs.google.com/spreadsheets/d/1YdRJJENXkx3vH55uSFour4gEjQFPffVYM1vC9S8L-wo/edit?usp=sharing")
# # #Read google sheets data into R
load("bowling_data.RData")
data <- bowling_data


## To Do:
### Compute Average by ball, maybe ball selector guide?
### Add a tab to sample scores per player for matches.  

### Add to app somwewhere: Use to generate games for match.

## move this into server for a refresh
# NAMES <- unique(data$Player)
# NO_GAMES <- 3
# OUT <- c()
# 
# for(i in 1:length(NAMES)){
#   tmp <- subset(data, Player==NAMES[i])
#   p1 <- data.frame(Player=rep(NAMES[i], NO_GAMES))
#   p1$Score <- sample(tmp$Score, NO_GAMES, replace=TRUE)
#   p1$Game <- 1:NO_GAMES
#   OUT <- rbind(OUT, p1)
# }
# 
# OUT2 <- OUT %>% spread(Player, Score) %>%
#   mutate(Total=Andrew + Bridgette + Catalina + John)
# 
# OUT2 <- OUT %>% spread(Player, Score)
#   OUT2$Total <- rowSums(OUT2[, -1])
# 
# 
# ## use an input here or just display this as a table
# KEEP <- OUT2 %>%
#   select(Game, Andrew, Catalina, John, Bridgette)
# KEEP$Total <- rowSums(KEEP[2:5])


## try to subset using NAMES

#save(data, "data.RData")


# scores <- data.frame(
#   Game = 1:3,
#   Andrew = c(140, 124, 130),
#   Bridgette = c(104, 128, 96),
#   Catalina = c(87, 92, 92),
#   John = c(122, 149, 197)
# )
# 
# # Compute row sums for columns 2 to 5 and add as a new column
# scores$Total <- rowSums(scores[, 2:ncol(scores)])