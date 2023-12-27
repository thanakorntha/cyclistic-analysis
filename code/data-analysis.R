# ----------------------------------------------------------------------------------------------------
# SETUP
# ----------------------------------------------------------------------------------------------------

# Set personal theme
my_custom_theme <- function(base_size = 14) {
        
  # Font
  font <- ""

  # Replace elements we want to change
  theme_bw(base_size = base_size) %+replace%
    theme(
      #
      ## Grid elements
      panel.grid.minor   = element_blank(),
      panel.grid.major   = element_blank(),
      panel.border       = element_blank(),
      axis.ticks         = element_blank(),
      axis.line.x        = element_line(color = "#343434"),
      axis.ticks.x       = element_line(color = "#343434"),
      axis.line.y        = element_line(color = "#343434"),
      axis.ticks.y       = element_line(color = "#343434"),
      #
      ## Text Elements
      #
      # Title
      plot.title         = element_text(size = rel(1.00), color = "#343434", face = "bold",   hjust = 0, margin = margin(0, 0, 10, 0)),
      plot.subtitle      = element_text(size = rel(0.75), color = "#343434", face = "plain",  hjust = 0),
      plot.caption       = element_text(size = rel(0.50), color = "#343434", face = "italic", hjust = 0),
      # Axis
      axis.title         = element_text(size = rel(0.50), color = "#343434", face = "bold"),
      axis.title.x       = element_text(size = rel(1.00), color = "#343434", face = "bold", margin = margin(5, 0, 5, 0)),
      axis.text          = element_text(size = rel(0.50), color = "#343434", face = "plain"),
      # Legend
      legend.title       = element_blank(),
      legend.text        = element_text(size = rel(0.50), color = "#343434", face = "plain"),
      #
      ## Legend
      legend.position    = "top",
      legend.key         = element_rect(fill = "transparent", color = NA),
      legend.key.size    = unit(1, "lines"),
      legend.background  = element_rect(fill = "transparent", color = NA),
      legend.margin      = margin(0, 0, 0, 0),
      #
      ## Faceting labels
      strip.background = element_rect(fill = "#343434", color = "#343434"),
      strip.text = element_text(size = rel(0.80), color = "white", face = "bold", margin = margin(5, 0, 5, 0))
      #
    )
}

# Change default theme
theme_set(my_custom_theme())


# Define a function to find the mode of a vector 
find_mode <- function(x) {
  u <- unique(x)
  tab <- tabulate(match(x, u))
  u[tab == max(tab)]
}


# Group the data by the 'member_casual' column, calculating stats for each group
stats_user <- trip_data_v2 %>%
  group_by(member_casual) %>%
  summarize(mean_ride_length_min = mean(ride_length_min), 
            median_ride_length_min = median(ride_length_min), 
            min_ride_length_min = min(ride_length_min), 
            max_ride_length_min = max(ride_length_min), 
            sd_ride_length_min = sd(ride_length_min), 
            ride_count = n())

# Group the data by 'member_casual' and 'day_of_week' columns, calculating stats for each group
stats_user_day <- trip_data_v2 %>%
  group_by(member_casual, day_of_week) %>%
  summarize(mean_ride_length_min = mean(ride_length_min), 
            median_ride_length_min = median(ride_length_min), 
            min_ride_length_min = min(ride_length_min), 
            max_ride_length_min = max(ride_length_min), 
            sd_ride_length_min = sd(ride_length_min), 
            ride_count = n(), 
            .groups = "drop")

# Group the data by 'member_casual' and 'hour' columns, calculating stats for each group
stats_user_hour <- trip_data_v2 %>% 
  mutate(hour = as.numeric(format(started_at, "%H"))) %>% 
  group_by(member_casual, hour) %>% 
  summarize(mean_ride_length_min = mean(ride_length_min), 
            median_ride_length_min = median(ride_length_min), 
            min_ride_length_min = min(ride_length_min), 
            max_ride_length_min = max(ride_length_min), 
            sd_ride_length_min = sd(ride_length_min), 
            ride_count = n(), 
            .groups = "drop")

