# --------------------- #
#   SETUP ENVIRONMENT   #
# --------------------- #

# Install and load required packages
library(tidyverse) # Help importing data and wrangling data
library(janitor) # Help cleaning data


# ---------------- #
#   COLLECT DATA   #
# ---------------- #

# Read CSV files into separate variables
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

# Print a summary of each file, showing the number of rows and columns in the data, as well as the data types of each column
str(trip_01)
str(trip_02)
str(trip_03)
str(trip_04)
str(trip_05)
str(trip_06)
str(trip_07)
str(trip_08)
str(trip_09)
str(trip_10)
str(trip_11)
str(trip_12)


# ---------------------------------------- #
#   CHECK DATA AND COMBINE INTO ONE FILE   #
# ---------------------------------------- #

# Compare column names each of the files to identify any differences in the data between the months
compare_df_cols(trip_01, trip_02, trip_03, trip_04, trip_05, trip_06, trip_07, trip_08, trip_09, trip_10, trip_11, trip_12)

# Combine month's data frames into a single data frame
trip_data <- bind_rows(trip_01, trip_02, trip_03, trip_04, trip_05, trip_06, trip_07, trip_08, trip_09, trip_10, trip_11, trip_12)

# Rename two columns to make them more meaningful
trip_data <- rename(trip_data, 
                    bike_type = rideable_type,
                    user_type = member_casual)


# ---------------------- #
#   INSPECT DATA FRAME   #
# ---------------------- #

# Get the names of the columns
colnames(trip_data)

# Print a summary of the data, showing the number of rows and columns in the data, as well as the data types of each column
str(trip_data)
