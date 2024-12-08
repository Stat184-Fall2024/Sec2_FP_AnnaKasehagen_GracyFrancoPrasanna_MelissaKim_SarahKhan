#loading packages
library(tidyr)
library(dplyr)
library(rvest)
library(googlesheets4)

#reading in the data set

sleepData <- read_sheet("https://docs.google.com/spreadsheets/d/1BszLI2k3ti0AzKrY6msUY5lqblDG-6gQRZBEJUIj5i8/edit?usp=sharing")

View(sleepData)

#selects just the columns applicable for our research questions
CleanedSleepData <- sleepData %>%
  select(4, 5, 9) %>%
  na.omit() #checks for and ignores any values that have NA

View(CleanedSleepData)
