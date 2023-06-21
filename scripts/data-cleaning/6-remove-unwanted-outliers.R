# ----- REMOVE BAD VALUES -----

# Remove all rows that are less than 1 minute or greater than 1440 minutes
# trip_data_v2 <- trip_data_v2[!(trip_data_v2$ride_length < 60 | trip_data_v2$ride_length > 86400), ]
trip_data_v2 <- trip_data_v2[!( trip_data_v2$ride_length < 1 | 
                                trip_data_v2$ride_length > 1440), ]


# ----- REMOVE OUTLIERS -----

# Store values to support removing outliers
median_value <- median(trip_data_v2$ride_length)    # Define the average of 'ride_length'
iqr_value <- IQR(trip_data_v2$ride_length)          # Define the IQR of 'ride_length'
lower_limit <- median_value - 1.5 * iqr_value       # Define the limit below Q1
upper_limit <- median_value + 1.5 * iqr_value       # Define the limit above Q3

# Remove all ride trip data, where the 'ride_length' field is less than the 'lower_limit' field or more than the 'upper_limit' field in the 'limit' data frame
trip_data_v2 <- trip_data_v2[!( trip_data_v2$ride_length < lower_limit | 
                                trip_data_v2$ride_length > upper_limit), ]
