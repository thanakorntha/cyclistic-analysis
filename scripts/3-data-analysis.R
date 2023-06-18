# ----------------------------------------------------- #
#   ADJUST ORDER IN THE DAY OF THE WEEK AND THE MONTH   #
# ----------------------------------------------------- #

# Order the levels of the day of the week from Monday to Sunday
trip_data_v2$day_of_week <- ordered(trip_data_v2$day_of_week, 
                                    levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# Order the levels of the month from January to December
trip_data_v2$month <- ordered(trip_data_v2$month, 
                              levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))


# -------------- #
#   TOTAL TRIP   #
# -------------- #

# Calculate the total number of Cyclistic rides
trip_data_v2 %>% 
    summarize(ride_count = n())

# Calculate the total number of Cyclistic rides by user type
trip_data_v2 %>% 
    group_by(member_casual) %>% 
    summarize(ride_count = n())


# ----------------- #
#   TRIP DURATION   #
# ----------------- #

# Calculate a descriptive summary of Cyclistic rides on the duration of each ride in seconds
# Or use [mean/median/max/min](trip_data_v2$ride_length)
summary(trip_data_v2$ride_length)

# Analyze Cyclistic rides on the duration of each ride by user type
# Or use aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual, FUN = [mean/median/max/min])
trip_data_v2 %>% 
    group_by(member_casual) %>% 
    summarize(
        min_ride_length        = min(ride_length),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>% 
    arrange(member_casual)

# Analyze Cyclistic rides on the duration of each ride by user type and weekday
# Or use aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$day_of_week, FUN = [mean/median/max/min])
trip_data_v2 %>% 
    group_by(member_casual, day_of_week) %>% 
    summarize(
        min_ride_length        = min(ride_length),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>% 
    arrange(day_of_week, member_casual)

# Analyze Cyclistic rides on the duration of each ride by user type and month
# Or use aggregate(trip_data_v2$ride_length ~ trip_data_v2$member_casual + trip_data_v2$month, FUN = [mean/median/max/min])
trip_data_v2 %>% 
    group_by(member_casual, month) %>% 
    summarize(
        min_ride_length        = min(ride_length),
        median_ride_length     = median(ride_length),
        mean_ride_length       = mean(ride_length),
        max_ride_length        = max(ride_length)) %>% 
    arrange(month, member_casual) %>% 
    print(n = 24)


# --------------------------- #
#   TOP 10 POPULAR STATIONS   #
# --------------------------- #

# The 10 most popular starting stations
trip_data_v2 %>% 
    group_by(start_station_name) %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>% 
    top_n(10, ride_count)

# The 10 most popular ending stations
trip_data_v2 %>%
    group_by(end_station_name) %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>% 
    top_n(10, ride_count)


# ----------------------------------------- #
#   TOP 10 POPULAR STATIONS FOR EACH USER   #
# ----------------------------------------- #

# The 10 most popular starting stations for members
trip_data_v2 %>% 
    group_by(member_casual, start_station_name) %>% 
    filter(member_casual == 'member') %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>% 
    top_n(10, ride_count)

# The 10 most popular ending stations for members
trip_data_v2 %>% 
    group_by(member_casual, end_station_name) %>% 
    filter(member_casual == 'member') %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>% 
    top_n(10, ride_count)

# The 10 most popular starting stations for casual riders
trip_data_v2 %>%
    group_by(member_casual, start_station_name) %>%
    filter(member_casual == 'casual') %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)

# The 10 most popular starting stations for casual riders
trip_data_v2 %>%
    group_by(member_casual, end_station_name) %>%
    filter(member_casual == 'casual') %>%
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>%
    top_n(10, ride_count)


# ------------------------------------ #
#   TOP STATIONS FOR ROUND-TRIP RIDE   #
# ------------------------------------ #

# The 25 most popular round-trip stations for round-trip
trip_data_v2 %>% 
    group_by(member_casual, start_station_name) %>% 
    filter(start_station_name == end_station_name) %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>%
    print(n = 25)

# The 25 most popular round-trip stations for 
trip_data_v2 %>% 
    group_by(member_casual, start_station_name) %>% 
    filter(start_station_name == end_station_name, member_casual == 'member') %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>%
    print(n = 25)

# The 25 most popular round-trip stations 
trip_data_v2 %>% 
    group_by(member_casual, start_station_name) %>% 
    filter(start_station_name == end_station_name, member_casual == 'casual') %>% 
    summarize(
        ride_count = n(), 
        mean_ride_length = mean(ride_length)) %>% 
    arrange(desc(ride_count)) %>%
    print(n = 25)


# -------------------------------------------- #
#   EXPORT SUMMARY FILE FOR FURTHER ANALYSIS   #
# -------------------------------------------- #

# Export full ride trip data for data visualization
write.csv(trip_data_v2, file = "./data/processed-data/trip-data.csv")

# Export station data
# write.csv(start_station, file = "./data/processed-data/start-station-pre.csv")
# write.csv(start_station_v2, file = "./data/processed-data/start-station-post.csv")
# write.csv(end_station, file = "./data/processed-data/end-station-pre.csv")
# write.csv(end_station_v2, file = "./data/processed-data/end-station-post.csv")
