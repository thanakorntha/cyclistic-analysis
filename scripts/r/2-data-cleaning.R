# ----------------------------------- #
#   INSPECT PRE-CLEANING DATA FRAME   #
# ----------------------------------- #

# Get the names of the columns in the 'trip_data' data frame
# This will allow us to see what data is available in the data frame
colnames(trip_data)

# Get the dimensions of the 'trip_data' data frame
# This will tell us how many rows and columns there are in the data frame
dim(trip_data)

# Print the first and last 6 rows of the 'trip_data' data frame
# This will allow us to see the first and last few rows of data, which will give us a better understanding of the data
head(trip_data)
tail(trip_data)

# Print a summary of the 'trip_data' data frame
# This summary will show us the number of rows and columns in the data, as well as the data types of each column, the minimum and maximum values, and the mean and standard deviation of each column
summary(trip_data)


# --------------------------- #
#   HANDLE DUPLICATE VALUES   #
# --------------------------- #

# Check if the number of unique ride_id values is equal to the number of rows in trip_data
if ( length(unique(trip_data$ride_id)) == nrow(trip_data) ) {
    print("The number of unique ride_id values is equal to the number of rows in trip_data.")
} else {
    print("The number of unique ride_id values is not equal to the number of rows in trip_data.")
}

# Count the number of rides for each bike type
count(trip_data, bike_type)

# Count the number of rides for each user type
count(trip_data, user_type)


# -------------------- #
#   FIX STATION NAME   #
# -------------------- #

# Create a new data frame called 'trip_data_v2' that is a copy of the 'trip_data' data frame, but with the rows ordered by the 'started_at' column
trip_data_v2 <- trip_data[order(trip_data$started_at), ]

# Remove "start_station_id" and "end_station_id" columns due to not necessity
trip_data_v2 <- trip_data_v2 %>% 
    select(-c(start_station_id, end_station_id))

# Create a data frame called 'start_station' that contains the number of trips that started at each station
start_station <- count(trip_data_v2, start_station_name)

# Create a data frame called 'end_station' that contains the number of trips that ended at each station
end_station <- count(trip_data_v2, end_station_name)

# Remove ride trip data with eight test stations in starting and ending stations
trip_data_v2 <- trip_data_v2[!(trip_data_v2$start_station_name %in% c("Pawel Bialowas - Test- PBSC charging station", 
                                                                      "Hastings WH 2", "DIVVY CASSETTE REPAIR MOBILE STATION", 
                                                                      "Base - 2132 W Hubbard Warehouse", 
                                                                      "Base - 2132 W Hubbard", 
                                                                      "NewHastings", 
                                                                      "WestChi", 
                                                                      "WEST CHI-WATSON") | 
                               trip_data_v2$end_station_name   %in% c("Pawel Bialowas - Test- PBSC charging station", 
                                                                      "Hastings WH 2", 
                                                                      "DIVVY CASSETTE REPAIR MOBILE STATION", 
                                                                      "Base - 2132 W Hubbard Warehouse", 
                                                                      "Base - 2132 W Hubbard", 
                                                                      "NewHastings", 
                                                                      "WestChi", 
                                                                      "WEST CHI-WATSON")), ]

# Remove unwanted characters from the starting and ending station names
trip_data_v2 <- trip_data_v2 %>% 
    mutate(start_station_name = str_replace_all(start_station_name, fixed("*"),           "")) %>% 
    mutate(start_station_name = str_replace_all(start_station_name, fixed(" - Charging"), "")) %>% 
    mutate(start_station_name = str_replace_all(start_station_name, fixed(" (Temp)"),     "")) %>% 
    mutate(start_station_name = str_replace_all(start_station_name, fixed("amp;"),        "")) %>% 
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed("*"),           "")) %>% 
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed(" - Charging"), "")) %>% 
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed(" (Temp)"),     "")) %>% 
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed("amp;"),        ""))

# Create a data frame called 'start_station_v2' that contains the number of trips that started at each station
start_station_v2 <- count(trip_data_v2, start_station_name)

# Create a data frame called 'end_station_v2' that contains the number of trips that ended at each station
end_station_v2 <- count(trip_data_v2, end_station_name)


# ------------------------------ #
#   MANIPLULATE MISSING VALUES   #
# ------------------------------ #

