library(tidyr)
library(dplyr)
library(lubridate)

data_processed <- read.csv("data/raw/raw_data.csv")

glimpse(data_processed)

data_processed <- data_processed |> 
  mutate(date = as.Date(date, origin = "1899-12-30"))

#change time

glimpse(data_processed)

write.csv(data_processed, "data/processed/data_processed.csv")
