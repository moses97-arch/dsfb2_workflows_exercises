library(palmerpenguins)
library(tidyverse)

penguins %>% mutate(penguins_id = row_number(), 
                    before = species)

penguins %>% filter(year == 2009) %>% select(species, sex, bill_length_mm) 
