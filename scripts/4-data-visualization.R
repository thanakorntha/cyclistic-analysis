scale_y_continuous(labels = comma)
theme(legend.position = "bottom")

# ----------------------------- #
#   USER TYPE (MEMBER_CASUAL)   #
# ----------------------------- #

trip_data_v2 %>% 
  ggplot(aes(member_casual, fill = member_casual)) + 
  geom_bar(color = "black", show.legend = FALSE) + 
  scale_fill_brewer(palette = "Pastel1") + 
  geom_text(aes(label = ..count..), 
            stat = "count", 
            position = position_stack(vjust = 0.5)) + 
  labs(title = "The Number of Rides taken by User Type", 
       x = "User Type", 
       y = "Number of Rides")

trip_data_v2 %>% 
  ggplot(aes(member_casual, fill = member_casual)) + 
  geom_bar(color = "black", show.legend = FALSE) + 
  scale_fill_brewer(palette = "Pastel1") + 
  geom_text(aes(label = ..count..), 
            stat = "count", 
            position = position_stack(vjust = 0.5)) + 
  labs(title = "The Total Number of Rides taken by User Type", 
       x = "User Type", 
       y = "Number of Rides") + 
  facet_wrap(~ day_of_week)


# ----------------------------- #
#   BIKE TYPE (RIDEABLE_TYPE)   #
# ----------------------------- #

trip_data_v2 %>% 
  group_by(member_casual, rideable_type) %>%
  summarize(count = n(), .groups = 'drop') %>%
  ggplot(aes(x = member_casual, y = count, fill = rideable_type)) + 
  geom_col(color = "black") + 
  scale_fill_brewer(palette = "Pastel1") + 
  geom_text(aes(label = count), 
            position = position_stack(vjust = 0.5)) + 
  labs(title = "The Number of Rides taken by User Type and Bike Type)", 
       x = "User Type", 
       y = "Number of Rides") + 
  theme(legend.position = "bottom")

trip_data_v2 %>% 
  group_by(member_casual, rideable_type) %>%
  summarize(count = n(), .groups = 'drop') %>%
  mutate(freq = count / sum(count)) %>%
  mutate(per = label_percent()(freq)) %>% 
  ggplot(aes(x = member_casual, fill = rideable_type)) + 
  geom_bar(position = "fill", color = "black") + 
  scale_fill_brewer(palette = "Pastel1") + 
  geom_text(aes(label = count), 
            stat = "count",
            position = position_fill(vjust = 0.5))  + 
  labs(title = "The Number of Rides taken by User Type and Bike Type)", 
       x = "User Type", 
       y = "Number of Rides") + 
  theme(legend.position = "bottom")


# ------------------------- #
#   THE DURATION OF RIDES   #
# ------------------------- #
# 
trip_data_v2 %>% 
    mutate(lower_limit = median(ride_length) - 1.5 * IQR(ride_length),
           upper_limit = median(ride_length) + 1.5 * IQR(ride_length)) %>%
    filter(!(ride_length < lower_limit | ride_length > upper_limit)) %>%
    # filter(!ride_length > 60) %>% 
    ggplot(aes(x = member_casual, y = ride_length, fill = member_casual)) + 
    labs(title = "Total rides taken by members and casual riders", x = "User Type", y = "Ride Length") +
    geom_violin(trim = FALSE) + 
    geom_boxplot(width = 0.1, fill = "white") + 
    # theme_classic() + 
    scale_fill_brewer(palette="Reds") + 
    theme(legend.position = "none")


# ------------------------- #
#   THE DURATION OF RIDES   #
# ------------------------- #

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


# ------------------------- #
#   THE LOCATION OF RIDES   #
# ------------------------- #

# Get map and plot station locations
chicago <- c(left = -87.920354, bottom = 41.642283, right = -87.372821, top = 42.110931)
chicago_map <- get_stamenmap(bbox = chicago, zoom = 13, maptype = "terrain") %>% 
    ggmap(extent = "device", legend = "topleft")
print(chicago_map)

# 
member <- trip_data_v2[which(trip_data_v2$member_casual == "member"), ]
casual <- trip_data_v2[which(trip_data_v2$member_casual == "casual"), ]

# 
popular_station <- chicago_map + 
    stat_density2d(data = trip_data_v2, 
                   mapping = aes(x = start_lng, y = start_lat, fill = ..level.., alpha = ..level..), 
                   size = 2, 
                   bins = 100, 
                   geom = "polygon") + 
    scale_fill_gradient(low = "black", high = "red") +
    facet_wrap(~ day_of_week) + 
    theme(axis.text.x = element_blank(), 
          axis.text.y = element_blank(), 
          axis.ticks = element_blank(), 
          axis.title.x = element_blank(), 
          axis.title.y = element_blank())

# print result
print(popular_station)

# 
popular_casual_station <- chicago_map + 
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

# print result
print(popular_casual_station)

# 
popular_member_station <- ggmap(chicago_map) + 
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

# print result
print(popular_member_station)
