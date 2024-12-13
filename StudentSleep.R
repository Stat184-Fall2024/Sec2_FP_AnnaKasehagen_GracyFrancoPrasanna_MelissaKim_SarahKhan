#loading packages
library(tidyr)
library(dplyr)
library(rvest)
library(googlesheets4)
library(ggplot2)
library(esquisse)

#reading in the data set

sleepData <- read_sheet("https://docs.google.com/spreadsheets/d/1BszLI2k3ti0AzKrY6msUY5lqblDG-6gQRZBEJUIj5i8/edit?usp=sharing")

View(sleepData)

#selects just the columns applicable for our research questions
CleanedSleepData <- sleepData %>%
  select(4, 5, 9) %>%
  na.omit() #checks for and ignores any values that have NA

View(CleanedSleepData)

#Research question 2:
#How does sleep duration vary between underclassmen and upperclassmen?
#How does physical activity vary between underclassmen and upperclassmen?

Q2SleepData <- CleanedSleepData %>% 
  mutate(
    University_Year = case_match(
      .x = University_Year,
      "1st Year" ~ "Underclassmen",
      "2nd Year" ~ "Underclassmen",
      "3rd Year" ~ "Upperclassmen",
      "4th Year" ~ "Upperclassmen",
      .default = "missing"
    )
  )
#mutates the data frame to create a new one so that 1st and 2nd years are combined for underclassmen and 3rd and 4th years are combined for upperclassmen
View(Q2SleepData)

ggplot(
  data = Q2SleepData,
  mapping = aes(
    x = Sleep_Duration,
    y = Physical_Activity,
    colour = University_Year
   )
  ) +
  geom_smooth(se = TRUE) +
  scale_color_manual(
    values = c(Underclassmen = "#F725DF",
               Upperclassmen = "#3538DC")
  ) +
  labs(
    x = "Sleep Duration (hours)",
    y = "Physical Activity (mins)",
    title = "Sleep Duration x Physical Activity x Class",
    color = "Class"
  ) +
  theme_light()
#creates a visualization that depicts how sleep duration and physical activity vary between underclassmen and upperclassmen

