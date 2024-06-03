library(tidyr)
library(dplyr)
library(lubridate)

data_processed <- read.csv("data/raw/raw_data.csv")

glimpse(data_processed)

data_processed <- data_processed |> 
  mutate(date = as.Date(date, origin = "1899-12-30"))

#change time
#change NA in row alu_nr

glimpse(data_processed)
