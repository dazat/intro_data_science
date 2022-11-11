

library(needs)
needs(tidyverse, dplyr, palmerpenguins)

str(penguins)

cor(x = penguins[3:6], y = NULL, use = "pairwise.complete.obs") %>%
  round(digits = 2)

penguins %>%
  select_if(is.numeric)%>%
  filter(!is.na(body_mass_g),
         !is.na(flipper_length_mm),
         !is.na(bill_length_mm),
         !is.na(bill_depth_mm)) %>%
  cor(use = "everything") %>%
  round(digits = 2)

penguins %>%
  select_if(is.numeric)%>%
  cor(use = "pairwise.complete.obs") %>%
  round(digits = 2)