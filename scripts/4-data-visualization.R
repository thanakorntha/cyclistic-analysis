# For palette choices: RColorBrewer::display.brewer.all() 


# ----------------------- #
#   THE NUMBER OF RIDES   #
# ----------------------- #

# TOTAL RIDES TAKEN BY MEMBERS AND CASUAL RIDERS
trip_data_v2 %>% 
    ggplot(aes(x = user_type, fill = bike_type)) + 
    geom_bar() + 
    scale_y_continuous(limits = c(0, 3000000)) + 
    theme(legend.position = "bottom")


# ------------------------- #
#   THE DURATION OF RIDES   #
# ------------------------- #

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


# ------------------------- #
#   THE LOCATION OF RIDES   #
# ------------------------- #

# 
member <- trip_data_v2[which(trip_data_v2$user_type == "member"), ]
casual <- trip_data_v2[which(trip_data_v2$user_type == "casual"), ]

# Get map and plot station locations 
chicago_map <- ggmap(get_stamenmap(
    bbox = c(left = -87.920354, bottom = 41.642283, right = -87.372821, top = 42.110931), 
    zoom = 12, maptype = "terrain"), extent = "device", legend = "bottom")

print(chicago_map)

# START STATION ----

start_casual <- chicago_map + 
    stat_density2d(aes(x = start_lng, y = start_lat, fill = ..level.., alpha = ..level..), 
                   bins = 500, geom = "polygon", 
                   data = casual) + 
    scale_fill_gradient(low = "black", high = "red") +
    facet_wrap(~ day_of_week) + 
    theme(axis.text.x = element_blank(), 
          axis.text.y = element_blank(), 
          axis.ticks = element_blank(), 
          axis.title.x = element_blank(), 
          axis.title.y = element_blank())

print(start_casual)

start_member <- ggmap(chicago_map) + 
    stat_density2d(aes(x = start_lng, y = start_lat, fill = ..level.., alpha = ..level..), 
                   bins = 5000, geom = "polygon", 
                   data = member) + 
    scale_fill_gradient(low = "black", high = "red") +
    facet_wrap(~ day_of_week) + 
    theme(axis.text.x = element_blank(), 
          axis.text.y = element_blank(), 
          axis.ticks = element_blank(), 
          axis.title.x = element_blank(), 
          axis.title.y = element_blank())

print(start_member)

# END STATION ----

ggmap(chicago_map) + 
    stat_density2d(aes(x = end_lng, y = end_lat, fill = ..level.., alpha = ..level..), 
                   bins = 5000, geom = "polygon", 
                   data = casual) + 
    scale_fill_gradient(low = "black", high = "red") +
    facet_wrap(~ day_of_week) + 
    theme(axis.text.x = element_blank(), 
          axis.text.y = element_blank(), 
          axis.ticks = element_blank(), 
          axis.title.x = element_blank(), 
          axis.title.y = element_blank())

ggmap(chicago_map) + 
    stat_density2d(aes(x = x = end_lng, y = end_lat, fill = ..level.., alpha = ..level..), 
                   bins = 5000, geom = "polygon", 
                   data = member) + 
    scale_fill_gradient(low = "black", high = "red") +
    facet_wrap(~ day_of_week) + 
    theme(axis.text.x = element_blank(), 
          axis.text.y = element_blank(), 
          axis.ticks = element_blank(), 
          axis.title.x = element_blank(), 
          axis.title.y = element_blank())
