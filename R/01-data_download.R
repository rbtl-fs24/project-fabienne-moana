library(googlesheets4)

raw_data <- read_sheet("https://docs.google.com/spreadsheets/d/12rU6WmPDLHlAwD8pHjUrLh5PyxqVdM6BKoPx2CaZR1E/edit?usp=sharing")

write.csv(raw_data, "data/raw/raw_data.csv")
