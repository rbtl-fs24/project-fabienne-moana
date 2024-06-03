library(googlesheets4)

raw_data <- read_sheet("https://docs.google.com/spreadsheets/d/12rU6WmPDLHlAwD8pHjUrLh5PyxqVdM6BKoPx2CaZR1E/edit?usp=sharing")

write.csv(raw_data, "data/raw/raw_data.csv")


dictionary <- read_sheet("https://docs.google.com/spreadsheets/d/1rmat_gGZk4y1CRBI8qhRuayoYUJrJeuzLZvhQ-L2PwI/edit?usp=sharing")

write.csv(dictionary, "data/processed/dictionary.csv")
