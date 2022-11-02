#Practice Plots for ggplot
#Tony Daza

library(tidyverse)
library(needs)

head(msleep)

msleep %>%
  filter(!is.na(vore))%>%
  ggplot(aes(x=sleep_total,y=brainwt))+
  geom_point(color='gray')+
  geom_smooth(aes(color=vore), se = FALSE)+
  facet_wrap(~vore)+
  ylim(0,5)+
  scale_fill_viridis_c()+
  theme_minimal()+
  labs()