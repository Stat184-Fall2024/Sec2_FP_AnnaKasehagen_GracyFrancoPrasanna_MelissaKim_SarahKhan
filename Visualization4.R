# Initiating all the libraries to be used
library(tidyr)
library(dplyr)
library(ggplot2)

# loading the raw data via csv file
sleepData <- read.csv("/Users/sarahkhan/Desktop/student_sleep_patterns.csv")

# Cleaning the data by selecting the relevant columsn for visualization 4
CleanedSleepData <- sleepData %>%
  select(University_Year, Sleep_Duration) %>%
  na.omit()

# Taking a quick look at the cleaned data
print(head(CleanedSleepData))

# Getting the stats for the five number summary (for each year)
SleepSummary <- CleanedSleepData %>%
  group_by(University_Year) %>%
  summarize(
    Min = min(Sleep_Duration, na.rm = TRUE),
    Q1 = quantile(Sleep_Duration, 0.25, na.rm = TRUE),
    Median = median(Sleep_Duration, na.rm = TRUE),
    Q3 = quantile(Sleep_Duration, 0.75, na.rm = TRUE),
    Max = max(Sleep_Duration, na.rm = TRUE)
  )

# Print the 5-number summary for personal accuracy
print(SleepSummary)

# Creating the Boxplot visualization for Sleep Duration by University Year
ggplot(CleanedSleepData, aes(x = factor(University_Year), y = Sleep_Duration)) +
  geom_boxplot(fill = "lightblue", color = "blue", alpha = 0.7) +
  labs(
    title = "5-Number Summary of Sleep Duration by University Year",
    x = "University Year",
    y = "Sleep Duration (Hours)"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) 

