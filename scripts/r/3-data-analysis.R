# ----------------------------------------------------- #
#   ADJUST ORDER IN THE DAY OF THE WEEK AND THE MONTH   #
# ----------------------------------------------------- #

# Order levels of the day of the week
trip_data_v2$day_of_week <- ordered(trip_data_v2$day_of_week,
                                    levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# Order levels of the month
trip_data_v2$month <- ordered(trip_data_v2$month,
                              levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))


# ------------------- #
#   TOTAL RIDE TRIP   #
# ------------------- #

# See the total number of ride trip data
trip_data_v2 %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type
trip_data_v2 %>%
    group_by(member_casual) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by bike type
trip_data_v2 %>%
    group_by(rideable_type) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type and bike type
trip_data_v2 %>%
    group_by(rideable_type, member_casual) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by weekday
trip_data_v2 %>%
    group_by(day_of_week) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type and weekday
trip_data_v2 %>%
    group_by(day_of_week, member_casual) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by month
trip_data_v2 %>%
    group_by(month) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type and month
trip_data_v2 %>%
    group_by(month, member_casual) %>%
    summarize(ride_count = n()) %>% 
    print(n = 24)


# ----------------- #
#   TRIP DURATION   #
# ----------------- #

# See the total number of ride trip data by user type
trip_data_v2 %>%
    group_by(member_casual) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by bike type
trip_data_v2 %>%
    group_by(rideable_type) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type and bike type
trip_data_v2 %>%
    group_by(rideable_type, member_casual) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by weekday
trip_data_v2 %>%
    group_by(day_of_week) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type and weekday
trip_data_v2 %>%
    group_by(day_of_week, member_casual) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by month
trip_data_v2 %>%
    group_by(month) %>%
    summarize(ride_count = n())

# See the total number of ride trip data by user type and month
trip_data_v2 %>%
    group_by(month, member_casual) %>%
    summarize(ride_count = n()) %>% 
    print(n = 24)


# ----------------- #
#   TRIP DURATION   #
# ----------------- #

# Summarize descriptive analysis on the duration of ride (in seconds)
mean(trip_data_v2$ride_length)
median(trip_data_v2$ride_length)
max(trip_data_v2$ride_length)
min(trip_data_v2$ride_length)
mean(trip_data_v2$ride_length)
median(trip_data_v2$ride_length)
max(trip_data_v2$ride_length)
min(trip_data_v2$ride_length)

# Or condense the four lines above to one line using summary()
summary(trip_data_v2$ride_length)

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
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>%
    arrange(member_casual)

# Summarize descriptive analysis on the duration of ride (in seconds) by member type and weekday
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = mean)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = median)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = max)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = min)

# Or condense the four lines above to one unified code using group_by() and summarize()
trip_data_v2 %>%
    group_by(day_of_week, member_casual) %>%
    summarize(
        min_ride_length        = min(ride_length),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>%
    arrange(day_of_week, member_casual)

# Summarize descriptive analysis on the duration of ride (in seconds) by member type and month
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = mean)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = median)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = max)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = min)

# Or condense the four lines above to one unified code using group_by() and summarize()
trip_data_v2 %>%
    group_by(month, member_casual) %>%
    group_by(day_of_week, member_casual) %>%
    summarize(
        min_ride_length        = min(ride_length),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>%
    arrange(day_of_week, member_casual)

# Summarize descriptive analysis on the duration of ride (in seconds) by member type and month
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = mean)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = median)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = max)
aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = min)

# Or condense the four lines above to one unified code using group_by() and summarize()
trip_data_v2 %>%
    group_by(month, member_casual) %>%
    summarize(
        min_ride_length        = min(ride_length),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>%
    arrange(month, member_casual) %>%
    print(n = 24)


# ---------------- #
#   TOP LOCATION   #
# ---------------- #

# Top 10 starting stations throughout 2022
trip_data_v2 %>%
    group_by(start_station_name) %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# Top 10 ending stations throughout 2022
trip_data_v2 %>%
    group_by(end_station_name) %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# Top 10 starting stations for members
trip_data_v2 %>%
    group_by(member_casual, start_station_name) %>%
    filter(member_casual == 'member') %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# Top 10 ending stations for members
trip_data_v2 %>%
    group_by(member_casual, end_station_name) %>%
    filter(member_casual == 'member') %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# Top 10 starting stations for casual riders
trip_data_v2 %>%
    group_by(member_casual, start_station_name) %>%
    filter(member_casual == 'casual') %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# Top 10 ending stations for casual riders
trip_data_v2 %>%
    group_by(member_casual, end_station_name) %>%
    filter(member_casual == 'casual') %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# Top 50 stations for round-trip
trip_data_v2 %>%
    group_by(member_casual, start_station_name) %>%
    filter(start_station_name == end_station_name) %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>%
    arrange(desc(ride_count)) %>%
    print(n = 50)


# -------------------------------------------- #
#   EXPORT SUMMARY FILE FOR FURTHER ANALYSIS   #
# -------------------------------------------- #

# All ride trip data
write.csv(trip_data_v2, file = "./data/processed-data/trip-data.csv")

