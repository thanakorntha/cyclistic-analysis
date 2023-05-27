# ----------------------------------------------------- #
#   ADJUST ORDER IN THE DAY OF THE WEEK AND THE MONTH   #
# ----------------------------------------------------- #

# Order levels of the day of the week
trip_data_v2$day_of_week <- ordered(trip_data_v2$day_of_week,
                                    levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# Order levels of the month
trip_data_v2$month <- ordered(trip_data_v2$month,
                              levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))


# -------------------------------- #
#   CONDUCT DESCRIPTIVE ANALYSIS   #
# -------------------------------- #

# (A) OVERALL RIDE SUMMARY

# See the total number of ride trip data
trip_data_v2 %>%
    summarize(ride_count = n())

# Summarize descriptive analysis on the duration of ride (in seconds)
mean(trip_data_v2$ride_length)    # straight average (total ride length / rides)
median(trip_data_v2$ride_length)  # midpoint number in the ascending array of ride lengths
max(trip_data_v2$ride_length)     # longest ride
min(trip_data_v2$ride_length)     # shortest ride

# Or condense the four lines above to one line using summary()
summary(trip_data_v2$ride_length)


# (B) RIDE SUMMARY BY MEMBER TYPE

# See the total number of ride trip data by member type
trip_data_v2 %>%
    group_by(member_casual) %>%
    summarize(ride_count = n())

# Summarize descriptive analysis on the duration of ride (in seconds) by member type
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = mean)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = median)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = max)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = min)

# Or condense the four lines above to one unified code using group_by() and summarize()
trip_data_v2 %>%
    group_by(member_casual) %>%
    summarize(
        min_ride_length        = min(ride_length),
        quartile1_ride_length  = quantile(ride_length, 0.25),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        quartile3_ride_length  = quantile(ride_length, 0.75),
        max_ride_length        = max(ride_length)) %>%
    arrange(member_casual)


# (C) RIDE SUMMARY BY MEMBER TYPES AND WEEKDAY

# See the total number of ride trip data by member type
trip_data_v2 %>%
    group_by(member_casual, day_of_week) %>%
    summarize(ride_count = n())

# Summarize descriptive analysis on the duration of ride (in seconds) by member type and weekday
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = mean)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = median)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = max)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = min)

# Or condense the four lines above to one unified code using group_by() and summarize()
trip_data_v2 %>%
    group_by(member_casual, day_of_week) %>%
    summarize(
        min_ride_length        = min(ride_length),
        quartile1_ride_length  = quantile(ride_length, 0.25),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        quartile3_ride_length  = quantile(ride_length, 0.75),
        max_ride_length        = max(ride_length)) %>%
    arrange(member_casual, day_of_week)


# -------------------------------------------- #
#   EXPORT SUMMARY FILE FOR FURTHER ANALYSIS   #
# -------------------------------------------- #

write.csv(trip_data_v2, file = "./data/processed-data/trip_data.csv")