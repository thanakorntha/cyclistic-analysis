# --------------------- #
#   SETUP ENVIRONMENT   #
# --------------------- #

# Install and load required packages
library(tidyverse)  # Help importing data and wrangling data
library(janitor)    # Help cleaning data


# ---------------- #
#   COLLECT DATA   #
# ---------------- #

# Upload each dataset (csv file) into a separate variable named 'trip_01' through 'trip_12'
trip_01 <- read_csv("./data/raw-data/202201-divvy-tripdata.csv")
trip_02 <- read_csv("./data/raw-data/202202-divvy-tripdata.csv")
trip_03 <- read_csv("./data/raw-data/202203-divvy-tripdata.csv")
trip_04 <- read_csv("./data/raw-data/202204-divvy-tripdata.csv")
trip_05 <- read_csv("./data/raw-data/202205-divvy-tripdata.csv")
trip_06 <- read_csv("./data/raw-data/202206-divvy-tripdata.csv")
trip_07 <- read_csv("./data/raw-data/202207-divvy-tripdata.csv")
trip_08 <- read_csv("./data/raw-data/202208-divvy-tripdata.csv")
trip_09 <- read_csv("./data/raw-data/202209-divvy-tripdata.csv")
trip_10 <- read_csv("./data/raw-data/202210-divvy-tripdata.csv")
trip_11 <- read_csv("./data/raw-data/202211-divvy-tripdata.csv")
trip_12 <- read_csv("./data/raw-data/202212-divvy-tripdata.csv")


# ---------------------------------------- #
#   CHECK DATA AND COMBINE INTO ONE FILE   #
# ---------------------------------------- #

# Compare column names and data types each of the files
compare_df_cols(trip_01, trip_02, trip_03, trip_04, trip_05, trip_06, trip_07, trip_08, trip_09, trip_10, trip_11, trip_12)

# Merge individual month's data frames into one big data frame
trip_data <- bind_rows(trip_01, trip_02, trip_03, trip_04, trip_05, trip_06, trip_07, trip_08, trip_09, trip_10, trip_11, trip_12)

# Check data structure of ride trip data
str(trip_data)
