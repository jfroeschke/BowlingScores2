# ### data load
### uncomment and run when importing new scores
# 
library(googlesheets4)
gs4_auth("john.froeschke@gmail.com")
bowling_data <- read_sheet("https://docs.google.com/spreadsheets/d/1YdRJJENXkx3vH55uSFour4gEjQFPffVYM1vC9S8L-wo/edit?usp=sharing")


save(bowling_data, file="bowling_data.RData")

