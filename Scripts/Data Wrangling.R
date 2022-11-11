## Intro to Data Science

## Data Cleaning/Wrangling

## Dplyr
### Functions:
#Select() - a subset of columns
#filter() - a subset of rows
#arrange() - sort in ascending/descending order
#group_by() - used with summarize (grouping columns)
#summarize() - create new column according to others using mean() or sd()
#recode()
#rename() 
#mutate() - add new or modify existing column

library(dplyr)
library(needs)
needs(tidyverse, fivethirtyeight, janitor)


#Select helper functions:
## everything()
##stats_with()
##ends_with()
##contains()
##all_of()
##any_of()

#Data set from fivethirtyeight
college_grad_students %>%
  select(major_code, grad_total, grad_sample_size, everything())
str(college_grad_students)

college_grad_short <- college_grad_students %>%
  select(major_code, grad_total, grad_sample_size, grad_employed, 
         grad_employed_fulltime_yearround, grad_unemployed,
         grad_unemployment_rate)


College_cor <- cor(x = college_grad_short, y = NULL, use = "everything") %>%
  round(digits =2)
College_cor

#Starts with refers to column titles
college_grad_students %>%
  select(starts_with("Major"))
#Ends with also refers to column titles
#Contains is also column specific (Like find in word)
#all_of() is helpful to select all of a subset of columns


#Can also reorganize columns using select()
#Just put everything () after the columns of interest

#Relocate() can also be used to reorder columns
#relocate default is to move it to far left
##For example: relocate(party, .after = start)

head(mpg)

#Choose rows that match a condition
filter(mpg,
       cyl == 4)

#& and , are equivalent so comma or &
mpg %>%
  filter(hwy >= 30, cyl == 4, year >= 2000)%>%
  arrange(hwy)

# | which is shift backslash is the Or symbol

#To filter NA variable
# !is.na(variable name)
# is.na is its own function

#There is also a drop_na() function in tidyverse

after2000 <- filter(mpg, year > 2000)
#Then select for a 2 step process

## OR

#One step method
#select(filter(mpg, year > 2000, model, cyl))

#BEST Option
mpg %>%
  filter(year > 2000) %>%
  select(model, cyl)


##### Mutate
mpg <- mpg %>%
  mutate(avg_mpg = mean(hwy) + mean(cty))
#Meh not working exactly how I want but getting there
view(mpg)

#Summarize
#summarize()

#Summarize can calculate and spit out a mean but mutate will attach it to the dataset

#distinct() function can pull out distinct/unique values

##### Group_by()

mpg %>%
  group_by(manufacturer, model, cyl, year) %>%
  summarize(mean_mpg = (mean(cty) + mean(hwy))/2) %>%
  arrange(mean_mpg) %>%
  ggplot(aes(x = manufacturer, y = mean_mpg, color = factor(cyl))) +
  geom_point()+
  scale_color_viridis_d(alpha = 0.8, option = "plasma")+
  theme_dark()+
  facet_wrap(~year)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  labs(x="Manufactor", y = "Mean MPG (Average of City and Highway MPG)", title = "Average MPG by Cylinders and Manufacturer")
  


##### Recode and Rename
#Recode() 
## ifelse()

#Example
#ifelse(manufacturer == "volkswagen", "volkswagen", "others")

mpg %>%
  mutate(vw_vs_other = ifelse(manufacturer == "volkswagen", "volkswagen", "others"))

#To recode numeric into strong must use backticks
#In r, cannot have a variable that starts with a number
mtcars %>% 
  mutate(cyl_str = recode(cyl,
                          `4` = "cylinders4",
                          `6` = "cylinders6",
                          `8` = "cylinders8"))

## Next I will try to joining mtcars and mpg

library(palmerpenguins)


#Can use case_when if you have multiple ifelse statements
penguins %>%
  mutate(species_big = case_when(body_mass_g > 4500 & species == "Adelie" ~ "Adelie_big",
                                 body_mass_g > 4600 & species == "Chinstrap" ~ "Chinstrap_big",
                                 body_mass_g > 6000 & species == "Gentoo" ~ "Gentoo_big",
                                 TRUE ~ "other")) %>%
  janitor::tabyl(species_big)

#Then janitor can make a summary table for us


### Rename( new name = old name)
## Simple way to rename column
### Select() function can also rename
#select(species, home = island, bill_length = bill_length_mm)



##### Homework 4
#Use Teams %>%
  #as_tibble()

#excel doc
## Use skip function to skip the first few rows




