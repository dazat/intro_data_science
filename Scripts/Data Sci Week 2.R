

#Data reading packages "Rio" and "readr"
library(needs)
needs(tidyverse, rio, here, knitr, kableExtra, misty, janitor, rstatix, psych, misty, haven, car, dplyr)

#Reading Data into R ----

#here is a function to print a pathname
here()
#top level of our directory
here("data")
#really just adds this string to the end of the top level folder

eclsk <- read.sav(here("data/ecls-k_samp.sav"), use.value.labels = TRUE)
view(eclsk)
str(eclsk)

read_scores <- read.csv(here("data/Project_Reads_scores.csv"))
view(read_scores)
str(read_scores)

#See the files in a folder
list.files(here("data"))

#Can use import function from rio, will import CSV, Sav, and txt
#Setclass and as_tibble do the same thing and save as a tibble

#Sav file
eclsk <- import(here("data/ecls-k_samp.sav"), setclass = "tbl_df")

#txt file
fatality <- import(here("data", "Fatality.txt")) %>%
  as_tibble()

#csv file
exam1 <- import(here("data", "Project_Reads_Scores.csv")) %>%
  as_tibble() %>%
  janitor::clean_names()
#If we clean the names using janitor we can use export

#We can also export data which essentially just saves the file
#This one does not work because invalid SPSS variable names
export(exam1, here("data", "exam1.sav"))

#This one works
export(exam1, here("data", "exam1.txt"))

#This mostly works but 'Test Year' has an illegal character
export(exam1, here("data", "exam1.dta"))

?export

#Convert is an option to change file types
#Convert(file_in, file_out)
#convert(here("data", 
 
#This is a way to observe data that is hidden in the labels
#The first code just tells us the code in binary (0 or 1)
eclsk %>%
  select(child_id, k_type:sex) %>%
  head()

#The characterize function takes the hidden info and displays it
eclsk %>%
  characterize() %>%
  select(child_id, k_type:sex) %>%
  head()

#factorize() is also a helpful function to return factor variables

###############################
#Reading data using readr ----
##############################

#readr is another option to read files. It is part of tiddyverse package
#except read_sav which is from the haven package

#write_ is another way to export files
#write_csv(x, file)


######### Scripts (.r basic file)
#AND r markdown (More sophisticated: .Rmd)
### Code and Text


penguins <- read.csv(here("data/Penguins.csv")) %>%
  as.tibble() %>%
  janitor::clean_names()
view(penguins)
str(penguins)

#skimr package provides data summary
#Use the skim function






