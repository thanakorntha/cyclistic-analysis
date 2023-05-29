# For palette choices: RColorBrewer::display.brewer.all() 


# ---------------------- #
#   VISUALIZE THE DATA   #
# ---------------------- #

trip_data_v2 %>% 
    group_by(user_type) %>% 
    summarise(number_of_rides = n()) %>% 
    ggplot(aes(x = user_type, y = number_of_rides, fill = user_type)) + 
    geom_col(position = "dodge") + 
    guides(fill = "none") + 
    labs(x = "User Type", y = "Number of Rides", title = "Total Number of Rides by User Type")


# ---------------------- #
#   VISUALIZE THE DATA   #
# ---------------------- #

# Let's visualize the number of rides by rider type
trip_data_v2 %>% 
    group_by(user_type, day_of_week) %>% 
    summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
    arrange(user_type, day_of_week)  %>% 
    ggplot(aes(x = day_of_week, y = number_of_rides, fill = user_type)) +
    geom_col(position = "dodge")

# Let's create a visualization for average duration
trip_data_v2 %>% 
    group_by(user_type, day_of_week) %>% 
    summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
    arrange(user_type, day_of_week)  %>% 
    ggplot(aes(x = day_of_week, y = average_duration, fill = user_type)) + 
    labs(x = "Day of Week", y = "Average Duration", title = "", subtitle = "", caption = "") +
    geom_col(position = "dodge")


# -------------------------- #
#   VISUALIZE THE MAP DATA   #
# -------------------------- #

# Let's create Chicago map first
chicago <- get_stamenmap(
    bbox = c(left = -87.920354, bottom = 41.642283, right = -87.372821, top = 42.110931), 
    zoom = 12, 
    maptype = "terrain"
    )

chicago_map <- ggmap(chicago)

chicago_map + trip_data_v2 %>% 
    filter(user_type == 'casual') %>% geom_point(data = trip_data_v2, aes(x = start_lng, y = start_lat), color = "red", size = 2, alpha = 0.5) + theme(legend.position="none")

chicago_map + trip_data_v2 %>% 
    filter(user_type == 'casual') %>% 
    stat_density2d(aes(x = start_lng, y = start_lat, fil = user_type, alpha = 0.5), size = 2, bins = 4, geom = "polygon")
