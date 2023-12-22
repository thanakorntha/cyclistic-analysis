## ----------------- ##
#####   SET UP   ######
## ----------------- ##

# Convert the 'day_of_week' column to a factor variable with a specified level order
trip_data_v2$day_of_week <- ordered(
    trip_data_v2$day_of_week,
    levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
)

# Order the levels of the month from January to December
trip_data_v2$month <- ordered(
    trip_data_v2$month,
    levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
)

# Define function to calculate mode
find_mode <- function(x) {
    u <- unique(x)
    tab <- tabulate(match(x, u))
    u[tab == max(tab)]
}

## --------------------------- ##
#####   SET DATA VARIABLE   #####
## --------------------------- ##

# Group the data by the 'member_casual' column, calculating stats for each group
stats_user <- trip_data_v2 %>%
    group_by(member_casual) %>%
    summarize(
        mean_ride_length = mean(ride_length),
        median_ride_length = median(ride_length),
        min_ride_length = min(ride_length),
        max_ride_length = max(ride_length),
        sd_ride_length = sd(ride_length),
        ride_count = n()
    )

# Group the data by 'member_casual' and 'day_of_week' columns, calculating stats for each group
stats_user_day <- trip_data_v2 %>%
    group_by(member_casual, day_of_week) %>%
    summarize(
        mean_ride_length = mean(ride_length),
        median_ride_length = median(ride_length),
        min_ride_length = min(ride_length),
        max_ride_length = max(ride_length),
        sd_ride_length = sd(ride_length),
        ride_count = n(),
        .groups = "drop"
    )

# Group the data by 'member_casual' and 'hour' columns, calculating stats for each group
stats_user_hour <- trip_data_v2 %>%
    mutate(hour = as.numeric(format(started_at, "%H"))) %>%
    group_by(member_casual, hour) %>%
    summarize(
        mean_ride_length = mean(ride_length),
        median_ride_length = median(ride_length),
        min_ride_length = min(ride_length),
        max_ride_length = max(ride_length),
        sd_ride_length = sd(ride_length),
        ride_count = n(),
        .groups = "drop"
    )

# Group the data by 'member_casual' and 'month' columns, calculating stats for each group
stats_user_month <- trip_data_v2 %>%
    group_by(member_casual, month) %>%
    summarize(
        mean_ride_length = mean(ride_length),
        median_ride_length = median(ride_length),
        min_ride_length = min(ride_length),
        max_ride_length = max(ride_length),
        sd_ride_length = sd(ride_length),
        ride_count = n(),
        .groups = "drop"
    )
