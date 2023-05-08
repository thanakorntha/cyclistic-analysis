# ----------------------------------------------------- #
#   ADJUST ORDER IN THE DAY OF THE WEEK AND THE MONTH   #
# ----------------------------------------------------- #

# Order the levels of the 'day_of_week' field
trip_data_v2$day_of_week <- ordered(trip_data_v2$day_of_week,
                                    levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# Order the levels of the 'month' field
trip_data_v2$month <- ordered(trip_data_v2$month,
                              levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))


# -------------------------------- #
#   CONDUCT DESCRIPTIVE ANALYSIS   #
# -------------------------------- #

# Summarise descriptive analysis on ride_length using summary() on the 'ride_length' field (in seconds)
summary(trip_data_v2$ride_length)

# Count the total number of ride trip data
trip_data_v2 %>%
    summarise(ride_count = n())

# Count the total number of ride trip data by rider types
trip_data_v2 %>%
    group_by(member_casual) %>%
    summarise(ride_count = n())

# Calculate the mean, median, max, and min ride length for members and casual riders
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = mean)    # average number of ride length
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = median)  # midpoint number of ride length
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = max)     # longest ride
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = min)     # shortest ride

# Or you can condense the four lines above to one line using summarise()
trip_data_v2 %>%
    group_by(member_casual) %>%
    summarise(
        mean_ride_length   = mean(ride_length),
        median_ride_length = median(ride_length),
        max_ride_length    = max(ride_length),
        min_ride_length    = min(ride_length))