# Group the data by 'member_casual' and 'month' columns, calculating stats for each group
stats_user_month <- trip_data_v2 %>% 
  group_by(member_casual, month) %>% 
  summarize(mean_ride_length_min = mean(ride_length_min), 
            median_ride_length_min = median(ride_length_min), 
            min_ride_length_min = min(ride_length_min), 
            max_ride_length_min = max(ride_length_min), 
            sd_ride_length_min = sd(ride_length_min), 
            ride_count = n(), 
            .groups = "drop")


# ----------------------------------------------------------------------------------------------------
# DATA ANALYSIS
# ----------------------------------------------------------------------------------------------------

# Get summary statistics for 'ride_length_min' column in 'trip_data_v2' data frame 
summary(trip_data_v2$ride_length_min)

# Plot the distribution of 'ride_length_min' column in 'trip_data_v2' data frame 
ggplot(trip_data_v2, aes(x = ride_length_min)) +
  geom_histogram(color = "black", fill = "darkgray") +
  scale_x_continuous(limits = c(0, 40)) +
  scale_y_continuous(limits = c(0, 600000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  labs(x = "Time Duration (in Minutes)", 
       y = "Number of Rides", 
       title = "The distribution of ride lengths (in minutes) shows a slight right \nskew, indicating more rides happen for shorter durations \ncompared to longer ones.") +
  # Add a median line
  geom_vline(xintercept = median(trip_data_v2$ride_length_min), linetype = "dashed", size = 0.50, color = "red") +
  annotate("text", label = "MED", x = median(trip_data_v2$ride_length_min), y = 600000, vjust = 1.25, hjust = -0.25, size = 2.50, color = "red") +
  # Add a mean line
  geom_vline(xintercept = mean(trip_data_v2$ride_length_min), linetype = "dashed", size = 0.50, color = "blue") +
  annotate("text", label = "AVG ", x = mean(trip_data_v2$ride_length_min), y = 600000, vjust = 1.25, hjust = -0.25, size = 2.50, color = "blue") +
  # Add a mode line
  geom_vline(xintercept = find_mode(trip_data_v2$ride_length_min), linetype = "dashed", size = 0.50, color = "darkgreen") +
  annotate("text", label = "MOD", x = find_mode(trip_data_v2$ride_length_min), y = 600000, vjust = 1.25, hjust = -0.25, size = 2.50, color = "darkgreen")


# ----------------------------------------------------------------------------------------------------
# DATA VISUALIZATION
# ----------------------------------------------------------------------------------------------------


# --------------------------------------------------
# USER TYPE
# --------------------------------------------------

# Get median time duration on bikes, by user type
ggplot(stats_user, aes(x = member_casual, y = median_ride_length_min, fill = member_casual)) +
  geom_bar(stat = "identity", color = "black") +
  scale_y_continuous(limits = c(0, 15), expand = c(0, 0)) +
  scale_x_discrete(labels = c("Casual", "Member")) +
  theme(legend.position = "none") +
  labs(x = "User Type", 
       y = "Time Duration (in Minutes)", 
       title = "Median time duration on bikes, by user type") + 
  geom_text(aes(label = round(median_ride_length_min, 2)), position = position_dodge(width = 0.90), vjust = 2)

# Get total number of rides, by user type
ggplot(stats_user, aes(x = member_casual, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", color = "black") +
  scale_y_continuous(limits = c(0, 3500000), labels = unit_format(unit = "M", scale = 1e-6), expand = c(0, 0)) +
  scale_x_discrete(labels = c("Casual", "Member")) +
  theme(legend.position = "none") +
  labs(x = "User Type", 
       y = "Number of Rides", 
       title = "Total number of rides, by user type") + 
  geom_text(aes(label = prettyNum(ride_count, big.mark = ",")), position = position_dodge(width = 0.90), vjust = 2)


# --------------------------------------------------
# DAY OF WEEK
# --------------------------------------------------

# Get median time duration on bikes, by user type and day of week
ggplot(stats_user_day, aes(x = day_of_week, y = median_ride_length_min, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_continuous(limits = c(0, 15), expand = c(0, 0)) +
  scale_fill_discrete(labels = c("Casual", "Member")) +
  labs(x = "Day of Week", 
       y = "Time Duration (in Minutes)", 
       title = "Median time duration on bikes, by user type and day of week") + 
  geom_text(aes(label = round(median_ride_length_min, 2)), position = position_dodge(width = 0.90), hjust = -0.10, angle = 270) +
  geom_hline(yintercept = median(trip_data_v2$ride_length_min), color = "darkgray", linetype = "dashed", size = 0.50) +
  annotate("text", label = "Median", x = 7, y = median(trip_data_v2$ride_length_min), vjust = -0.50, hjust = -0.25, size = 2.50, color = "darkgray")

# Get total number of rides, by user type and day of week 
ggplot(stats_user_day, aes(x = day_of_week, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_continuous(limits = c(0, 550000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) + 
  scale_fill_discrete(labels = c("Casual", "Member")) +
  labs(x = "Day of Week", y = "Number of Rides", title = "Total number of rides, by user type and day of week") + 
  geom_text(aes(label = prettyNum(ride_count, big.mark = ",")), position = position_dodge(width = 0.90), hjust = -0.10, angle = 270)


# --------------------------------------------------
# HOUR
# --------------------------------------------------

# Get median time duration on bikes, by user type and hour
ggplot(stats_user_hour, aes(x = hour, y = median_ride_length_min, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_x_continuous(limits = c(0, 23), breaks = seq(0, 23, 1)) +
  scale_y_continuous(limits = c(0, 15), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(x = "Hour", 
       y = "Time Duration (in Minutes)", 
       title = "Median time duration on bikes, by user type and hour") + 
  geom_hline(yintercept = median(trip_data_v2$ride_length_min), color = "darkgray", linetype = "dashed", size = 0.50) +
  annotate("text", label = "Median", x = 23, y = median(trip_data_v2$ride_length_min), vjust = -0.75, hjust = 0.70, size = 2.50, color = "darkgray")

# Get total number of rides, by user type and hour 
ggplot(stats_user_hour, aes(x = hour, y = ride_count, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_x_continuous(limits = c(0, 23), breaks = seq(from = 0, to = 23, by = 1)) +
  scale_y_continuous(limits = c(0, 350000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(x = "Hour", 
       y = "Number of Rides", 
       title = "Total number of rides, by user type and hour") + 
  annotate("rect", xmin = 8, xmax = 17, ymin = 0, ymax = 350000, alpha = 0.10, fill = "darkorange") +
  geom_vline(xintercept = c(8, 12, 17), linetype = "dashed", size = 0.50, color = "darkorange")


# --------------------------------------------------
# MONTH
# --------------------------------------------------

# Get median time duration on bikes, by user type and month
ggplot(stats_user_month, aes(x = month, y = median_ride_length_min, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_y_continuous(limits = c(0, 15), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(x = "Month", 
       y = "Time Duration (in Minutes)", 
       title = "Median time duration on bikes, by user type and month") + 
  geom_hline(yintercept = median(trip_data_v2$ride_length_min), color = "darkgray", linetype = "dashed", size = 0.50) +
  annotate("text", label = "Median", x = 12, y = median(trip_data_v2$ride_length_min), vjust = -0.75, hjust = 0.70, size = 2.50, color = "darkgray")

# Get total number of rides, by user type and month 
ggplot(stats_user_month, aes(x = month, y = ride_count, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_y_continuous(limits = c(0, 450000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(x = "Month", 
       y = "Number of Rides", 
       title = "Total number of rides, by user type and month") + 
  annotate("rect", xmin = 7, xmax = 8, ymin = 0, ymax = 450000, alpha = 0.10, fill = "darkorange") +
  geom_vline(xintercept = c(7, 8), linetype = "dashed", size = 0.50, color = "darkorange")