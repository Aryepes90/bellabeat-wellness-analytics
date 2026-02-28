# =============================================================================
# Smart Device Usage Analysis — Bellabeat Marketing Strategy
# Author: Andres Rosero Yepes
# Date: 05/02/2023
# Certificate: Google Data Analytics Professional Certificate
# =============================================================================
# Business Task:
# Analyze trends in smart device usage to gain insight into how consumers use
# non-Bellabeat smart devices. Apply insights to the Leaf Wellness Tracker
# product to inform Bellabeat's marketing strategy.
# =============================================================================

# -----------------------------------------------------------------------------
# STEP 1: INSTALL AND LOAD PACKAGES
# -----------------------------------------------------------------------------

install.packages("tidyverse")
install.packages("here")
install.packages("skimr")
install.packages("janitor")
install.packages("dplyr")
install.packages("ggplot2")

library(tidyverse)
library(here)
library(skimr)
library(janitor)
library(dplyr)
library(ggplot2)
library(lubridate)
library(readr)

# -----------------------------------------------------------------------------
# STEP 2: IMPORT DATASETS
# -----------------------------------------------------------------------------

activity <- read_csv("dailyActivity.csv")
sleep    <- read_csv("sleepDay.csv")
steps    <- read_csv("dailySteps.csv")

# -----------------------------------------------------------------------------
# STEP 3: EXPLORE DATASETS
# -----------------------------------------------------------------------------

glimpse(activity)
glimpse(sleep)
glimpse(steps)

# Count unique participants per dataframe
n_distinct(activity$Id)  # 33
n_distinct(sleep$Id)     # 24
n_distinct(steps$Id)     # 33

# Count rows per dataframe
nrow(activity)  # 940
nrow(sleep)     # 410
nrow(steps)     # 895

# -----------------------------------------------------------------------------
# STEP 4: DESCRIPTIVE STATISTICS
# -----------------------------------------------------------------------------

# dailyActivity summary
activity %>%
  select(TotalSteps, SedentaryMinutes, Calories) %>%
  summary()
# Key findings:
# - Average steps per day: 7,638
# - Average sedentary minutes: 991 (16.5 hours)
# - Average calories burned: 2,304

# sleepDay summary
sleep %>%
  select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed) %>%
  summary()
# Key findings:
# - Average minutes asleep: 419 (6.98 hours)
# - Average time in bed: 458 (7.6 hours)

# dailySteps summary
steps %>%
  select(StepTotal) %>%
  summary()
# Key findings:
# - Average steps per day: 7,997
# Note: Slight difference from dailyActivity (7,638) due to different row counts

# -----------------------------------------------------------------------------
# STEP 5: DATA VISUALIZATION — RELATIONSHIPS AND TRENDS
# -----------------------------------------------------------------------------

# --- Plot 1: Total Steps vs. Sedentary Minutes ---
ggplot(data = activity) +
  geom_point(mapping = aes(x = TotalSteps, y = SedentaryMinutes)) +
  geom_smooth(mapping = aes(x = TotalSteps, y = SedentaryMinutes)) +
  labs(
    title = "Total Steps vs. Sedentary Minutes",
    subtitle = "Daily Activity Data Set",
    caption = "Data collected by Mobius, Kaggle.com"
  )

# Correlation coefficient
cor(activity$TotalSteps, activity$SedentaryMinutes)
# Result: -0.33 (negative correlation — fewer steps = more sedentary time)

# --- Plot 2: Total Steps vs. Calories ---
ggplot(data = activity) +
  geom_point(mapping = aes(x = TotalSteps, y = Calories)) +
  geom_smooth(mapping = aes(x = TotalSteps, y = Calories)) +
  labs(
    title = "Total Steps vs. Calories",
    subtitle = "Daily Activity Data Set",
    caption = "Data collected by Mobius, Kaggle.com"
  )

# Correlation coefficient
cor(activity$TotalSteps, activity$Calories)
# Result: 0.59 (positive correlation — more steps = more calories burned)

# --- Plot 3: Total Minutes Asleep vs. Total Time in Bed ---
ggplot(data = sleep) +
  geom_point(mapping = aes(x = TotalMinutesAsleep, y = TotalTimeInBed)) +
  geom_smooth(mapping = aes(x = TotalMinutesAsleep, y = TotalTimeInBed)) +
  labs(
    title = "Total Minutes Asleep vs. Total Time in Bed",
    subtitle = "Sleep Day Data Set",
    caption = "Data collected by Mobius, Kaggle.com"
  )

