# ----- CHECK MISSING VALUES (PRE) -----

# Count the total missing number each column
colSums(is.na(trip_data_v2))


# ----- HANDLE MISSING VALUES -----

# Fill in the missing values in starting station based on latitude and longitude
trip_data_v2 <- trip_data_v2 %>% 
    group_by(start_lat, start_lng) %>% 
    fill(start_station_name, .direction = "downup") %>% 
    ungroup()

# Fill in the missing values in ending station based on latitude and longitude
trip_data_v2 <- trip_data_v2 %>% 
    group_by(end_lat, end_lng) %>% 
    fill(end_station_name, .direction = "downup") %>% 
    ungroup()

# Remove all rows that have any missing values
trip_data_v2 <- trip_data_v2[complete.cases(trip_data_v2), ]


# ----- INSPECT STATION NAMES (POST) -----

# Let's check the starting and ending station names again
postclean_start_station <- count(trip_data_v2, start_station_name, name = "total_station")
postclean_end_station <- count(trip_data_v2, end_station_name, name = "total_station")


# ----- CHECK MISSING VALUES (POST) -----

# Check to make sure there is no missing values each column
colSums(is.na(trip_data_v2))


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
