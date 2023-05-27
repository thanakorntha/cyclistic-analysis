# ---------------------- #
#   VISUALIZE THE DATA   #
# ---------------------- #

# Let's visualize the number of rides by rider type
trip_data_v2 %>% 
    group_by(member_casual, day_of_week) %>% 
    summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
    arrange(member_casual, day_of_week)  %>% 
    ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
    geom_col(position = "dodge")

# Let's create a visualization for average duration
trip_data_v2 %>% 
    group_by(member_casual, day_of_week) %>% 
    summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
    arrange(member_casual, day_of_week)  %>% 
    ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) + 
    labs(x = "Day of Week", y = "Average Duration", title = "", subtitle = "", caption = "") +
    geom_col(position = "dodge")