# Correlation coefficient
cor(sleep$TotalMinutesAsleep, sleep$TotalTimeInBed)
# Result: 0.93 (strong positive correlation)

# -----------------------------------------------------------------------------
# STEP 6: MERGE DATASETS AND ANALYZE COMBINED DATA
# -----------------------------------------------------------------------------

combined <- merge(sleep, activity, by = "Id")

# Check unique participants in combined dataset
n_distinct(combined$Id)  # 24

# --- Plot 4: Total Steps vs. Calories (Combined Dataset) ---
ggplot(data = combined) +
  geom_smooth(mapping = aes(x = TotalSteps, y = Calories)) +
  labs(
    title = "Total Steps vs. Calories",
    subtitle = "Combined Data Set",
    caption = "Data collected by Mobius, Kaggle.com"
  )

cor(combined$TotalSteps, combined$Calories)
# Result: 0.44 (positive correlation confirmed in combined dataset)

# --- Plot 5: Very Active Minutes vs. Calories (Combined Dataset) ---
ggplot(data = combined) +
  geom_smooth(mapping = aes(x = VeryActiveMinutes, y = Calories)) +
  labs(
    title = "Very Active Minutes vs. Calories",
    subtitle = "Combined Data Set",
    caption = "Data collected by Mobius, Kaggle.com"
  )
# Clear positive correlation: more very active minutes = more calories burned

# -----------------------------------------------------------------------------
# STEP 7: DAY OF WEEK ANALYSIS
# -----------------------------------------------------------------------------

# Add Day and DayofWeek columns
combined$Day       <- mdy(combined$ActivityDate)
combined$DayofWeek <- wday(combined$Day, label = TRUE)

# Average Very Active Minutes by Day of Week
combined %>%
  group_by(DayofWeek) %>%
  drop_na() %>%
  summarize(mean_VeryActiveMinutes = mean(VeryActiveMinutes))
# Results:
# Sun: 19.9 | Mon: 28.4 | Tue: 30.0 | Wed: 20.2
# Thu: 22.6 | Fri: 24.0 | Sat: 22.2

# Create summary dataset for plotting
Plot <- combined %>%
  group_by(DayofWeek) %>%
  drop_na() %>%
  summarize(mean_VeryActiveMinutes = mean(VeryActiveMinutes))

# --- Plot 6: Day of Week vs. Average Very Active Minutes ---
ggplot(data = Plot, aes(x = DayofWeek, y = mean_VeryActiveMinutes)) +
  geom_histogram(stat = "identity", fill = "green") +
  labs(
    title = "Day of Week vs. Very Active Minutes — Average",
    subtitle = "Plot Data Set",
    caption = "Data collected by Mobius, Kaggle.com"
  )
# Finding: Activity peaks Mon-Tue and declines toward the weekend

# Weekly average very active minutes summary
Plot %>%
  select(mean_VeryActiveMinutes) %>%
  summary()
# Mean: 23.89 minutes/day | Weekly total: 167.18 minutes
# CDC recommends 225 minutes/week (150 moderate + 75 vigorous)

# =============================================================================
# KEY FINDINGS SUMMARY
# =============================================================================
# 1. Users average 7,638 steps/day — below CDC's 10,000 step recommendation
# 2. Users are sedentary 16.5 hours/day on average
# 3. Steps and calories: positive correlation (r = 0.59)
# 4. Steps and sedentary minutes: negative correlation (r = -0.33)
# 5. Sleep time strongly correlates with time in bed (r = 0.93)
# 6. Very active minutes peak Mon-Tue, decline toward weekend
# 7. Weekly very active minutes (167) fall below CDC guidelines (225)

# =============================================================================
# RECOMMENDATIONS FOR BELLABEAT LEAF WELLNESS TRACKER
# =============================================================================
# 1. Send step goal notifications when users trend below 10,000 steps
# 2. Add hourly sedentary alerts during inactive periods
# 3. Position Leaf as a sleep coach to build consistent bedtime routines
# 4. Show weekly active minutes dashboard vs. CDC 225-minute target
# 5. Send weekend engagement notifications to sustain activity levels
# Reference: https://www.cdc.gov/physicalactivity/walking/index.htm
