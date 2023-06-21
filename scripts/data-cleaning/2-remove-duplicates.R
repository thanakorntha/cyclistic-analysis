# ----- REMOVE IRRELEVANT COLUMNS -----

# Remove 'start_station_id' and 'end_station_id' due to unnecessary for this analysis
trip_data_v2 <- trip_data_v2 %>% 
  select(-c(start_station_id, end_station_id))


# ----- UNIQUE RIDE ID -----

# Check if the number of unique values is equal to the number of rows in the 'trip_data' data frame
trip_data %>% 
  summarize(total_ride = n(), 
            unique_ride = length(unique(trip_data$ride_id)))


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
