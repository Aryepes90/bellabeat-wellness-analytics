# Smart Device Usage Analysis — Bellabeat Marketing Strategy
### Google Data Analytics Certificate | Capstone Project

[![R](https://img.shields.io/badge/R-4.2-blue.svg)](https://www.r-project.org/)
[![tidyverse](https://img.shields.io/badge/tidyverse-2.0-orange.svg)](https://www.tidyverse.org/)
[![ggplot2](https://img.shields.io/badge/ggplot2-visualization-green.svg)](https://ggplot2.tidyverse.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Overview

Bellabeat is a high-tech wellness company that designs health-focused smart products for women. This project analyzes smart device usage data from Fitbit users to identify behavioral trends that can inform Bellabeat's marketing strategy for its **Leaf Wellness Tracker** — a wearable that monitors activity, sleep, and stress.

The analysis follows the **Ask → Prepare → Process → Analyze → Share → Act** framework used in professional data analytics engagements.

---

## Business Problem

**How do consumers use non-Bellabeat smart devices, and how can those behavioral trends be applied to Bellabeat's marketing strategy?**

Specifically:
- What are the dominant patterns in daily activity, sleep, and calorie expenditure?
- Which behaviors correlate most strongly with health outcomes?
- How can the Leaf Wellness Tracker be positioned as a personal health coach based on these insights?

---

## Dataset

- **Source:** [FitBit Fitness Tracker Data — Kaggle (CC0: Public Domain)](https://www.kaggle.com/datasets/arashnic/fitbit)
- **Origin:** Survey via Amazon Mechanical Turk, March–May 2016; 30 eligible Fitbit users
- **Tables used:**

| Table | Rows | Key Variables |
|---|---|---|
| `dailyActivity_merged.csv` | 940 | Steps, distance, active minutes, calories |
| `sleepDay_merged.csv` | 410 | Sleep records, minutes asleep, time in bed |
| `dailySteps_merged.csv` | 895 | Daily step totals |

**Limitations:** Small sample (33 unique participants), self-reported survey data from 2016, women-only target market but no gender metadata in the dataset.

---

## Methodology

### Tools
- **R** with `tidyverse`, `ggplot2`, `dplyr`, `lubridate`, `skimr`, `janitor`, `here`
- **Google Sheets** — initial data cleaning (duplicate removal, TRIM formatting)
- **RStudio Cloud** — analysis environment

### Process
1. **Prepare** — Assessed data integrity, identified format (long/wide), verified ROCCC criteria (Comprehensive, Current, Cited, Original, Consistent)
2. **Process** — Removed duplicates, standardized date formats, converted activity dates to day-of-week labels using `lubridate`
3. **Analyze** — Computed descriptive statistics per dataset, calculated Pearson correlation coefficients across key variable pairs, merged `dailyActivity` and `sleepDay` on participant ID
4. **Share** — Built scatter plots, smooth trend lines, and bar histograms using `ggplot2` to visualize relationships

---

## Key Findings

### Activity Patterns
- Users averaged **7,638 steps per day** — below the CDC-recommended 10,000 steps
- Users spent an average of **991 sedentary minutes per day (16.5 hours)** — a significant health risk indicator
- Steps and sedentary minutes showed a **negative correlation (r = -0.33)**: less movement = more inactivity

### Calorie Expenditure
- Average daily calorie burn: **2,304 calories**
- Strong positive correlation between steps and calories burned: **r = 0.59**
- Even stronger correlation between very active minutes and calories: clear positive relationship in the combined dataset

### Sleep Behavior
- Average sleep: **6.98 hours** (419 minutes)
- Average time in bed: **7.6 hours** (458 minutes)
- Very strong correlation between time in bed and actual sleep: **r = 0.93** — though outliers suggest some users experience restless sleep

### Weekly Activity Rhythm
- Physical activity peaked on **Monday and Tuesday**, then declined toward the weekend
- Average very active minutes per day: **23.89 minutes**
- Weekly total of very active minutes: **167.18 minutes** — below CDC guidelines of 150 moderate + 75 vigorous (225 total) for adults

---

## Recommendations for Bellabeat

**1. Step Goal Notifications**
Users average 7,638 steps — 24% below the CDC's 10,000-step target. The Leaf Wellness Tracker should send mid-day nudges when users are trending below goal, framed around calorie burn impact.

**2. Sedentary Alerts**
With 16.5 hours of daily inactivity on average, hourly movement reminders during sedentary periods would directly address the most actionable behavioral gap.

**3. Sleep Coaching Feature**
The 0.93 correlation between time in bed and minutes asleep confirms that bedtime consistency drives sleep quality. Bellabeat can position the Leaf as a sleep coach that helps users build and maintain bedtime routines.

**4. Weekly Activity Targets**
Users fall short of CDC weekly activity guidelines. A weekly progress dashboard showing active minutes vs. the 225-minute target (150 moderate + 75 vigorous) would motivate users to close the gap — especially relevant for the Monday–Tuesday peak when users are most motivated.

**5. Weekend Engagement Campaigns**
Activity drops significantly toward the weekend. Targeted push notifications or social challenges on Fridays and Saturdays could sustain engagement through the weekly low points.

---

## Ethical Considerations

- Data is from a voluntary survey with 30 participants — findings are directional, not statistically generalizable
- No personally identifiable information was used; all analysis is at the aggregate or anonymized ID level
- Wellness recommendations are based on CDC guidelines and should be treated as motivational tools, not medical advice

---

## Tech Stack

- **R 4.2** — primary analysis language
- `tidyverse` — data manipulation and visualization ecosystem
- `ggplot2` — all visualizations
- `lubridate` — date/time parsing and day-of-week extraction
- `dplyr` — data transformation and grouping
- `skimr` / `janitor` — data quality assessment and cleaning
- **Google Sheets** — pre-processing and deduplication

---

## Project Structure

```
bellabeat-wellness-analytics/
│
├── bellabeat_analysis.R         # Main analysis script
├── dailyActivity.csv            # Activity dataset
├── sleepDay.csv                 # Sleep dataset
├── dailySteps.csv               # Steps dataset
└── README.md                    # This file
```

---

## How to Run

```r
# Install required packages
install.packages(c("tidyverse", "here", "skimr", "janitor", "ggplot2", "dplyr", "lubridate"))

# Load libraries
library(tidyverse)
library(lubridate)
library(ggplot2)

# Load datasets
activity <- read_csv("dailyActivity.csv")
sleep    <- read_csv("sleepDay.csv")
steps    <- read_csv("dailySteps.csv")
```

---

## Certificate Context

This project is the capstone of the **Google Data Analytics Professional Certificate**, completed in 2023. It demonstrates the full analytics workflow — business problem framing, data preparation, exploratory analysis, correlation modeling, and stakeholder-oriented recommendations — using R as the primary tool.

---

## Author

**Andres Rosero Yepes** | [GitHub](https://github.com/Aryepes90) | [LinkedIn](https://linkedin.com/in/andresrosero)

*Currently pursuing: M.S. Data Science — Illinois Institute of Technology | Certificate in Python for Finance (CPF) — The Python Quants*
