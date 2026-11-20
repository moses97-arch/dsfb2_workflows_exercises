library(tidyverse)
library(readxl)

# Read the excel sheet All cycles and skip 11
all_cycles_sheet <- read_excel(
  here::here(
    "data",
    "salmonella CFU kinetics OD600 in LB van ipecs 8okt2020 kleur.xlsx"
  ),
  sheet = "All Cycles",
  skip = 11
)

# Select all the time colums and tidy the data by converting it to one column
time_col <- names(all_cycles_sheet[3:length(names(all_cycles_sheet))])
all_cycles_sheet %>% pivot_longer(cols = time_col,
                                  names_to = "time",
                                  values_to = "measurement (600)") -> tidy_all_cycles

# Rename the 2 starting columns
colnames(tidy_all_cycles)[1:2] <- c("Well", "Content")

# Create sample data
layout_sheet <- read_excel(
  here::here(
    "data",
    "salmonella CFU kinetics OD600 in LB van ipecs 8okt2020 kleur.xlsx"
  ),
  sheet = "layout"
)

sample_data <- data.frame()