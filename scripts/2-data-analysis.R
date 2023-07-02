## ----------------------------- ##
#####   SET UP ENVIRONMENT   ######
## ----------------------------- ##

# Set default theme
theme_set(theme_bw())

# Convert the 'day_of_week' column to a factor variable with a specified level order
trip_data_v2$day_of_week <- ordered(trip_data_v2$day_of_week, 
                                    levels = c("Monday", 
                                               "Tuesday", 
                                               "Wednesday", 
                                               "Thursday", 
                                               "Friday", 
                                               "Saturday", 
                                               "Sunday"))

# Order the levels of the month from January to December
trip_data_v2$month <- ordered(trip_data_v2$month, 
                              levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                         "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))


## -------------------------------- ##
#####   MAKE DESCRIPTIVE STATS   #####
## -------------------------------- ##

# Calculate descriptive statistics for the 'ride_length' column
trip_data_v2 %>%
  summarize(mean = mean(ride_length), 
            median = median(ride_length), 
            min = min(ride_length), 
            max = max(ride_length), 
            sd = sd(ride_length), 
            count = n())


## ------------------------------- ##
#####   ANALYZE RIDE DURATION   #####
## ------------------------------- ##

###### User Type ######

# Group the data by the 'member_casual' column, calculating the mean and median of 'ride_length' for each group
ride_length_user <- trip_data_v2 %>% 
  group_by(member_casual) %>% 
  summarize(mean_ride_length = mean(ride_length), 
            median_ride_length = median(ride_length))

# Plot a bar chart of average ride length grouped by user type
ggplot(ride_length_user, 
       aes(x = member_casual, 
           y = mean_ride_length, 
           fill = member_casual)) + 
  geom_bar(stat = "identity", 
           color = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  theme(legend.position = "none") + 
  geom_text(aes(label = round(mean_ride_length, 2)), 
            position = position_dodge(width = 0.9), 
            vjust = 2) + 
  labs(x = "User Type", 
       y = "Average Ride Length (mins)")

###### User Type and Day of Week ######

# Group the data by 'member_casual' and 'day_of_week' columns, calculating the mean and median of 'ride_length' for each group
ride_length_user_day <- trip_data_v2 %>% 
  group_by(member_casual, 
           day_of_week) %>% 
  summarize(mean_ride_length = mean(ride_length), 
            median_ride_length = median(ride_length), 
            .groups = "drop")

# Plot a bar chart of average ride length grouped by user type and day of week
ggplot(ride_length_user_day, 
       aes(x = day_of_week, 
           y = mean_ride_length, 
           fill = member_casual)) + 
  geom_bar(stat = "identity", 
           position = "dodge", 
           color = "black") + 
  scale_fill_brewer(palette = "Pastel1") + 
  theme(legend.position = "none") + 
  geom_text(aes(label = round(mean_ride_length, 2)), 
            size = 3, 
            position = position_dodge(width = 0.9), 
            vjust = 2) + 
  labs(x = "User Type", 
       y = "Average Ride Length (mins)")

###### User Type and Month ######

# Group the data by 'member_casual' and 'month' columns, calculating the mean and median of 'ride_length' for each group
ride_length_user_month <- trip_data_v2 %>% 
  group_by(member_casual, 
           month) %>% 
  summarize(mean_ride_length = mean(ride_length), 
            median_ride_length = median(ride_length))

# Plot a line chart of average ride length grouped by user type and month
ggplot(ride_length_user_month, 
       aes(x = month, 
           y = mean_ride_length, 
           group = member_casual, 
           color = member_casual)) + 
  geom_line() + 
  geom_point() + 
  scale_fill_brewer(palette = "Pastel1") + 
  theme(legend.position = "none") + 
  labs(x = "User Type", 
       y = "Average Ride Length (mins)")


## ----------------------------- ##
#####   ANALYZE RIDE NUMBER   #####
## ----------------------------- ##

###### User Type ######

# Group the data by the 'member_casual' column, counting the number of rides for each group
ride_count_user <- trip_data_v2 %>% 
  group_by(member_casual) %>% 
  summarize(ride_count = n())

# Plot a bar chart of ride count grouped by user type
ggplot(ride_count_user, 
       aes(x = member_casual, 
           y = ride_count, 
           fill = member_casual)) + 
  geom_bar(stat = "identity", 
           color = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  theme(legend.position = "none") + 
  geom_text(aes(label = ride_count), 
            position = position_dodge(width = 0.9), 
            vjust = 2) + 
  labs(x = "User Type", 
       y = "Number of Rides")

###### User Type and Day of Week ######

# Group the data by 'member_casual' and 'day_of_week' columns, counting the number of rides for each group
ride_count_user_day <- trip_data_v2 %>% 
  group_by(member_casual, 
           day_of_week) %>% 
  summarize(ride_count = n())

# Plot a bar chart of ride count grouped by user type and day of week
ggplot(ride_count_user_day, 
       aes(x = day_of_week, 
           y = ride_count, 
           fill = member_casual)) + 
  geom_bar(stat = "identity", 
           position = "dodge", 
           color = "black") + 
  scale_fill_brewer(palette = "Pastel1") + 
  theme(legend.position = "none") + 
  geom_text(aes(label = ride_count), 
            size = 3, 
            position = position_dodge(width = 0.9), 
            vjust = 2) + 
  labs(x = "User Type", 
       y = "Number of Rides")

###### User Type and Month ######

# Group the data by 'member_casual' and 'month' columns, counting the number of rides for each group
ride_count_user_month <- trip_data_v2 %>% 
  group_by(member_casual, 
           month) %>% 
  summarize(ride_count = n())

# Plot a line chart of ride count grouped by user type and day of week
ggplot(ride_count_user_month, 
       aes(x = month, 
           y = ride_count, 
           group = member_casual, 
           color = member_casual)) + 
  geom_line() + 
  geom_point() + 
  scale_fill_brewer(palette = "Pastel1") + 
  theme(legend.position = "none") + 
  labs(x = "User Type", 
       y = "Number of Rides")
