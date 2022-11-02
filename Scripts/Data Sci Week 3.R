#Data Science Week 3

#Datapasta For Importing Data
## Really copying and pasting data

##### 
## In to the tidyverse
#Packages
## ggplot2

##### 
# Data visualization

#R graph gallery
##Website for different R graphs and the code


library(tidyverse)
library(needs)

#Dataset for class
install.packages('palmerpenguins')
library(palmerpenguins)

ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(color='cornflower blue')+
  geom_smooth(method = 'lm', color='magenta', level = 0.68)+
  theme_bw()

#Level changes the confidence interval
#se TRUE or FALSE changes if the confidence interval is shown

#Table let us access specific column info
table(penguins$species)

ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(aes(color=species))+
  geom_smooth(method = 'lm', color='magenta', se = FALSE)+
  theme_minimal()+
  labs(title = "Penguin Body Weights by Bill Length", subtitle = "Grouped by Penguin Species", x="Bill Length (mm)", y='Body Mass (g)')


#Can look up named color using hex colors online
#Hex codes including # must go in quote


#Can upload themes from ggthemes
##Includes colorblind option

install.packages('ggthemes')
needs(ggthemes)
install.packages('scales')
needs(scales)

ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(aes(color=species))+
  geom_smooth(method = 'lm', color='magenta', se = FALSE)+
  theme_fivethirtyeight()+
  scale_colour_colorblind()+
  labs(title = "Penguin Body Weights by Bill Length", subtitle = "Grouped by Penguin Species", x="Bill Length (mm)", y='Body Mass (g)')

#The scales_colour_colorblind is the code for the color blind points

#####
## Use line graphes when time is involved

ggplot(economics, aes(date, unemploy))+
  geom_line()+
  geom_smooth()


#####
#Adding Labs is another function
#Use labs() function

ggplot(economics, aes(date, unemploy))+
  geom_line()+
  geom_smooth()+
  labs(title="Unemployment over Time", subtitle = "Date from Economics Dataset", x='Date', y='Unemployment')

#####
#Facets
## facet_wrap function

ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)+
  scale_colour_colorblind()+
  labs(title = "Penguin Body Weights by Bill Length", subtitle = "Grouped by Penguin Species", x="Bill Length (mm)", y='Body Mass (g)')+
  facet_wrap(~species)


#####
#Heat maps
## Examples with correlations
#Joe doesn't like heat maps
#geom_tile is the function for heat maps
#scale_fill_viridis_c() for colorblind scale

corr <- cor(mtcars)
pc <- corr %>% 
  as.data.frame() %>% 
  mutate(row = rownames(.)) %>% 
  pivot_longer(
    cols = -row,
    names_to = "col",
    values_to = "cor")
head(pc)

ggplot(pc, aes(row,col,fill=cor))+
  geom_tile()+
  scale_fill_viridis_c()

##### 
#categorical Data
##Histograms

#install.packages("fivethirtyeight")
library(fivethirtyeight)
# View(college_grad_students)
college <- college_grad_students # simpler reference
college

ggplot(college, aes(x = grad_total)) +
  geom_histogram(alpha = 0.7)

#Fill is used to fill a histogram
#Color is for the outline

ggplot(college, aes(x = grad_total)) +
  geom_histogram(aes(fill=major_category), alpha = 0.7)

#####
#Density plot
#y axis is difficult to explain
ggplot(college, aes(x=grad_total))+
  geom_density(alpha=0.2)+
  facet_wrap(~major_category)

#Density ridges are even better
#But we need a new package

#install.packages('ggridges')
needs(ggridges)

ggplot(college, aes(x = grad_total, y = major_category))+
  geom_density_ridges()


#And now back to the penguins
ggplot(penguins, aes(bill_length_mm, species))+
  geom_density_ridges(aes(fill = factor(year)), alpha=0.4)+
  scale_fill_viridis_d(option = 'plasma')
#We can makes layered fun graphs



#####
#boxplots
#Finally let's use a database on candy

candy <- candy_rankings %>% 
  pivot_longer(
    cols = chocolate:pluribus,
    names_to = "type",
    values_to = "foo") %>% 
  filter(foo) %>% 
  select(-foo)
candy

ggplot(candy, aes(type, sugarpercent)) +
  geom_boxplot()

#####
#Violin plot
#Which I personally don't like
ggplot(candy, aes(type, sugarpercent)) +
  geom_violin()


#Bar charts can be handy
#Two types: geom_bar and geom_col

#geom_bar
##uses count by default
## uses x OR y
ggplot(mpg, aes(class)) + # one variable in the `aes()`
  geom_bar() # counts the rows per class


#New data set
summarized_mpg <- mpg %>% 
  group_by(class) %>% 
  count()
head(summarized_mpg)


#geom_col
##Does not use counts by default
## Uses X AND Y
ggplot(summarized_mpg, aes(class, n)) + # two variables in the `aes()`
  geom_col() # data has the rows per class in "n"

#Then we can manually order our data
##This looks at the mpg for each type
(mean_hmiles <- mpg %>% 
    group_by(class) %>% 
    summarize(mean_hwy = mean(hwy)))

#Then we can manually reorder them
mean_hmiles %>%
  mutate(class = factor(class,
                        levels = c("pickup",
                                   "suv",
                                   "minivan",
                                   "2seater",
                                   "midsize",
                                   "subcompact",
                                   "compact"))) %>%
  ggplot(aes(class, mean_hwy)) + 
  geom_col()


#####
#Finally more bar plots
#New data

eclsk <- haven::read_sav(here::here("data", "ecls-k_samp.sav")) %>% 
  rio::characterize() %>% 
  janitor::clean_names()
ecls_smry <- eclsk %>%
  group_by(k_type, ethnic) %>%
  summarize(t1r_mean = mean(t1rscale))
ecls_smry

#New Bar plot
ggplot(ecls_smry, aes(ethnic, t1r_mean)) +
  geom_col(aes(fill = k_type),
           position = "dodge")

#But we can't read the labels
##So let's flip the coordinates
ggplot(ecls_smry, aes(ethnic, t1r_mean)) +
  geom_col(aes(fill = k_type),
           position = "dodge") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  coord_flip()

#We can also do facet_wrap
#And combine them
ggplot(ecls_smry, aes(k_type, t1r_mean, fill = k_type)) +
  geom_col(alpha = 0.8) +
  facet_wrap(~ethnic)







