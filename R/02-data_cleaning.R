library(tidyr)
library(dplyr)
library(lubridate)

data_processed <- read.csv("data/raw/raw_data.csv")

glimpse(data_processed)

data_processed <- data_processed |> 
  mutate(date_time = as.POSIXct(date_time, "%Y:%M:%D %H:%M",))

glimpse(data_processed)

write.csv(data_processed, "data/processed/data_processed.csv")

