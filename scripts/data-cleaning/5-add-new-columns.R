# ----- ADD NEW COLUMNS -----

# Add the 'month' field, displaying in full month
trip_data_v2$month <- format(as.Date(trip_data_v2$started_at), "%B")

# Add the 'day_of_week' field, displaying in full weekday
trip_data_v2$day_of_week <- format(as.Date(trip_data_v2$started_at), "%A")

# Add the 'ride_length' field, displaying in minutes
trip_data_v2$ride_length <- as.double(difftime(trip_data_v2$ended_at, trip_data_v2$started_at, units = "mins"))


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
