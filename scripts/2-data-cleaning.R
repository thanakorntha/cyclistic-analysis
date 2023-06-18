# ----------------------------------- #
#   INSPECT PRE-CLEANING DATA FRAME   #
# ----------------------------------- #

# Get the names of the columns
colnames(trip_data)

# Get the dimensions of the data, telling how many rows and columns there are in the data frame
dim(trip_data)

# Print the first and last 6 rows of the data to get a better understanding of the data
head(trip_data)
tail(trip_data)

# Print a summary of the data, showing the number of rows and columns in the data, 
# as well as the data types of each column, the minimum and maximum values, and the mean and standard deviation of each column
summary(trip_data)


# --------------------------- #
#   HANDLE DUPLICATE VALUES   #
# --------------------------- #

# Check if the number of unique values is equal to the number of rows in the 'trip_data' data frame
trip_data %>% 
  summarize(total_ride = n(), 
            unique_ride = length(unique(trip_data$ride_id)))

# See how many observations fall under each bike type and user type
count(trip_data, rideable_type, name = "total_ride")
count(trip_data, member_casual, name = "total_ride")


# -------------------- #
#   FIX STATION NAME   #
# -------------------- #

# Copy a new data frame but with the rows ordered by 'started_at'
trip_data_v2 <- trip_data[order(trip_data$started_at), ]

# Remove 'start_station_id' and 'end_station_id' due to unnecessary for this analysis
trip_data_v2 <- trip_data_v2 %>% 
  select(-c(start_station_id, end_station_id))

# Examine the starting and ending station names
preclean_start_station <- count(trip_data_v2, start_station_name, name = "total_station")
preclean_end_station <- count(trip_data_v2, end_station_name, name = "total_station")

# Remove all rows that have eight test stations in both the starting and ending locations
trip_data_v2 <- trip_data_v2[
  !(trip_data_v2$start_station_name %in% c("Pawel Bialowas - Test- PBSC charging station", 
                                           "Hastings WH 2", 
                                           "DIVVY CASSETTE REPAIR MOBILE STATION", 
                                           "Base - 2132 W Hubbard Warehouse", 
                                           "Base - 2132 W Hubbard", 
                                           "NewHastings", 
                                           "WestChi", 
                                           "WEST CHI-WATSON") | 
    trip_data_v2$end_station_name %in% c("Pawel Bialowas - Test- PBSC charging station", 
                                         "Hastings WH 2", 
                                         "DIVVY CASSETTE REPAIR MOBILE STATION", 
                                         "Base - 2132 W Hubbard Warehouse", 
                                         "Base - 2132 W Hubbard", 
                                         "NewHastings", 
                                         "WestChi", 
                                         "WEST CHI-WATSON")), ]

# Remove all unwanted characters from the starting and ending station names
trip_data_v2 <- trip_data_v2 %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed("*"),           "")) %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed(" - Charging"), "")) %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed(" (Temp)"),     "")) %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed("amp;"),        "")) %>% 
  mutate(end_station_name   = str_replace_all(end_station_name,   fixed("*"),           "")) %>% 
  mutate(end_station_name   = str_replace_all(end_station_name,   fixed(" - Charging"), "")) %>% 
  mutate(end_station_name   = str_replace_all(end_station_name,   fixed(" (Temp)"),     "")) %>% 
  mutate(end_station_name   = str_replace_all(end_station_name,   fixed("amp;"),        ""))


# ------------------------------ #
#   MANIPLULATE MISSING VALUES   #
# ------------------------------ #

# Count the total missing number each column
colSums(is.na(trip_data_v2))

# Remove all rows that have no latitude and longgitude of ending stations
# trip_data_v2 <- trip_data_v2[!(is.na(trip_data_v2$end_lat) | is.na(trip_data_v2$end_lng)), ]

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

# Let's check the starting and ending station names again
postclean_start_station <- count(trip_data_v2, start_station_name, name = "total_station")
postclean_end_station <- count(trip_data_v2, end_station_name, name = "total_station")

# Check to make sure there is no missing values each column
colSums(is.na(trip_data_v2))


# ----------------------------------------------------------------------------- #
#   ADD COLUMNS, LISTING THE MONTH, DAY OF WEEK, AND RIDE LENGTH OF EACH RIDE   #
# ----------------------------------------------------------------------------- #

# Add the 'month' field, displaying in full month
trip_data_v2$month <- format(as.Date(trip_data_v2$started_at), "%B")

# Add the 'day_of_week' field, displaying in full weekday
trip_data_v2$day_of_week <- format(as.Date(trip_data_v2$started_at), "%A")

# Add the 'ride_length' field, displaying in minutes
trip_data_v2$ride_length <- as.double(difftime(trip_data_v2$ended_at, trip_data_v2$started_at, units = "mins"))


# -------------------------- #
#   REMOVE OUTLIER VALUES    #
# -------------------------- #

# Remove all rows that are less than 1 minute or greater than 1440 minutes
# trip_data_v2 <- trip_data_v2[!(trip_data_v2$ride_length < 60 | trip_data_v2$ride_length > 86400), ]
trip_data_v2 <- trip_data_v2[!(trip_data_v2$ride_length < 1 | trip_data_v2$ride_length > 1440), ]

# # Remove outliers
# 
# # Set values to support removing outliers
# median_value <- median(trip_data_v2$ride_length) # Define the average of 'ride_length'
# iqr_value    <- IQR(trip_data_v2$ride_length) # Define the IQR of 'ride_length'
# lower_limit  <- median_value - 3 * iqr_value # Define the limit below Q1
# upper_limit  <- median_value + 3 * iqr_value # Define the limit above Q3
# 
# # Print the results
# print(paste("Median:",      median_value))
# print(paste("IQR:",         iqr_value))
# print(paste("Upper Limit:", upper_limit))
# print(paste("Lower Limit:", lower_limit))
# 
# # Remove all ride trip data, where the 'ride_length' field is less than the 'lower_limit' field or more than the 'upper_limit' field in the 'limit' data frame
# trip_data_v2 <- trip_data_v2[!(trip_data_v2$ride_length < lower_limit | trip_data_v2$ride_length > upper_limit), ]


# ------------------------------------ #
#   INSPECT POST-CLEANING DATA FRAME   #
# ------------------------------------ #

# Get the names of the columns
colnames(trip_data_v2)

# Get the dimensions of the data, telling how many rows and columns there are in the data frame
dim(trip_data_v2)

# Print the first and last 6 rows of the data to get a better understanding of the data
head(trip_data_v2)
tail(trip_data_v2)

# Print a summary of the data, showing the number of rows and columns in the data, 
# as well as the data types of each column, the minimum and maximum values, and the mean and standard deviation of each column
summary(trip_data_v2)
