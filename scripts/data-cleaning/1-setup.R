# ----- SETUP ENVIRONMENT -----

# Install and load required packages
library(tidyverse)  # Help import data and wrangle data
library(janitor)    # Help clean data
library(ggplot2)    # Help visualize the data
library(ggmap)      # Help visualize the map


# ----- COLLECT DATA -----

# Store a list of file names in data_files
data_files <- list.files("./data/raw-data", pattern = "*.csv")

# Import CSV files into separate data frame using for-loop
for(i in 1:length(data_files)) {
  assign(paste0("trip_", stringr::str_pad(i, 2, pad = 0)), 
         read_csv(paste0("./data/raw-data/", data_files[i])))
}

# Print a summary of each file, showing the number of rows and columns in the data and the data types of each column
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


# ----- COMBINE DATA INTO ONE DATA FRAME -----

# Compare column names each of the files to identify any differences in the data between the months
compare_df_cols(
    trip_01, trip_02, trip_03, trip_04, trip_05, trip_06, 
    trip_07, trip_08, trip_09, trip_10, trip_11, trip_12)

# Combine data frames into a single data frame
trip_data <- bind_rows(trip_01, trip_02, trip_03, 
                       trip_04, trip_05, trip_06, 
                       trip_07, trip_08, trip_09, 
                       trip_10, trip_11, trip_12)

# Create new data frame, ordering by 'started_at'
trip_data_v2 <- trip_data[order(trip_data$started_at), ]


# ----- INSPECT DATA FRAME -----

# Get the names of the columns
colnames(trip_data_v2)

# Get the dimensions of the data, telling how many rows and columns there are in the data frame
dim(trip_data_v2)

# Print the first and last 6 rows of the data to get a better understanding of the data
head(trip_data_v2)
tail(trip_data_v2)

# Print a summary of the data, showing the number of rows and columns in the data, as well as the data types of each column
str(trip_data_v2)
