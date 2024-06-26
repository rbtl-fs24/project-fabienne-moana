library(tidyr)
library(dplyr)
library(lubridate)

#clean data
data_processed <- read.csv("data/raw/raw_data.csv")

glimpse(data_processed)

data_processed <- data_processed |> 
  mutate(date_time = as.POSIXct(date_time, "%Y:%M:%D %H:%M",))

data_processed <- data_processed |> 
  mutate(id = seq(1:n())) |> 
  relocate(id)

data_processed <- data_processed |> 
  rename(bin_type = bin.type)

glimpse(data_processed)

#store analysis ready data in processed folder
write.csv(data_processed, "data/processed/data_processed.csv")


#pivot longer (kg) for figure
figure_overview <- data_processed |> 
  mutate(bin_type = as.factor(bin_type)) |> 
  group_by(bin_type) |> 
  summarise(alu_nr = sum(alu_nr),
            alu_kg = sum(alu_kg),
            pet_nr = sum(pet_nr),
            pet_kg = sum(pet_kg),
            paper_kg = sum(paper_kg),
            glas_kg = sum(glas_kg),
            organic_kg = sum(organic_kg),
            general_waste_kg = sum(general_waste_kg),
            total_kg = sum(total_kg)) |> 
  select(-glas_kg, -paper_kg) |> 
  mutate(alu_percentage = alu_kg/total_kg,
         pet_percentage = pet_kg/total_kg,
         organic_percentage = organic_kg/total_kg,
         general_percentage = general_waste_kg/total_kg) |> 
  select(bin_type, alu_percentage, pet_percentage, organic_percentage, general_percentage) |> 
  rename(alu = alu_percentage,
         pet = pet_percentage,
         organic = organic_percentage,
         general_waste = general_percentage) |> 
  filter(bin_type != "waste station") |> 
  pivot_longer(cols = !bin_type,
               names_to = "waste_type",
               values_to = "percentage") 

figure_overview
write.csv(figure_overview, "data/final/figure_overview.csv")

#pivot longer number (pet, alu) for figure
data_long_pa <- data_processed |> 
  mutate(bin_type = as.factor(bin_type)) |> 
  group_by(bin_type) |> 
  summarise(alu_nr = sum(alu_nr),
            alu_kg = sum(alu_kg),
            pet_nr = sum(pet_nr),
            pet_kg = sum(pet_kg),
            paper_kg = sum(paper_kg),
            glas_kg = sum(glas_kg),
            organic_kg = sum(organic_kg),
            general_waste_kg = sum(general_waste_kg),
            total_kg = sum(total_kg)) |> 
  select(-glas_kg, -paper_kg) |> 
  mutate(alu = alu_nr/(alu_nr+pet_nr),
         pet = pet_nr/(alu_nr+pet_nr)) |> 
  select(bin_type, alu, pet) |> 
  filter(bin_type == "alu station" | bin_type == "pet station") |> 
  pivot_longer(cols = !bin_type,
              names_to = "waste_type",
              values_to = "percentage") 
data_long_pa

write.csv(data_long_pa, "data/final/figure_pet_alu.csv")


#preparing data for tables
data_alu <- data_processed |> 
  filter(bin_type == "alu station")|> 
  mutate(percentage_false = pet_nr / (pet_nr + alu_nr) *100) |> 
  select(location, alu_nr, pet_nr, percentage_false)
glimpse(data_alu)
write.csv(data_alu, "data/final/table_alu.csv")

data_pet <- data_processed |> 
  filter(bin_type == "pet station")|> 
  mutate(percentage_false = alu_nr / (alu_nr+pet_nr) *100) |> 
  select(location, alu_nr, pet_nr, percentage_false)
glimpse(data_pet)
write.csv(data_pet, "data/final/table_pet.csv")