# Count the total missing number of ride trip data each column in the data frame
colSums(is.na(trip_data))

# Delete rows with a NA values from the data frame and store in the 'trip_data_v2' variable
trip_data_v2 <- trip_data[complete.cases(trip_data), ]

# Create a function to find the nearest station
find_nearest <- function(lat, lng) {
    # Find the distance between the given point and each station
    distances <- sqrt((lat - trip_data_v2$start_lat)^2 + (lng - trip_data_v2$start_lng)^2)
    
    # Find the index of the station with the shortest distance
    nearest_index <- which.min(distances)
    
    # Return the name and id of the nearest station
    return(df[nearest_index, "start_station_name"])
}

# Apply the function to find the nearest stations for each row
trip_data_v2$nearest_start_station_name <- sapply(trip_data_v2$start_lat, trip_data_v2$start_lng, find_nearest)

# Repeat the same process for the end stations
trip_data_v2$nearest_end_station_name <- sapply(trip_data_v2$end_lat, trip_data_v2$end_lng, find_nearest)

# Write the results to a new file
write.csv(df, "results.csv")








# Delete rows with a NA values from the data frame and store in the 'trip_data_v2' variable
trip_data_v2 <- trip_data[complete.cases(trip_data), ]

# See the number of rows and columns of the 'trip_data_v2' data frame
dim(trip_data_v2)


# ----------------------------------------------------------------------------- #
#   ADD COLUMNS, LISTING THE MONTH, DAY OF WEEK, AND RIDE LENGTH OF EACH RIDE   #
# ----------------------------------------------------------------------------- #

# Add the 'month' field, displaying in full month
trip_data_v2$month <- format(as.Date(trip_data_v2$started_at), "%B")

# Add the 'day_of_week' field, displaying in full weekday
trip_data_v2$day_of_week <- format(as.Date(trip_data_v2$started_at), "%A")

# Add the 'ride_length' field, displaying in seconds
trip_data_v2$ride_length <- as.numeric(difftime(trip_data_v2$ended_at, trip_data_v2$started_at, units = "secs"))

# Sort the data frame based on the 'started_at' field in ascending order
trip_data_v2 <- trip_data_v2[order(trip_data_v2$started_at), ]


# ------------------------------------ #
#   REMOVE ERROR AND OUTLIER VALUES    #
# ------------------------------------ #

# Remove all ride trip data, where the 'ride_length' field is less than 60 seconds
trip_data_v2 <- trip_data_v2[!(trip_data_v2$ride_length < 60), ]

# Set values to support removing outliers
median_value <- median(trip_data_v2$ride_length)  # Define the average of 'ride_length'
iqr_value    <- IQR(trip_data_v2$ride_length)     # Define the IQR of 'ride_length'
lower_limit  <- median_value - 1.5 * iqr_value    # Define the limit below Q1
upper_limit  <- median_value + 1.5 * iqr_value    # Define the limit above Q3

# Print the results
print(paste("Median:",      median_value))
print(paste("IQR:",         iqr_value))
print(paste("Upper Limit:", upper_limit))
print(paste("Lower Limit:", lower_limit))

# Remove all ride trip data, where the 'ride_length' field is less than the 'lower_limit' field or more than the 'upper_limit' field in the 'limit' data frame
trip_data_v2 <- trip_data_v2[!(trip_data_v2$ride_length < lower_limit | trip_data_v2$ride_length > upper_limit), ]


# ------------------------------------ #
#   INSPECT POST-CLEANING DATA FRAME   #
# ------------------------------------ #

# Get the names of the columns in the 'trip_data_v2' data frame
# This will allow us to see what data is available in the data frame
colnames(trip_data_v2)

# Get the dimensions of the 'trip_data_v2' data frame
# This will tell us how many rows and columns there are in the data frame
dim(trip_data_v2) 

# Print the first and last 6 rows of the 'trip_data_v2' data frame
# This will allow us to see the first and last few rows of data, which will give us a better understanding of the data
head(trip_data_v2)
tail(trip_data_v2)

# Print a summary of the 'trip_data_v2' data frame
# This summary will show us the number of rows and columns in the data, as well as the data types of each column, the minimum and maximum values, and the mean and standard deviation of each column
summary(trip_data_v2)
