# ----------------------------------- #
#   INSPECT PRE-CLEANING DATA FRAME   #
# ----------------------------------- #

# List column names in the 'trip_data' data frame
colnames(trip_data)

# See the number of rows and columns of the 'trip_data' data frame
dim(trip_data) 

# See the first 6 rows of the 'trip_data' data frame [also tail()]
head(trip_data)

# See list of columns and data types (numeric, character, etc) in the 'trip_data' data frame
str(trip_data) 

# Summarize descriptive statistics of the 'trip_data' data frame
summary(trip_data)


# --------------------------- #
#   HANDLE DUPLICATE VALUES   #
# --------------------------- #

# Check number of unique ride trip data compared to number of total ride trip data - return TRUE or FALSE
length(unique(trip_data$ride_id)) == nrow(trip_data)

# List all bike types of ride trip data
count(trip_data, rideable_type)

# List all rider types of ride trip data
count(trip_data, member_casual)


# ------------------------------ #
#   MANIPLULATE MISSING VALUES   #
# ------------------------------ #

# Count the total missing number of ride trip data each column in the data frame
colSums(is.na(trip_data))

# Delete rows with a NA values from the data frame and store in the 'trip_data_v2' variable
trip_data_v2 <- trip_data[complete.cases(trip_data), ]

# See the number of rows and columns of the 'trip_data_v2' data frame
dim(trip_data_v2)


# -------------------- #
#   FIX STATION NAME   #
# -------------------- #

# Check all starting stations
start_station <- count(trip_data_v2,
                       start_station_name,
                       start_station_id)

# Check all ending stations
end_station <- count(trip_data_v2,
                     end_station_name,
                     end_station_id)

# View spreadsheet-style data of starting and ending stations
View(start_station)
View(end_station)

# Remove test station in starting station
trip_data_v2 <- trip_data_v2[!(trip_data_v2$start_station_name == "Pawel Bialowas - Test- PBSC charging station" |
                               trip_data_v2$start_station_name == "Hastings WH 2" |
                               trip_data_v2$start_station_name == "DIVVY CASSETTE REPAIR MOBILE STATION" |
                               trip_data_v2$start_station_name == "Base - 2132 W Hubbard Warehouse" |
                               trip_data_v2$start_station_name == "Base - 2132 W Hubbard" |
                               trip_data_v2$start_station_name == "NewHastings" |
                               trip_data_v2$start_station_name == "WestChi" |
                               trip_data_v2$start_station_name == "WEST CHI-WATSON"), ]

# Remove test station in ending station
trip_data_v2 <- trip_data_v2[!(trip_data_v2$end_station_name == "Pawel Bialowas - Test- PBSC charging station" |
                               trip_data_v2$end_station_name == "Hastings WH 2" |
                               trip_data_v2$end_station_name == "DIVVY CASSETTE REPAIR MOBILE STATION" |
                               trip_data_v2$end_station_name == "Base - 2132 W Hubbard Warehouse" |
                               trip_data_v2$end_station_name == "Base - 2132 W Hubbard" |
                               trip_data_v2$end_station_name == "NewHastings" |
                               trip_data_v2$end_station_name == "WestChi" |
                               trip_data_v2$end_station_name == "WEST CHI-WATSON"), ]

# Change some small error text in starting and ending stations
trip_data_v2 <- trip_data_v2 %>%
    mutate(start_station_name = str_replace_all(start_station_name, fixed("*"),           "")) %>%
    mutate(start_station_name = str_replace_all(start_station_name, fixed(" - Charging"), "")) %>%
    mutate(start_station_name = str_replace_all(start_station_name, fixed(" (Temp)"),     "")) %>%
    mutate(start_station_name = str_replace_all(start_station_name, fixed("amp;"),        "")) %>%
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed("*"),           "")) %>%
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed(" - Charging"), "")) %>%
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed(" (Temp)"),     "")) %>%
    mutate(end_station_name   = str_replace_all(end_station_name,   fixed("amp;"),        ""))

# Check all starting stations again
start_station_v2 <- count(trip_data_v2,
                          start_station_name,
                          start_station_id)

# Check all ending stations again
end_station_v2 <- count(trip_data_v2,
                        end_station_name,
                        end_station_id)

# View spreadsheet-style data of starting and ending stations
View(start_station_v2)
View(end_station_v2)

# Remove "start_station_id" and "end_station_id" columns due to not necessity
trip_data_v2 <- trip_data_v2 %>%
    select(-c(start_station_id, end_station_id))

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

# List column names in the 'trip_data_v2' data frame
colnames(trip_data_v2)

# See the number of rows and columns of the 'trip_data_v2' data frame
dim(trip_data_v2)

# See the first 6 rows of the 'trip_data_v2' data frame [also tail()]
head(trip_data_v2)

# See list of columns and data types (numeric, character, etc) in the 'trip_data_v2' data frame
str(trip_data_v2)

# Summarize descriptive statistics of the 'trip_data_v2' data frame
summary(trip_data_v2)

