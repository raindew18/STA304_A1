#### Preamble ####
# Purpose: Downloads and saves the data from OpenDataToronto package
# Author: Xueyi Huang
# Date: 23 September 2024
# Contact: rain.huang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")


# This code is based on knowledge from Alexander (2023).

cleaned_data <-
  raw_data |>
  
  # Select interest colomns
  select(`_id`, `OCC_YEAR`, `OCC_MONTH`,`OCC_DOW`,`OCC_DOY`,`OCC_DAY`,
         `OCC_HOUR`,`OCC_TIME_RANGE`,`DEATH`,`INJURIES`,`NEIGHBOURHOOD_158`) |>
  
  # Rename column headers
  rename(`Year` = `OCC_YEAR`,
         `Month` = `OCC_MONTH`,
         `Day_of_Week` = `OCC_DOW`,
         `Day_of_Year` = `OCC_DOY`,
         `Day_of_Month` = `OCC_DAY`,
         `Hour_of_day` = `OCC_HOUR`,
         `Time_range` = `OCC_TIME_RANGE`,
         `Neighbourhood` = `NEIGHBOURHOOD_158`)
  
  # Rename Type of Location entries for clarity
  mutate(`Type of Location` =
           case_match(`Type of Location`,
                      "LTCH" ~ "Long-Term Care Home",
                      "Hospital-Acute Care" ~ "Hospital (Acute Care)",
                      "Retirement Home" ~ "Retirement Home",
                      "Hospital-Chronic Care" ~ "Hospital (Chronic Care)",
                      "Hospital-Psychiatric" ~ "Hospital (Psychiatric)",
                      "Transitional Care" ~ "Transitional Care")) |>
  
  # Renaming some of the Outbreak First Known Cause entries for simplicity
  mutate(`Outbreak First Known Cause` =
           case_match(`Outbreak First Known Cause`,
                      "COVID-19" ~ "COVID-19",
                      "Parainfluenza" ~ "Parainfluenza",
                      "Respiratory syncytial virus" ~
                        "Respiratory syncytial virus",
                      "Metapneumovirus" ~ "Metapneumovirus",
                      "Norovirus" ~ "Norovirus",
                      "Rhinovirus" ~ "Rhinovirus",
                      "Group B Streptococcal disease (neonatal)" ~
                        "Group B Streptococcal disease (neonatal)",
                      "Enterovirus/Rhinovirus" ~ "Enterovirus/Rhinovirus",
                      "Enterovirus" ~ "Enterovirus",
                      "Streptococcus pyogenes" ~ "Streptococcus pyogenes",
                      "Parainfluenza PIV III" ~ "Parainfluenza",
                      "Coronavirus*" ~ "Seasonal coronavirus",
                      "Influenza A (Not subtyped)" ~ "Influenza A",
                      "Influenza A (H3)" ~ "Influenza A",
                      "Influenza A (H1N1)" ~ "Influenza A",
                      "CPE Enterobacter unspecified (NDM)" ~ "CPE",
                      "CPE Unspecified (KPC)" ~ "CPE",
                      "Pending" ~ "Pending/Unknown",
                      "Unable to identify" ~ "Pending/Unknown"))


#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_data.csv") 
